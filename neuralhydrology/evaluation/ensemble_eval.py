import pandas as pd
import xarray as xr
from neuralhydrology.evaluation import metrics, eval_wrapper


def ensemble_eval_and_results(run_names: list, run_dir: str) -> tuple[list, list]:
    train_results = [None] * len(run_names)
    test_results = [None] * len(run_names)
    for idx, run in enumerate(run_names):
        train_results[idx], test_results[idx] = eval_wrapper.quick_single_eval(
            run, run_dir
        )
    return train_results, test_results


def ensemble_mean_std(ensemble_df: pd.DataFrame) -> pd.DataFrame:
    average = ensemble_df.mean(axis=1).to_frame(name="mean")
    average["std"] = ensemble_df.std(axis=1)
    return average


def Qobs_by_basin(results_list: list) -> dict:
    all_basin_keys = list(results_list[0].keys())
    print(all_basin_keys)

    Qobs_by_basin = {}
    for basin_key in all_basin_keys:
        Qobs_by_basin[basin_key] = pd.concat(
            [
                result[basin_key]["1D"]["xr"]["Q_obs"].to_pandas()
                for result in results_list
            ],
            axis=1,
        )
    return Qobs_by_basin


def Qsims_by_basin(results_list: list) -> dict:
    all_basin_keys = list(results_list[0].keys())
    print(all_basin_keys)

    Qsims_by_basin = {}
    for basin_key in all_basin_keys:
        Qsims_by_basin[basin_key] = pd.concat(
            [
                result[basin_key]["1D"]["xr"]["Q_sim"].to_pandas()
                for result in results_list
            ],
            axis=1,
        )
    return Qsims_by_basin


def ensemble_df_to_nh_dict(Qobs_df: pd.DataFrame, Qsim_df: pd.DataFrame) -> dict:
    Qsim_xr = xr.Dataset.from_dataframe(Qsim_df.add_prefix("Qsim_"))
    Qobs_xr = xr.Dataset.from_dataframe(Qobs_df.add_prefix("Qobs_"))

    # Formatting to match nh structure
    Q_xr = (
        xr.merge([Qsim_xr, Qobs_xr])
        .assign_coords({"time_step": 0})
        .expand_dims("time_step")
        .transpose()
    )
    Q_xr = Q_xr.rename_vars({"Qsim_mean": "Q_sim", "Qobs_mean": "Q_obs"})

    nse = metrics.nse(Q_xr["Q_obs"].isel(time_step=0), Q_xr["Q_sim"].isel(time_step=0))
    nh_dict = {"1D": {"xr": Q_xr, "NSE": nse}}
    return nh_dict


def ensemble_aggregation(results_list: list) -> dict:
    all_Qobs = Qobs_by_basin(results_list)
    Qobs_mean = {key: ensemble_mean_std(all_Qobs[key]) for key in all_Qobs}

    all_Qsims = Qsims_by_basin(results_list)
    Qsim_mean = {key: ensemble_mean_std(all_Qsims[key]) for key in all_Qsims}

    nh_dict = {
        key: ensemble_df_to_nh_dict(Qobs_mean[key], Qsim_mean[key]) for key in Qsim_mean
    }

    return nh_dict


def eval_sw_from_name_lists(
    wisw_exp_names: list, nosw_exp_names: list, run_dir
) -> tuple:
    train_all_nosw, test_all_nosw = ensemble_eval_and_results(nosw_exp_names, run_dir)
    train_all_wisw, test_all_wisw = ensemble_eval_and_results(wisw_exp_names, run_dir)

    nosw_train_ensemble = ensemble_aggregation(train_all_nosw)
    nosw_test_ensemble = ensemble_aggregation(test_all_nosw)
    wisw_train_ensemble = ensemble_aggregation(train_all_wisw)
    wisw_test_ensemble = ensemble_aggregation(test_all_wisw)

    ensemble_results_tuple = (
        wisw_train_ensemble,
        nosw_train_ensemble,
        wisw_test_ensemble,
        nosw_test_ensemble,
    )
    return ensemble_results_tuple
