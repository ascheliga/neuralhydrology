#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP02_1-2_2-1_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:20:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/powell_no_sw_1-2.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/powell_wi_sw_1-2.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/powell_no_sw_2-1.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/powell_wi_sw_2-1.yml
