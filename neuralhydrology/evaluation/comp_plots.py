from neuralhydrology.evaluation import metrics, eval_wrapper


def plot_obs_sim_timeseries(ax, nh_dict, period=""):
    qobs = nh_dict["xr"]["Q_obs"]
    qsim = nh_dict["xr"]["Q_sim"]

    ax.plot(qobs["date"], qobs, c="k", label="obs")
    ax.plot(qsim["date"], qsim, c="b", label="sim")
    ax.set_ylabel("Discharge (mm/d)")
    ax.set_title(f"{period} period - NSE {nh_dict['NSE']:.3f}")
    values = metrics.calculate_all_metrics(
        qobs.isel(time_step=-1), qsim.isel(time_step=-1)
    )

    return values


def boxplot_from_tuple(metrics_tuple, ax, tuple_names=[], exp_name=[]):
    nse_df = eval_wrapper.runs_to_nse_df(metrics_tuple, tuple_names)
    nse_df.T.boxplot(ax=ax)
    ax.set_title(exp_name)
    ax.axhline(c="gray")
    ax.set_ylabel("NSE")
    return nse_df
