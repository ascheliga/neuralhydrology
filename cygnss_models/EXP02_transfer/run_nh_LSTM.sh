#!/bin/bash
#SBATCH --job-name=run_nh_LSTM_EXP02_cleanup_att03
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2
#SBATCH --time=00:25:15
#SBATCH --nodes=1
## SBATCH --ntasks-per-node=2

eval "$(conda shell.bash hook)"
conda activate neuralhydrology

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/no_sw_1_2.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/wi_sw_1_2.yml

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/no_sw_2_1.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/wi_sw_2_1.yml

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/no_sw_9_2.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/wi_sw_9_2.yml

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/no_sw_10_1.yml
# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/wi_sw_10_1.yml

# nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/no_sw_9_1.yml
nh-run train --config-file /global/home/users/ann_scheliga/neuralhydrology/cygnss_models/EXP02_transfer/wi_sw_9_1.yml