#!/bin/bash
#SBATCH --job-name=run_nh_cygnss_test_attempt0
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:01:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=3

## Command(s) to run:

eval "$(conda shell.bash hook)"

conda activate neuralhydrology
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/adding_data/custom_with_CYGNSS.yml
