#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Reproduction script for the paper:

    "Computational Modeling and Simulation of Implicit-Explicit Extremist
     Ideology Co-evolution with Dual Thresholds"

This script regenerates the complete simulation dataset (raw data) of the
paper from scratch. It implements the dual-threshold ideology dynamics model
of implicit-explicit extremist ideology co-evolution (Eqs. (1)-(9) of the
paper) in Python/NumPy and executes the full factorial experiment described
in the "Experiment and Analysis" section.

Model summary (equation numbers refer to the paper)
------------------------------------------------------------------
Agents i = 1..N carry A_i = [o_i(t), o^_i(t), mu_i]                      [Eq.(1)]
  o_i  : implicit (private) opinion in [0, 1]; larger = more extreme
  o^_i : explicit (expressed) opinion in [0, 1]
  mu_i : static persistence parameter in (0, 1]

Social relationship attributes                                         [Eq.(2)]
  eps    : relationship threshold (0.60, 0.65, 0.70, 0.75 in the paper)
  delta  : trust threshold (0.60 ... 0.85 in the paper)
  d_ij   : social distance, implemented as the shortest-path distance on the
           social relationship network normalized by the network diameter,
           d_ij in [0, 1]  (implementation choice, see README "Methodology")
  R_ij   : relationship coefficient, drawn uniformly at random, R_ij in [0,1]
  M_ij   : degree of viewpoint expression; equals R_ij
  I(i,j)   = { j : d_ij <= eps }            social relationship set      [Eq.(3)]
  I_1(i,j) = { j in I(i,j) : R_ij >= delta } intimate relationship set   [Eq.(4)]
  I_2(i,j) = { j in I(i,j) : R_ij <  delta } distant relationship set     [Eq.(5)]

Implicit-opinion update                                                [Eq.(6)-(8)]
  o_i(t+1) = o_i(t) + (1 - mu_i) * f(i, R, L)                            [Eq.(6)]
  f(i,R,L) = lam * [ 1/(2 N_1) * SUM_{j in I_1} M_ij (o^_j(t) - o_i(t))
                   + 1/(2 N_2) * Theta(0.5 - mu_i)
                                 * SUM_{j in I_2} M_ij (o^_j(t) - o_i(t)) ]
             + (1 - lam) * Theta(0.5 - mu_i) * L                         [Eq.(7)]
  Theta(a - b) = 0 if a < b;  1 if a >= b                                [Eq.(8)]
  lam : weight of social impact vs. environmental impact
  L   : availability of extreme-ideology "resources" in the social
        environment, L in [0, 0.5]
Terms with empty sets are treated as zero.

Explicit-opinion update                                                [Eq.(9)]
  o^_i(t+1) = mu_i * o_i(t+1) + (1 - mu_i) * o^_avg,i(t)
  o^_avg,i(t) : mean expressed opinion over the relationship set I(i,j)
                (own o^_i(t) if the set is empty; implementation choice)

Initialization
  10 extreme seeds at random positions with o(0)=1, o^(0)=1, mu=1;
  all other agents draw initial opinions uniformly from
  [init-low, init-high] (default [0, 0.3], i.e. non-extreme) and
  persistence mu from [mu-low, mu-high].

Classification (pyramid model of extreme views)
  neutral       : 0     <= o < 0.3
  sympathizer   : 0.3   <= o < 0.8
  extreme       : 0.8   <= o <= 1

Baseline model (--models baseline)
  The original dual-threshold model WITHOUT the implicit-explicit mechanism:
  a single opinion layer o updated with the same rule, in which neighbours'
  implicit opinions replace their expressed opinions, and no Eq.(9) layer.
  Used for the cross-model comparison in Figure 3 of the paper.

Outputs (written to --outdir)
  raw_data_simulation_timeseries.csv : per-step metrics of every run
  raw_data_final_distributions.csv   : final-step opinion histograms (20 bins)
  raw_data_summary_runs.csv          : end-state metrics of every single run
  raw_data_summary_means.csv         : replication-averaged metrics per
                                       parameter group (source of Figure 3)

Usage
  python generate_simulation_dataset.py                        # full dataset
  python generate_simulation_dataset.py --networks general     # one scenario
  python generate_simulation_dataset.py --networks weibo \
         --edge-list data/weibo_edges.csv                      # real network

Requirements: see requirements.txt (numpy, pandas, networkx).
"""

import argparse
import os
import time

import numpy as np
import pandas as pd

try:
    import networkx as nx
except ImportError as exc:  # pragma: no cover
    raise SystemExit("networkx is required: pip install networkx") from exc


# ----------------------------------------------------------------------
# Network generators
# ----------------------------------------------------------------------

def build_network(kind, n_nodes, edge_list, seed):
    """Return (networkx Graph, label)."""
    if kind == "general":
        # Artificial social relationship network: Barabasi-Albert scale-free
        g = nx.barabasi_albert_graph(n_nodes, 4, seed=seed)
        return g, "general"
    if kind == "family":
        # Family-structured network: households (cliques of 3-5 members)
        # connected in a ring of households plus a few random weak ties,
        # reproducing strong-tie closure with sparse external contacts.
        rng = np.random.default_rng(seed)
        g = nx.Graph()
        node = 0
        households = []
        while node < n_nodes:
            size = int(rng.integers(3, 6))  # household of 3-5 members
            members = list(range(node, min(node + size, n_nodes)))
            g.add_nodes_from(members)
            for a in range(len(members)):
                for b in range(a + 1, len(members)):
                    g.add_edge(members[a], members[b])
            households.append(members)
            node += size
        # ring of households: 1-2 bridging edges between consecutive
        # households guarantee connectivity while preserving closure
        for h in range(len(households)):
            for _ in range(int(rng.integers(1, 3))):
                a = int(rng.choice(households[h]))
                b = int(rng.choice(households[(h + 1) % len(households)]))
                if a != b:
                    g.add_edge(a, b)
        # a small number of random weak ties
        for m in list(g.nodes()):
            if rng.random() < 0.02:
                other = int(rng.integers(0, n_nodes))
                if other != m:
                    g.add_edge(m, other)
        if not nx.is_connected(g):
            comp = max(nx.connected_components(g), key=len)
            g = nx.Graph(g.subgraph(comp))
        return nx.convert_node_labels_to_integers(g), "family"
    if kind == "weibo":
        if edge_list and os.path.exists(edge_list):
            df = pd.read_csv(edge_list)
            cols = df.columns.tolist()
            g = nx.from_pandas_edgelist(df, source=cols[0], target=cols[1])
            g = nx.convert_node_labels_to_integers(g)
            comp = max(nx.connected_components(g), key=len)
            g = nx.Graph(g.subgraph(comp))
            return g, "weibo"
        # Surrogate scale-free network when the real edge list is not shipped
        # with the repository (documented in README "Dataset Information").
        g = nx.barabasi_albert_graph(n_nodes, 3, seed=seed)
        return g, "weibo_surrogate"
    raise ValueError("unknown network kind: %s" % kind)


def social_distance_matrix(g):
    """Normalized shortest-path social distance d_ij in [0, 1]."""
    nodes = list(g.nodes())
    sp = dict(nx.all_pairs_shortest_path_length(g))
    n = len(nodes)
    d = np.zeros((n, n), dtype=np.float32)
    for i, ni in enumerate(nodes):
        for nj, dist in sp[ni].items():
            d[i, nj] = dist
    diameter = d.max()
    if diameter > 0:
        d /= diameter
    np.fill_diagonal(d, 0.0)
    return d


# ----------------------------------------------------------------------
# Simulation core
# ----------------------------------------------------------------------

def run_once(rng, d, r, model, eps, delta, steps, args):
    """Run one replication; return per-step metric records and final opinions."""
    n = d.shape[0]

    # --- agent attributes --------------------------------------------
    mu = rng.uniform(args.mu_low, args.mu_high, n).astype(np.float64)
    o = rng.uniform(args.init_low, args.init_high, n)
    o_hat = o.copy()

    # --- extreme seeds -------------------------------------------------
    seed_idx = rng.choice(n, size=args.n_seeds, replace=False)
    o[seed_idx] = 1.0
    o_hat[seed_idx] = 1.0
    mu[seed_idx] = 1.0

    # --- static relationship sets (dual thresholds) ---------------------
    rel = d <= eps                        # I(i,j)                           Eq.(3)
    np.fill_diagonal(rel, False)
    intimate = rel & (r >= delta)         # I_1(i,j)                         Eq.(4)
    distant = rel & (r < delta)           # I_2(i,j)                         Eq.(5)

    n1 = intimate.sum(axis=1).astype(np.float64)
    n2 = distant.sum(axis=1).astype(np.float64)
    n_rel = rel.sum(axis=1).astype(np.float64)

    w1 = intimate * r                     # M_ij weights, M_ij = R_ij
    w2 = distant * r
    s1 = w1.sum(axis=1)
    s2 = w2.sum(axis=1)

    gate = (0.5 >= mu).astype(np.float64)  # Theta(0.5 - mu_i)               Eq.(8)
    one_minus_mu = 1.0 - mu

    records = []
    for t in range(steps + 1):
        if t > 0:
            # ---- social + environmental impact ------------------------ Eq.(7)
            if model == "ie":
                neigh_val = o_hat         # neighbours' expressed opinions
            else:                         # baseline: single opinion layer
                neigh_val = o
            term1 = w1 @ neigh_val - o * s1
            term1 = term1 / (2.0 * np.maximum(n1, 1.0))  # 0 when set empty
            term2 = w2 @ neigh_val - o * s2
            term2 = term2 / (2.0 * np.maximum(n2, 1.0))  # 0 when set empty
            f = args.lam * (term1 + gate * term2) \
                + (1.0 - args.lam) * gate * args.env
            # ---- implicit update -------------------------------------- Eq.(6)
            o = np.clip(o + one_minus_mu * f, 0.0, 1.0)
            # ---- explicit update -------------------------------------- Eq.(9)
            if model == "ie":
                o_hat_avg = np.where(
                    n_rel > 0, (rel @ o_hat) / np.maximum(n_rel, 1), o_hat
                )
                o_hat = np.clip(mu * o + (1.0 - mu) * o_hat_avg, 0.0, 1.0)

        if t % args.record_every == 0 or t == steps:
            if model == "ie":
                ni, ne = o, o_hat
            else:
                ni, ne = o, o  # baseline: identical layers (documented)
            records.append(
                (
                    t,
                    float((ni >= args.extreme_th).sum()),
                    float((ne >= args.extreme_th).sum()),
                    float(((ni >= args.symp_th) & (ni < args.extreme_th)).sum()),
                    float(((ne >= args.symp_th) & (ne < args.extreme_th)).sum()),
                    float(ni.std()),
                    float(ne.std()),
                    float(ni.mean()),
                    float(ne.mean()),
                )
            )
    return records, o, o_hat


# ----------------------------------------------------------------------
# Experiment driver
# ----------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(
        description="Generate the simulation dataset (raw data) of the paper."
    )
    ap.add_argument("--networks", default="general,family,weibo",
                    help="comma list among general, family, weibo")
    ap.add_argument("--edge-list", default="data/weibo_edges.csv",
                    help="optional edge list CSV (src,dst) for the real network")
    ap.add_argument("--n-nodes-general", type=int, default=500)
    ap.add_argument("--n-nodes-family", type=int, default=480)
    ap.add_argument("--n-nodes-weibo", type=int, default=800)
    ap.add_argument("--network-seed", type=int, default=42)
    ap.add_argument("--rel-thresholds", default="0.6,0.65,0.7,0.75")
    ap.add_argument("--trust-thresholds", default="0.6,0.65,0.7,0.75,0.8,0.85")
    ap.add_argument("--replications", type=int, default=10)
    ap.add_argument("--steps", type=int, default=200)
    ap.add_argument("--record-every", type=int, default=2)
    ap.add_argument("--n-seeds", type=int, default=10)
    ap.add_argument("--init-low", type=float, default=0.0)
    ap.add_argument("--init-high", type=float, default=0.3)
    ap.add_argument("--mu-low", type=float, default=0.05)
    ap.add_argument("--mu-high", type=float, default=0.95)
    ap.add_argument("--lam", type=float, default=0.5,
                    help="weight of social vs environmental impact, Eq.(7)")
    ap.add_argument("--env", type=float, default=0.2,
                    help="environmental resource intensity L in [0, 0.5]")
    ap.add_argument("--extreme-th", type=float, default=0.8)
    ap.add_argument("--symp-th", type=float, default=0.3)
    ap.add_argument("--models", default="ie,baseline",
                    help="'ie', 'baseline', or comma list of both")
    ap.add_argument("--seed-base", type=int, default=2026)
    ap.add_argument("--outdir", default="raw_data")
    args = ap.parse_args()

    os.makedirs(args.outdir, exist_ok=True)
    rel_ths = [float(x) for x in args.rel_thresholds.split(",")]
    tru_ths = [float(x) for x in args.trust_thresholds.split(",")]
    models = [m.strip() for m in args.models.split(",")]

    ts_columns = [
        "network", "model", "rel_threshold", "trust_threshold", "replication",
        "t", "n_implicit_extreme", "n_explicit_extreme",
        "n_implicit_sympathizer", "n_explicit_sympathizer",
        "std_implicit", "std_explicit", "mean_implicit", "mean_explicit",
    ]
    ts_rows, dist_rows, run_rows = [], [], []

    t0 = time.time()
    total = 0
    for kind in [k.strip() for k in args.networks.split(",")]:
        n_nodes = {"general": args.n_nodes_general,
                   "family": args.n_nodes_family,
                   "weibo": args.n_nodes_weibo}[kind]
        g, label = build_network(kind, n_nodes, args.edge_list,
                                 args.network_seed)
        d = social_distance_matrix(g)
        n = d.shape[0]
        print("[%s] network built: N=%d, edges=%d, max_dist=%.3f (%.1fs)"
              % (label, n, g.number_of_edges(), d.max(), time.time() - t0))

        adj = nx.to_numpy_array(g, nodelist=range(n), dtype=np.float32)
        for model in models:
            for eps in rel_ths:
                for delta in tru_ths:
                    for rep in range(1, args.replications + 1):
                        rng = np.random.default_rng(
                            args.seed_base + rep * 977
                            + int(eps * 100) * 13 + int(delta * 100) * 7)
                        r = np.where(adj > 0,
                                     rng.uniform(0, 1, (n, n)),
                                     0.0).astype(np.float32)
                        r = np.maximum(r, r.T)  # symmetric relationship
                        records, o, o_hat = run_once(
                            rng, d, r, model, eps, delta, args.steps, args)
                        for rec in records:
                            ts_rows.append([label, model, eps, delta, rep,
                                            *rec])
                        hi, _ = np.histogram(o, bins=20, range=(0, 1))
                        he, _ = np.histogram(o_hat, bins=20, range=(0, 1))
                        for b in range(20):
                            dist_rows.append([
                                label, model, eps, delta, rep, b,
                                b / 20.0, (b + 1) / 20.0,
                                int(hi[b]), int(he[b])])
                        run_rows.append([
                            label, model, eps, delta, rep,
                            records[-1][1], records[-1][2],
                            max(x[1] for x in records),
                            records[-1][5], records[-1][6]])
                        total += 1
                        if total % 100 == 0:
                            print("  ... %d runs done (%.1fs)"
                                  % (total, time.time() - t0))

    ts = pd.DataFrame(ts_rows, columns=ts_columns)
    ts.to_csv(os.path.join(args.outdir,
                           "raw_data_simulation_timeseries.csv"), index=False)

    dist = pd.DataFrame(
        dist_rows, columns=["network", "model", "rel_threshold",
                            "trust_threshold", "replication", "bin",
                            "bin_left", "bin_right",
                            "count_implicit", "count_explicit"])
    dist.to_csv(os.path.join(args.outdir, "raw_data_final_distributions.csv"),
                index=False)

    runs = pd.DataFrame(
        run_rows, columns=["network", "model", "rel_threshold",
                           "trust_threshold", "replication",
                           "final_n_implicit_extreme",
                           "final_n_explicit_extreme",
                           "peak_n_implicit_extreme",
                           "final_std_implicit", "final_std_explicit"])
    runs.to_csv(os.path.join(args.outdir, "raw_data_summary_runs.csv"),
                index=False)

    means = (runs.groupby(["network", "model", "rel_threshold",
                           "trust_threshold"], as_index=False)
             .mean(numeric_only=True)
             .drop(columns=["replication"]))
    means.to_csv(os.path.join(args.outdir, "raw_data_summary_means.csv"),
                 index=False)

    print("Done: %d runs, %d time-series rows -> %s/ in %.1fs"
          % (total, len(ts), args.outdir, time.time() - t0))


if __name__ == "__main__":
    main()
