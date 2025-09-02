#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP07_debug_att02
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2
#SBATCH --time=00:34:15
#SBATCH --nodes=1
# #SBATCH --ntasks-per-node=2



eval "$(conda shell.bash hook)"

conda activate neuralhydrology

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP07_spatial_val/v0_no_sw_1out.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP07_spatial_val/v0_wi_sw_1out.yml
