#!/bin/bash
#SBATCH --job-name=ord_extra_ext_met_att01
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:45:30
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2



eval "$(conda shell.bash hook)"
conda activate rioxarray_env

export yml_file='ord_basin.yml'

# pre-processing into DataFrame
python LSTM_preprocessing.py

# plotting info
python eda_preprocessing.py
