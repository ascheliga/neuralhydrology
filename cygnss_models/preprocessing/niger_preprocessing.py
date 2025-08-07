from codebase import ml_pipeline

## Experimental set-up
grdc_id = 1834101
grdc_sub_ids = [
    1834110
]  # [4152450,4152600] ## MUST BE ORDERED DOWNSTREAM (first) TO UPSTREAM (last)
dam_name = "kainji"
start_year = 2018
stop_year_ex = 2024
basin_str = "niger"

## Filepaths
grdc_dir = "/global/scratch/users/ann_scheliga/aux_dam_datasets/GRDC_CRB/"
met_dir = "/global/scratch/users/ann_scheliga/era5_data/"
res_dir = "/global/scratch/users/ann_scheliga/CYGNSS_daily/time_series/"
basin_data_dir = "/global/scratch/users/ann_scheliga/basin_forcing_processed/"

output_df = ml_pipeline.LSTM_preprocessing_nh(
    grdc_id,
    grdc_sub_ids,
    dam_name=dam_name,
    start_year=start_year,
    stop_year_ex=stop_year_ex,
    basin_str=basin_str,
    save_output=True,
    grdc_dir=grdc_dir,
    met_dir=met_dir,
    res_dir=res_dir,
    basin_data_dir=basin_data_dir,
)

print("------- DESCRIPTION -------", flush=True)
print(output_df.describe(), flush=True)
print("------- SHAPE -------", flush=True)
print(output_df.shape, flush=True)
