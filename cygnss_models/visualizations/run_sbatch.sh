#!/bin/bash
#SBATCH --job-name=panel_map_background_att02
#SBATCH --account=fc_ecohydrology
#SBATCH --partition=savio2
#SBATCH --time=00:15:30
#SBATCH --nodes=1



eval "$(conda shell.bash hook)"
conda activate rioxarray_env

# plotting info
python site_map_individuals.py
