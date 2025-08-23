#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP00_debug_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:03:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/MSE_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/MSE_wi_sw.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/NSE_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/NSE_wi_sw.yml