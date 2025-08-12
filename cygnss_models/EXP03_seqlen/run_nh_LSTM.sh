#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP03_10_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:01:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_wi_sw_10.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_wi_sw_30.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_wi_sw_60.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_wi_sw_90.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_no_sw_10.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_no_sw_30.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_no_sw_60.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/powell_no_sw_90.yml
