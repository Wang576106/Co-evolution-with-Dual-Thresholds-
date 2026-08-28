Co‑evolution of Implicit‑Explicit Extremist Ideologies with Dual Thresholds – NetLogo Simulation

This repository contains the NetLogo implementation of the dual‑threshold co‑evolution model​ for extremist ideology dynamics, as presented in the paper:

Computational Modeling and Simulation of Implicit‑Explicit Extremist Ideology Co‑evolution with Dual Thresholds

The model builds on the Expressed and Private Opinion (EPO) framework and introduces relational threshold​ and trust threshold​ to govern the social interaction scope and depth. It simulates the simultaneous evolution of implicit​ (true) and explicit​ (publicly expressed) extremist attitudes under group pressure, social identity, and environmental influences. Three types of social networks are examined:

Artificial general social network (random/scale‑free)
Family‑structure social network (strong‑tie, closed)
Real online social network (Sina Weibo topology)
Requirements
NetLogo
 6.3.0
No additional libraries or packages are required.
Setup
Clone or download​ this repository.
Open NetLogo.
Load the model file: `File → Open… → model/dual_threshold_model.nlogo or dual_threshold_model-family.nlogo or dual_threshold_model-weibo.nlogo

All simulation parameters are exposed as sliders, choosers, and switches in the NetLogo interface.
Reproducing the Experiments

The paper reports results for three network types. Table 2 in the paper describe the parameter settings used to generate each figure.
Network Selection

Use the network-type​ chooser in the interface to select one of the three networks:

"Artificial" – generated general social network (random graph with given average degree)
"Family" – family‑structure network (predefined strong‑tie clusters)
"Weibo" – real online social network (adjacency list loaded from file)Running a Single Simulation
Set the desired parameters (ε, δ, network type, etc.).
Click Setup​ to initialize the agents.
Click Go​ to run the simulation.
Monitor the plots (number of extreme individuals, standard deviation of opinions) in real time.
Output Files

When running from BehaviorSpace, raw CSV files are saved automatically. For single runs you can export the current state via File → Export → Export All. The results/ directory contains example outputs.

License

This project is licensed under the MIT License​ – see the LICENSE
 file for details.


