#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP05_hidden_att01
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=05:01:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology


# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP05_hiddenstates/general_wi_sw_20.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP05_hiddenstates/general_wi_sw_256.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP05_hiddenstates/general_no_sw_20.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP05_hiddenstates/general_no_sw_256.yml