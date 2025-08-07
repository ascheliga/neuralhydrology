#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP00_MSE_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:10:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/kainji_wi_sw_MSE.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/kainji_no_sw_MSE.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/powell_wi_sw_MSE.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP00_1basin_sw/powell_no_sw_MSE.yml
