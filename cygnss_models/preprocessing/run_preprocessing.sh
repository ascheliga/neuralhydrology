#!/bin/bash
#SBATCH --job-name=debugging_att02
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2_htc
#SBATCH --time=00:20:15
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2



eval "$(conda shell.bash hook)"
conda activate rioxarray_env

# pre-processing
python LSTM_preprocessing.py