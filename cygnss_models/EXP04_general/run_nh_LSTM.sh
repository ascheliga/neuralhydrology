#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP04_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=01:35:35
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP04_general/ex_inputs/general_no_sw.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP04_general/ex_inputs/general_wi_sw.yml


nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP04_general/tot0_inputs/general_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP04_general/tot0_inputs/general_wi_sw.yml