# Title

**Simulation Code and Dataset for "Computational Modeling and Simulation of
Implicit-Explicit Extremist Ideology Co-evolution with Dual Thresholds"**

This release (v1.0) is the archived, citable version of the code and the raw
simulation data accompanying the above manuscript. Please always download
this release (not the mutable `main` branch) to reproduce the paper's results.

---

# Description

This repository contains the **reproduction script** and the **generated
simulation dataset (raw data)** for a dual-threshold ideology dynamics model
of the co-evolution of implicit (private) and explicit (expressed) extremist
ideologies, built on the Expressed and Private Opinion (EPO) framework.

The model distinguishes an individual's true inner belief (`o_i`, implicit
opinion) from the opinion the individual actually expresses in public
(`o^_i`, explicit opinion), and couples the two layers through a
**relationship threshold** (epsilon, bounding the social-distance range of
interactions) and a **trust threshold** (delta, splitting interaction
partners into intimate and distant relationships). The model is simulated on
three network scenarios:

1. an artificially generated general social relationship network
   (Barabasi-Albert scale-free, N = 500);
2. an artificially generated family-structure social relationship network
   (household cliques connected in a household ring, N = 480); and
3. a real online social network (Sina Weibo). The release ships a
   scale-free surrogate (`weibo_surrogate`, N = 800) so that the dataset is
   self-contained; the script accepts `--edge-list` to run the real Weibo
   network directly.

Key phenomena captured by the model and visible in the raw data:

- **Dual concealment**: the number of implicit extreme individuals
  systematically exceeds the number of explicit extreme individuals, i.e.,
  radicalization persists in a latent form that public expression does not
  reveal;
- **Threshold sensitivity**: systematic dependence of radicalization on the
  relationship and trust thresholds (a complete 4 x 6 parameter grid);
- **Network-structure effects**: differentiated evolutionary trajectories in
  closed strong-tie (family) networks versus open online networks.

---

# Dataset Information

All data files are plain-text CSV (UTF-8, comma separated) and were produced
by `generate_simulation_dataset.py` with the default parameters documented
below. Total size ≈ 20 MB.

| File | Content | Rows |
|------|---------|------|
| `raw_data_simulation_timeseries.csv` | Per-time-step metrics of every simulation run (recorded every 2 steps) | 145,440 |
| `raw_data_final_distributions.csv` | Histogram (20 bins) of implicit and explicit opinions at the final step of every run | 28,800 |
| `raw_data_summary_runs.csv` | Final/peak metrics of each individual run (one row per run) | 1,440 |
| `raw_data_summary_means.csv` | Replication-averaged metrics per parameter group (basis of Figure-3-style comparisons) | 144 |

**Experimental design of the dataset**

- Networks: `general` (N=500), `family` (N=480), `weibo_surrogate` (N=800)
- Models: `ie` (proposed implicit-explicit co-evolution model) and
  `baseline` (dual-threshold model without the implicit-explicit mechanism;
  in this variant implicit and explicit counts coincide by construction)
- Relationship threshold epsilon: 0.60, 0.65, 0.70, 0.75
- Trust threshold delta: 0.60, 0.65, 0.70, 0.75, 0.80, 0.85
- Replications: 10 independent runs per parameter combination
  (random seeds derived deterministically, see the script)
- Time horizon: 200 steps per run

**Column dictionary of `raw_data_simulation_timeseries.csv`**

| Column | Meaning |
|--------|---------|
| `network` | network scenario label |
| `model` | `ie` or `baseline` |
| `rel_threshold` / `trust_threshold` | epsilon / delta of the run |
| `replication` | run index 1-10 |
| `t` | time step |
| `n_implicit_extreme` | #agents with implicit opinion >= 0.8 |
| `n_explicit_extreme` | #agents with explicit opinion >= 0.8 |
| `n_implicit_sympathizer` | #agents with 0.3 <= implicit opinion < 0.8 |
| `n_explicit_sympathizer` | #agents with 0.3 <= explicit opinion < 0.8 |
| `std_implicit` / `std_explicit` | std. deviation of implicit / explicit opinions |
| `mean_implicit` / `mean_explicit` | mean of implicit / explicit opinions |

An opinion value in [0, 1] classifies agents into neutral (< 0.3),
sympathizer ([0.3, 0.8)) and extreme (>= 0.8), following the pyramid
classification used in the paper.

---

# Code Information

| File | Role |
|------|------|
| `generate_simulation_dataset.py` | Single-file, dependency-light reproduction script (Python/NumPy) implementing the model of Eqs. (1)-(9) of the paper and the full experiment grid |
| `requirements.txt` | Python dependencies |
| `LICENSE` | MIT license |
| `README.md` | This documentation |

Structure of the script:

- `build_network()` — constructs the `general`, `family` or `weibo`
  scenario (or loads an external edge list);
- `social_distance()` — normalized shortest-path social distance matrix
  d_ij in [0, 1];
- `run_once()` — executes one simulation run of the `ie` or `baseline`
  model (Eqs. (6)-(9)) and records the metrics;
- `main()` — CLI, experiment grid, CSV export.

Every random draw is obtained from a deterministic NumPy `Generator` seeded
from `--seed-base` (default 2026), so the complete dataset is bit-for-bit
reproducible on any platform.

---

# Usage Instructions

**Option A — reproduce the raw data from scratch**

```bash
# 1. download and unpack the v1.0 release (Code + this README)
# 2. install dependencies (see Requirements)
pip install -r requirements.txt

# 3. full experiment grid (three networks x two models x 4 x 6 thresholds
#    x 10 replications, 200 steps each; takes about 5-6 minutes on one CPU core)
python generate_simulation_dataset.py --outdir raw_data

# sub-experiments:
python generate_simulation_dataset.py --networks general --models ie,baseline \
       --outdir raw_data_general
python generate_simulation_dataset.py --rel-thresholds 0.7 --trust-thresholds 0.8 \
       --replications 5 --steps 200 --outdir quick_test
```

**Option B — run the real Sina Weibo network**

Place the edge list in a two-column CSV (`src,dst`) and run:

```bash
python generate_simulation_dataset.py --networks weibo \
       --edge-list data/weibo_edges.csv --n-nodes 800 --outdir raw_data_weibo
```

**Option C — use the dataset without running anything**

The CSV files in this release are exactly the files produced by Option A
with the default parameters; load them with pandas
(`pd.read_csv("raw_data_simulation_timeseries.csv")`) or any CSV-capable
tool and regenerate every figure/analysis of the paper.

**Useful parameters** (defaults match the paper): `--lambda 0.5` (weight of
social impact vs. environmental resources), `--env 0.2` (environmental
resource intensity L in [0, 0.5]), `--mu-low 0.05 --mu-high 0.95`
(persistence range), `--seeds 10` (number of initial extremist seeds),
`--init-low 0 --init-high 0.3` (initial opinion range of non-seed agents),
`--extreme-th 0.8 --symp-th 0.3` (pyramid classification cut-offs).

---

# Requirements

- Python >= 3.9 (tested with 3.11 / 3.12)
- numpy >= 1.23
- pandas >= 1.5
- networkx >= 2.8
- No GPU is required: all computations run on the CPU. The experiments of
  the paper were executed on a single desktop workstation (CPU-only, NetLogo
  6.2.2 for the original simulations; this Python reproduction script needs
  no CUDA and runs in ~6 minutes for the full grid on one modern CPU core).

---

# Methodology

1. **Network construction.** Each scenario yields an undirected network G
   with adjacency A. The social distance is
   d_ij = shortest-path(i, j) / diameter(G), giving d_ij in [0, 1]
   (d_ii = 0). The original NetLogo implementation uses the spatial layout
   distance; the network-distance implementation is the documented
   simplification of this reproduction script.
2. **Relationship coefficients.** For each connected pair, R_ij ~ U(0, 1)
   (symmetric, R_ij = R_ji), consistent with the random uniform assignment
   described in the paper. The viewpoint-expression degree M_ij is taken as
   R_ij, and the social impact is weighted by it (Eq. (7)).
3. **Interaction sets.** The social relationship set is
   I(i) = {j : d_ij <= epsilon} (Eq. (3)); the intimate and distant sets are
   I1(i) = {j in I(i) : R_ij >= delta} and I2(i) = {j in I(i) : R_ij < delta}
   (Eqs. (4)-(5)).
4. **Initialization.** 10 extremist seeds are placed at random positions
   with o_i(0) = o^_i(0) = 1 and mu_i = 1; all other agents draw initial
   opinions from U(0, 0.3) and persistence from U(0.05, 0.95).
5. **Implicit update.**
   o_i(t+1) = o_i(t) + (1 - mu_i) f(i, R, L)  (Eq. (6)), with
   f(i,R,L) = lambda [ (1/(2 N1)) sum_{j in I1} M_ij (o^_j(t) - o_i(t))
   + (1/(2 N2)) Theta(0.5 - mu_i) sum_{j in I2} M_ij (o^_j(t) - o_i(t)) ]
   + (1 - lambda) Theta(0.5 - mu_i) L   (Eq. (7)),
   where Theta(a - b) = 1 iff a >= b (Eq. (8)), N1, N2 are the sizes of
   I1, I2 (empty sets contribute zero), lambda = 0.5 and L = 0.2 are the
   defaults. Opinions are clipped to [0, 1] after each step.
6. **Explicit update.**
   o^_i(t+1) = mu_i o_i(t+1) + (1 - mu_i) o^_avg,i(t)  (Eq. (9)), where
   o^_avg,i(t) is the mean expressed opinion over the relationship set I(i)
   (falling back to the agent's own expressed opinion when I(i) is empty).
7. **Baseline model.** The `baseline` variant removes the implicit-explicit
   distinction: the single opinion layer o is updated with the same
   influence function using o_j in place of o^_j, and no Eq.-(9) layer
   exists; classification is applied to o.
8. **Metrics.** At every recorded step the script logs the numbers of
   implicit/explicit extreme (>= 0.8) and sympathizer ([0.3, 0.8)) agents,
   and the standard deviation and mean of both opinion layers; final-step
   histograms (20 bins over [0, 1]) and per-run/per-group summaries are
   exported as described in *Dataset Information*.

---

# Citations

If you use this code or dataset, please cite the paper:

```bibtex
@article{wang2026coevo,
  title   = {Computational Modeling and Simulation of Implicit-Explicit
             Extremist Ideology Co-evolution with Dual Thresholds},
  author  = {Wang, [given name]},   % <-- complete the author list
  journal = {[journal name]},       % <-- e.g., Pakistan Journal of Computer Science
  year    = {2026},
  note    = {Simulation code and dataset archived at
             https://github.com/Wang576106/Co-evolution-with-Dual-Thresholds-/releases/tag/v1.0}
}
```

Key references of the model (see the paper's reference list for the full
citations): the Expressed and Private Opinion (EPO) framework (Ye et al.,
2019, *Automatica*); dynamics of coupled implicit and explicit opinions
(Zhang et al., 2024, *Automatica*); the two-pyramids model of radicalization
(McCauley & Moskalenko); and the threshold determination method of Li et al.
(2023).

---

# License & Contribution Guidelines

- **License**: this project is released under the MIT License (see
  `LICENSE`). The dataset generated by the script is distributed under the
  same license.
- **Contributions**: bug reports and improvement suggestions are welcome via
  GitHub Issues; pull requests should (i) target the `main` branch,
  (ii) keep the default parameter set of the paper unchanged, and (iii) add
  a short note to the README when new options are introduced.
- **Citable releases**: each new version will be published as a GitHub
  release; please cite the release tag you used (this paper's results use
  `v1.0`).
- **Contact**: please open a GitHub issue, or contact the corresponding
  author of the paper for data/code questions.
