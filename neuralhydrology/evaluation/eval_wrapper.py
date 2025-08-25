from pandas import DataFrame
from pathlib import Path
import os
import pickle
from neuralhydrology.nh_run import eval_run
from neuralhydrology.evaluation import comp_plots
from matplotlib import pyplot as plt


def quick_eval(fp_wi_sw, fp_no_sw, run_dir) -> tuple:
    sw_run_dir = Path(run_dir, fp_wi_sw)
    nosw_run_dir = Path(run_dir, fp_no_sw)

    print(sw_run_dir)

    if not os.path.exists(sw_run_dir / "test" / "model_epoch050"):
        eval_run(run_dir=sw_run_dir, period="test")
    if not os.path.exists(sw_run_dir / "train" / "model_epoch050"):
        eval_run(run_dir=sw_run_dir, period="train")
    if not os.path.exists(sw_run_dir / "validation" / "model_epoch050"):
        eval_run(run_dir=sw_run_dir, period="validation")
    print("Evaluation complete of", sw_run_dir)

    print(nosw_run_dir)
    if not os.path.exists(nosw_run_dir / "test" / "model_epoch050"):
        eval_run(run_dir=nosw_run_dir, period="test")
    if not os.path.exists(nosw_run_dir / "train" / "model_epoch050"):
        eval_run(run_dir=nosw_run_dir, period="train")
    if not os.path.exists(nosw_run_dir / "validation" / "model_epoch050"):
        eval_run(run_dir=nosw_run_dir, period="validation")
    print("Evaluation complete of", nosw_run_dir)

    with open(sw_run_dir / "train" / "model_epoch050" / "train_results.p", "rb") as fp:
        sw_train_results = pickle.load(fp)
        print(sw_train_results.keys())

    with open(
        nosw_run_dir / "train" / "model_epoch050" / "train_results.p", "rb"
    ) as fp:
        nosw_train_results = pickle.load(fp)
        print(nosw_train_results.keys())

    with open(sw_run_dir / "test" / "model_epoch050" / "test_results.p", "rb") as fp:
        sw_test_results = pickle.load(fp)
        print(sw_test_results.keys())

    with open(nosw_run_dir / "test" / "model_epoch050" / "test_results.p", "rb") as fp:
        nosw_test_results = pickle.load(fp)
        print(nosw_test_results.keys())

    print("Loaded model results")
    return sw_train_results, nosw_train_results, sw_test_results, nosw_test_results


def runs_to_nse_df(metrics_tuple: tuple, tuple_names: list = []) -> DataFrame:
    list_of_lists = [None] * len(metrics_tuple)
    for idx, run in enumerate(metrics_tuple):
        list_of_lists[idx] = {key: run[key]["1D"]["NSE"] for key in run}
    metrics_df = DataFrame(list_of_lists)
    if tuple_names:
        metrics_df.index = tuple_names
    return metrics_df


def quick_basin_plot(
    sw_train_results,
    nosw_train_results,
    sw_test_results,
    nosw_test_results,
    basin_key="",
) -> DataFrame:
    if len(basin_key) < 1:
        basin_key = list(sw_test_results.keys())[0]
        print("Plotting basin_key", basin_key)

    fig, axs = plt.subplots(2, 2, figsize=(16, 10))

    value_dict = {}

    value_dict["SW train"] = comp_plots.plot_obs_sim_timeseries(
        axs[0, 0], sw_train_results[basin_key]["1D"], "SW train"
    )
    value_dict["SW test"] = comp_plots.plot_obs_sim_timeseries(
        axs[0, 1], sw_test_results[basin_key]["1D"], "SW test"
    )
    value_dict["No SW train"] = comp_plots.plot_obs_sim_timeseries(
        axs[1, 0], nosw_train_results[basin_key]["1D"], "No SW train"
    )
    value_dict["No SW test"] = comp_plots.plot_obs_sim_timeseries(
        axs[1, 1], nosw_test_results[basin_key]["1D"], "No SW test"
    )

    metrics_df = DataFrame(value_dict)

    return metrics_df
