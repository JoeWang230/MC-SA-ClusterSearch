# High-Throughput-Monte-Carlo-Simulated-Annealing-Simulation
Automated SA-MC Pipeline to Identify Low-Energy Cluster Configurations as a Function of Solute Count

---

## 🧩 Overview
This repository provides input decks and automation scripts for performing **Monte Carlo-based Simulated Annealing(MC-SA) simulations** to identify the lowest-energy cluster structures with varying numbers of solute atoms at 0 K.  

The simulations are carried out using the open-source [**SPPARKS**](https://spparks.github.io/) code (Sandia Parallel PARticle Kinetic Simulator).

---

## ⚙️ Repository Contents

- **`in.diffCE`**  
  Main SPPARKS input script for diffusion-based cluster expansion Monte Carlo simulations.

- **`my.sites.temp`**  
  Initial site file defining the simulation cell and site occupancy.

- **`paramsCE`**  
  Interaction parameter file for the cluster expansion Hamiltonian.

- **`autoMC.sh`**  
  Example Bash script for automating SA-MC runs across different solute concentrations.

- **`checkEnergy.sh`**  
  This utility scans simulation subdirectories named n2_*_n3_* (e.g., n2_15_n3_9), locates the total energy of the final structure.

*(Note: the SPPARKS executable `spk_openmpi` is **not included**. Users must download and compile SPPARKS themselves.)*

---

## 🧠 Requirements

- **SPPARKS** (with MPI support)  
  Download and build from: [https://spparks.github.io/](https://spparks.github.io/)

- **MPI runtime** (e.g. `openmpi` or `mpich`)

- (Optional) **Python 3.x**  
  For post-processing and analysis scripts (if provided in `/analysis`).

---

## 🚀 Usage

1. **Compile SPPARKS**  
   Follow the instructions from the [SPPARKS documentation](https://spparks.github.io/doc/Manual.html) to build `spk_openmpi`.

2. **Run a single MC-SA simulation**  
   ```bash
   mpirun -np 4 ./spk_openmpi -in in.diffCE

3. **Automate multiple MC-SA simulations**  
   ```bash
   bash autoMC.sh

2. **Extract total energies**
   After the simulations finish, run:
   ```bash
   bash checkEnergy.sh
   ```
   This script will collect total energy data from each subdirectory and summarize the lowest-energy configurations for different solute counts.

---

✅ This repository provides a high-throughput automated framework for simulated annealing Monte Carlo runs in SPPARKS, enabling systematic exploration of low-energy cluster configurations as a function of solute number and composition.
