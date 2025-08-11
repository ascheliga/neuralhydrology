from pathlib import Path
from datetime import datetime
import matplotlib.pyplot as plt
import pandas as pd
import os

import yaml

print("START EDA PLOTS:", datetime.now())
yml_path = Path(os.environ["yml_file"])

with yml_path.open("r") as f:
    exp_setup = yaml.safe_load(f)


grdc_id = exp_setup["grdc_id"]
grdc_id = str(grdc_id)
dam_name = exp_setup["dam_name"]
dam_name = dam_name.replace(" ", "_").lower()
fp = exp_setup["basin_data_dir"]

save_fp = Path(fp) / Path("_".join(["img_log", grdc_id, dam_name]))
save_fp.mkdir(exist_ok=True)
print("Save dir:", save_fp, flush=True)

fn = "_".join([grdc_id, dam_name]) + ".pkl"

# LOAD DATA
full_dict = pd.read_pickle(Path(fp) / fn)
full_df = full_dict[list(full_dict.keys())[0]]

precip_cols = full_df.columns[full_df.columns.str.contains("precip")]
tempK_cols = full_df.columns[full_df.columns.str.contains("tempK")]

## STREAMFLOW
fig = plt.Figure()
ax = full_df["Q"].plot()
ax.set_ylabel("Flow (m$^3$/s)")
ax.set_title(f"Streamflow at {grdc_id}")
output_name = f"flow_{grdc_id}.png"
plt.savefig(save_fp / output_name)
plt.close()


## SW area
fig = plt.Figure()
ax1 = full_df["SW_area"].plot()
ax1.set_ylabel("SW area (sq. km$^2$)")
ax1.set_title(f"Surface area of {dam_name.capitalize()}")
output_name = f"SWarea_{dam_name}_full.png"
plt.savefig(save_fp / output_name)
plt.close()

fig = plt.Figure()
ax = full_df["SW_area"].dropna().plot()
ax.set_ylabel("SW area (sq. km$^2$)")
ax.set_title(f"Surface area of {dam_name.capitalize()}")
output_name = f"SWarea_{dam_name}_zoom.png"
plt.savefig(save_fp / output_name)
plt.close()


## EACH MET VAR


def plot_single_timeseries_with_colname(input_column):
    plt.Figure()
    ax = input_column.plot()
    var_name = input_column.name
    ax.set_title(var_name)


for col in full_df.iloc[:, 3:]:
    ax = plot_single_timeseries_with_colname(full_df[col])
    output_name = f"{col}_ts.png"
    plt.savefig(save_fp / output_name)
    plt.close()


## MET MULTI-PLOTS


def calc_seasonality(input_df):
    daily_seasonality = input_df.groupby(input_df.index.day_of_year).mean()
    daily_seasonality_full_len = input_df.groupby(input_df.index.day_of_year).transform(
        "mean"
    )
    daily_detrend = input_df - daily_seasonality_full_len

    month_seasonality = input_df.groupby(input_df.index.month).mean()
    month_full_len = input_df.groupby(
        by=[input_df.index.year, input_df.index.month]
    ).mean()
    month_seasonality_full_len = month_full_len.groupby(level=1).transform("mean")

    month_detrend = month_full_len - month_seasonality_full_len

    frame_date = month_detrend.index.to_frame(name=["year", "month"])
    frame_date["day"] = 1
    month_detrend.index = pd.to_datetime(frame_date)

    fig, axs = plt.subplots(figsize=(16, 18))
    plt.axis("off")

    plt_kwargs = {"grid": "on"}
    ax1 = plt.subplot(3, 2, 1)
    daily_seasonality.plot(ax=ax1, **plt_kwargs, title="Daily seasonality")
    ax2 = plt.subplot(3, 2, 2)
    month_seasonality.plot(ax=ax2, **plt_kwargs, title="Monthly seasonality")
    ax3 = plt.subplot(3, 1, 2)
    daily_detrend.plot(ax=ax3, **plt_kwargs, legend=False, title="Anomalies")
    ax4 = plt.subplot(3, 1, 3)
    input_df.plot(ax=ax4, **plt_kwargs, legend=False, title="Full time series")


calc_seasonality(full_df[precip_cols])
output_name = "precip_overlays.png"
plt.savefig(save_fp / output_name)
plt.close()

calc_seasonality(full_df[tempK_cols])
output_name = "tempK_overlays.png"
plt.savefig(save_fp / output_name)
plt.close()


percentile_df = full_df.describe()
percentile_df.to_csv(save_fp / "percentiles.csv")


print("------- DESCRIPTION -------", flush=True)
print(percentile_df, flush=True)
print("------- SHAPE -------", flush=True)
print(full_df.shape, flush=True)
print("END EDA PLOTS:", datetime.now())
