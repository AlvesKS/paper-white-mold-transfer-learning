Objective:
Estimate canopy closure at 35 dap (beginning of bloom).

Why?
To use it as a predictor in models for wm presence/absence.
In the previous work (BRTs), did find that canopy closure was a predictor of wm risk.
Steadman's work also argued that canopy closure by bloom increased the risk of white mold.
However, Kaique's work did not use canopy closure as a predictor.
Including canopy closure as a predictor:
(i) utilizes/expands on the previous work by Steadman and ourselves (the BRT modeling)
(ii) increases the candidate set of vars available for modeling

Why do we need to estimate it?
Because canopy closure was measured at different times relative to planting and also different amount of times per field.  There is no existing variable in the survey dataset that is canclos at 35 dap.
This is an example of an engineered feature.
We used RF to estimate canopy closure at 35 dap (cc35) for each field, making use of available covariates in the survey matrix to build a model for estimating cc35.
The prepped data for this estimation (cc.df) are saved to the file "canclos.RData"
The RF model used to estimate cc35 (rf3) is saved to the file "tunedRF.RData"

The final cc35 values for each field (in the object cc.df.35dap) are saved to the file "cc.df.35dap.RData" 
