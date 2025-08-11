from codebase import ml_pipeline
from pathlib import Path
import os
import yaml

yml_path = Path(os.environ["yml_file"])

with yml_path.open("r") as f:
    exp_setup = yaml.safe_load(f)

output_df = ml_pipeline.LSTM_preprocessing_nh(
    exp_setup["grdc_id"],
    exp_setup["grdc_sub_ids"],
    dam_name=exp_setup["dam_name"],
    start_year=exp_setup["start_year"],
    stop_year_ex=exp_setup["stop_year_ex"],
    basin_str=exp_setup["basin_str"],
    save_output=True,
    grdc_dir=exp_setup["grdc_dir"],
    met_dir=exp_setup["met_dir"],
    res_dir=exp_setup["res_dir"],
    basin_data_dir=exp_setup["basin_data_dir"],
)
