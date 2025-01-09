Plot_Covs <- function(Covs, Shp = NULL) {
  Plots_ls <- as.list(rep(NA, nlayers(Covs[[1]]) * 2)) # create as many plots as there are covariates variables * 2
  Counter <- 1 # counter for list position
  for (Variable in 1:nlayers(Covs[[1]])) { # loop over all covariate variables
    Covs_Iter <- list(Covs[[1]][[Variable]], Covs[[2]][[Variable]]) # extract the data for this variable
    for (Plot in 1:2) { # loop over both resolutions for the current variable
      Cov_df <- as.data.frame(Covs_Iter[[Plot]], xy = TRUE) # turn raster into data frame
      colnames(Cov_df)[3] <- "Values" # assign a column name to the data column
      Plots_ls[[Counter]] <- ggplot() + # create plot
        geom_raster(data = Cov_df, aes(x = x, y = y, fill = Values)) + # plot the covariate data
        theme_bw() +
        labs(x = "Longitude", y = "Latitude") + # make plot more readable
        scale_fill_gradientn(name = names(Covs_Iter[[Plot]]), colours = cividis(100)) + # add colour and legend
        theme(plot.margin = unit(c(0, 0, 0, 0), "cm")) # reduce margins (for fusing of plots)
      if (!is.null(Shp)) { # if a shape has been designated
        Plots_ls[[Counter]] <- Plots_ls[[Counter]] + geom_polygon(data = Shp, aes(x = long, y = lat, group = group), colour = "black", fill = "NA") # add shape
      }
      Counter <- Counter + 1 # raise list counter
    } # end of resolution loop
  } # end of variable loop
  ggPlot <- plot_grid(plotlist = Plots_ls, ncol = 2, labels = "AUTO") # fuse the plots into one big plot
  return(ggPlot)
}