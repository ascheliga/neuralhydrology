#!/bin/bash
#SBATCH --job-name=run_nh_test_attempt2
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio3_htc
#SBATCH --time=00:10:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

## Command(s) to run:

eval "$(conda shell.bash hook)"

conda activate neuralhydrology
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/examples/01-Introduction/1_basin.yml
