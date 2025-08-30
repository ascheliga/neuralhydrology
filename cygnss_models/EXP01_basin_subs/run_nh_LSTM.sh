#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP01_debug_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2
#SBATCH --time=00:04:15
#SBATCH --nodes=1
# #SBATCH --ntasks-per-node=2



eval "$(conda shell.bash hook)"

conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP01_basin_subs/no_subs_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP01_basin_subs/no_subs_wi_sw.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP01_basin_subs/wi_subs_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP01_basin_subs/wi_subs_wi_sw.yml
