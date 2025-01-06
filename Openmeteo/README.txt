variables.txt
- list and explanation of ERA5 variables available via openmeteo

Daily.Rmd
- the main script for accessing the daily weather data via the R `openmeteo` package, and getting it into the database `wm_daily.sqlite`.
- only accessing two vars: `sunshine_duration` and `rain_sum`
- this code makes use of some wrapper functions and loops, to get the data for each subject (field).

###--- Next two scripts pertain to canopy closure prediction ---###
WeatherVars.Rmd
- a relatively short script to create weather vars to be used as predictors in a canopy closure prediction model
- calculates the sum of sunshine duration and rain from planting to the sampling date
- the results are saved to `wm_wvars` object stored in the file `wm_WeatherVars.RData`

WeatherVars_35dap.Rmd
- calculates the `sum of sunshine duration` and `rain` from planting to 35 dap
- these two vars will be used as **inputs** in a fitted model for canopy closure, which will be used to estimate `canopy closure at 35 dap`
- `canopy closure at 35 dap` will be used as a predictor of wm (we hope)
- the results are saved to the object `wm_wvars_35dap` in the file `wm_WeatherVars_35dap.RData`
###--- ---###

RainSummaryVars.Rmd
- creates a var for total rain from planting to 35 dap (pre-bloom).
- creates a var for total rain from 36-50 dap (bloom through early pod fill)
- the two vars are saved in the dataframe rain_vars in the file `rain_vars.RData`
