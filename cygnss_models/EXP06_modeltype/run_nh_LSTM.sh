#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP06_modeltype_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:45:35
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP06_modeltype/ealstm_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP06_modeltype/ealstm_wi_sw.yml


nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP06_modeltype/cuda_no_sw.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP06_modeltype/cuda_wi_sw.yml