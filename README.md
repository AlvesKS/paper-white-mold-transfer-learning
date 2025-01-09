# More or less chronological order of the analysis process

## Data Folder

-   contains the underlying datasets (survey, processed weather time series, soils) that will be called by the different scripts to eventually produce engineered and other variables that will be used in the statistical and ML model building stages.
-   these starting data files were scattered across different folders, so were pooled into one location (this folder)

## FunctionalDataAnalysis Folder {.tabset .tabset-fade .tabset-pills}

### FDAExploratory Folder

An exploratory functional analysis of weather and the white mold presence/absence data, making use of the `tidyfun` package. By exploratory, I mean that the mean functional curves for $wm^+$ and $wm^-$ were plotted, as well as the difference between these mean curves.

No statistical analyses (tests of differences between the mean functional curves) were done.

### FunctiononScalar Folder

Perform function-on-scalar regressions of weather time series on white mold presence/absence.

We make use of the `fda` and `refund` packages to set up the regressions (this differs from Kaique's original approach, which use gam functions from the `mgcv` package). The `fda` and `refund` packages are better suited for functional regressions, including data-driven penalization.

Interval-wise tests (iwt) are also done, using Alessia Pini's `fdatest` package.

Based on the iwt, a set of weather-based summary variables were constructed, and saved to `WeatherVars.RData`.

## Openmeteo Folder

-   see the `README.txt` file within this folder for details on the scripts contained therein and what they do
-   basically, the files in this folder pull in daily ERA5 rainfall and sunshine duration data for each location, using the `openmeteo` package, and stores the the time series data in a sqlite database.
-   then, sunshine duration and rainfall variables are calculated to be used as predictors in building a model to fit canopy closure.
-   additional sunshine duration and rainfall variables (from planting to 35 dap) are calculated, to be used as inputs to the fitted model for canopy closure to obtain estimates of canopy closure at 35 dap.
-   two rainfall variables are created, representing the sum of rain during the pre-bloom phase and the bloom through early pod fill phase, to serve as predictors of wm.

## CanopyClosure Folder

-   the purpose of the script in this folder is to build a model for predicting canopy closure at 35 dap, which will be used as a predictor of wm presence/absence later on.
-   the `README.txt` file in this folder gives the background details on the rationale for estimating this variable, and how we go about doing so (it is an engineered feature), because canopy closure at 35 dap is **not** a variable that is present in the wm survey database.

## DataFusion Folder

-   the script in this folder (`FusedData.Rmd`) bring together into one dataframe the different variables that are linked to each field site:
    -   the response (wm), agronomic, soils, canopy closure at 35 dap, rainfall, variables identified from FDA.
-   the final resulting dataset (saved in `FusedData.RData`) is ready for statistical and ML model building

## Modeling Folder

-   now that we have a complete dataset, the analysis can begin
-   the main script is `ModelBuild.Rmd`
-   it produces two RData files as steps during the analysis:
    -   `rf_tuned.RData`
    -   `rf_tuned_sel.RData`

A description of the main tasks:

-   fit a tuned RF model using all available predictors
    -   results saved to `rf_tuned.RData`
    -   examination of the fitted model showed that (i) overfitting may be a real concern, (ii) not all variables may be necessary to include for prediction
-   use `VSURF` to select a smaller set of predictors
-   a tuned RF model was fit to the reduced set of predictors
    -   results saved to `rf_tuned_sel.RData`
    -   no appreciable drop in RF model performance
    -   overfitting still a concern
    -   poor calibration still evident
    -   model-agnostic interpretation, including SHAP importance and dependence plots
-   use the ML results in an interpretive manner to build a LR model for predictive purposes
-   evaluate the LR model using contemporary metrics and decision curve analysis

## Maps folder

-   see the README.txt in this folder for more details
-   the obejctive of the scripts was to create a map showing the locations of the surveyed snap bean fields along with the active weather stations in the region during 2006-2008.
