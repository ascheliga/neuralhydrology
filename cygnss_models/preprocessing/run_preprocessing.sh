#!/bin/bash
#SBATCH --job-name=crb_extra_ext_met_att02
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=01:45:30
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2



eval "$(conda shell.bash hook)"
conda activate rioxarray_env

export yml_file='ord_basin.yml'

# pre-processing into DataFrame
python LSTM_preprocessing.py

# plotting info
python eda_preprocessing.py
