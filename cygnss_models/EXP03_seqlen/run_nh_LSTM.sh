#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP03_multi_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=01:03:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_wi_sw_10.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_wi_sw_30.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_wi_sw_60.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_wi_sw_90.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_wi_sw_270.yml

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_no_sw_10.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_no_sw_30.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_no_sw_60.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_no_sw_90.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP03_seqlen/multi_basin/general_no_sw_270.yml