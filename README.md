# High-Throughput-Simulating-Annealing-Monte-Carlo-Simulation
Automated SA-MC Pipeline to Identify Low-Energy Cluster Configurations as a Function of Solute Count

This repository provides input decks and automation scripts for performing **Simulated Annealing–Monte Carlo (SA-MC) simulations** to identify the lowest-energy cluster structures with varying numbers of solute atoms.  

The simulations are carried out using the open-source [SPPARKS](https://spparks.github.io/) code (Sandia Parallel PARticle Kinetic Simulator).

---

## Repository Contents

- **in.diffCE**  
  Main SPPARKS input script for diffusion-based cluster expansion Monte Carlo simulations.

- **my.sites.temp**  
  Initial site file defining the simulation cell and site occupancy.

- **paramsCE**  
  Interaction parameter file for the cluster expansion Hamiltonian.

- **autoMC.sh**  
  Example Bash script for automating SA-MC runs across different solute concentrations.

*(Note: the SPPARKS executable `spk_openmpi` is **not included**. Users must download and compile SPPARKS themselves.)*

---

## Requirements

- **SPPARKS** (with MPI support)  
  Download and build from: [https://spparks.github.io/](https://spparks.github.io/)

- **MPI runtime** (e.g. `openmpi` or `mpich`)

- (Optional) **Python 3.x**  
  For post-processing and analysis scripts (if provided in `/analysis`).

---

## Usage

1. **Compile SPPARKS**  
   Follow the instructions from the [SPPARKS documentation](https://spparks.github.io/doc/Manual.html) to build `spk_openmpi`.

2. **Run a single SA-MC simulation**  
   ```bash
   mpirun -np 4 ./spk_openmpi -in in.diffCE
