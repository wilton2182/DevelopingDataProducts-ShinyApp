# DevelopingDataProducts-ShinyApp
mtcars Explorer is the Shiny app code for part 1 of the project for Developing Data Products.

The app is deployed on shinyapps.io at https://wilton2182.shinyapps.io/DevelopingDataProducts-ShinyApp and this repo contains the ui.R and server.R files of the shiny app. The app has a Help tab that gives an overview of the app.  That same help text is shown below.

There is a [R Presentation in RPubs](https://rpubs.com/dpwilt57/111396) that describes the app including R functions used to generate the output.  There is also a [slidify presentation](https://wilton2182.github.io/mtcars-Explorer-slidify/index.html#1) in github.  The slidify presentation is the one submitted for the project, and the code for that presentation is also available in [github](https://github.com/wilton2182/mtcars-Explorer-slidify/tree/gh-pages).

## mtcars Explorer Help

### Purpose  

mtcars_Explorer is an interactive Shiny app that allows a user to evaluate individual predictor variables from the [mtcars dataset](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html) as predictors of the response variable mpg. The link above is to the description of the mtcars dataset which describes the variables it contains.  

### Controls  

The sidebar panel provides 3 controls that enable:  

* Selection of one predictor variable,  
* Selection of one data transformation to apply to the predictor variable,  
* Optional plotting of lines for the prediction and confidence intervals.  
 
### Processing  

If a transformation is selected, then it is applied to the selected predictor variable in the formula passed to the [lm()](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/lm.html) function. If prediction intervals or confidence intervals are selected then those predictions are calculated using the [predict.lm()](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/predict.lm.html) function.  

### Output Tabs on Main Panel  

**Plot** - A scatter plot with the regression line calculated using linear regression. If prediction or confidence intervals were requested then lines are included that should the upper and lower bounds of those intervals. The confidence interval calculated at the 95% confidence level represents the certainty associated with the model represented by the regression line. The prediction interval calculated at the 95% confidence level represents the certainty associated with the predictions of mpg given at each value of the transformed predictor variable. Narrower bands represent higher certainty.  

**lm() Summary** - This tab is intended for advanced users. The ouput of summary.lm() for the formula constructed based on the selected predictor variable and transformation. The R function [summary.lm()](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/summary.lm.html) provides an explanation of the output.  

**lm() Residual Analysis Plots** - This tab is intended for advanced users. The plots are generated using plot.lm() and are used to diagnose problems with the data or models. [plot.lm()](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/plot.lm.html) provides an explanation of the output.  

