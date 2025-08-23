#!/bin/bash
#SBATCH --job-name=saluda_att00
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=01:45:30
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2



eval "$(conda shell.bash hook)"
conda activate rioxarray_env

export yml_file='saluda_river.yml'

# pre-processing into DataFrame
python LSTM_preprocessing.py

# plotting info
python eda_preprocessing.py
