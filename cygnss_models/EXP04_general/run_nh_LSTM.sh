#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP02_12_21_att02
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:04:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP04_general/general_no_sw.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP04_general/general_wi_sw.yml