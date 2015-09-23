# Instructions from Course Project description for part 1- Shiny app
# 
# Your Shiny Application
# 1. Write a shiny application with associated supporting documentation. 
#    The documentation should be thought of as whatever a user will need to get started using your application.
# 2. Deploy the application on Rstudio's shiny server
# 3. Share the application link by pasting it into the text box below
# 4. Share your server.R and ui.R code on github
#
# The application must include the following:
# 1. Some form of input (widget: textbox, radio button, checkbox, ...)
# 2. Some operation on the ui input in sever.R
# 3. Some reactive output displayed as a result of server calculations
# 4. You must also include enough documentation so that a novice user could use your application.
# 5. The documentation should be at the Shiny website itself. Do not post to an external link.


library(shiny)
library(datasets)
data(mtcars)

# Define UI for application that allows user to select a predictor variable from the
# mtcars dataset for use in a linear model to predict mpg. User can also choose a
# a simple transformation to apply to the variable.
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Evaluate Individual Predictors of mpg Using Linear Regression"),

  # Sidebar with predictor variable, and transformation selection.
  sidebarLayout(
    sidebarPanel(
      h3('Select Predictor'),
      selectInput('predvar', 'Select Predictor Variable:',
                  choices = names(mtcars)[-1]),
      radioButtons("trns", "Select Predictor Transformation:",
                   c("Unmodified" = "none",
                     "Log10" = "lg10",
                     "Sqare Root" = "sqrt",
                     "Square" = "sq")),
      checkboxGroupInput("intrvls", "Select Intervals to Plot:",
                         c("Confidence" = "cnfdnc",
                           "Prediction" = "prd"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot",plotOutput("lmplot")),
        tabPanel("lm() Summary",
                 p(" "),
                 verbatimTextOutput("formla"),
                 p(" "),
                 verbatimTextOutput("lmsummry")),
        tabPanel("Residual Analysis Plots",
                 plotOutput("residplots"),
                 h5(a("plot.lm() Help", href="https://stat.ethz.ch/R-manual/R-patched/library/stats/html/plot.lm.html", target="_blank"))
                 ),
        tabPanel("Help",
                 h4("Purpose"),
                 p("mtcars_Explorer is an interactive Shiny app that allows a user", 
                   "to evaluate individual predictor variables from the",
                   a("mtcars dataset", href="https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", target="_blank"),
                   "as predictors of the response variable mpg. The link above is to the ",
                   "description of the mtcars dataset which describes the variables it contains."
                 ),
                 h4("Controls"),
                 p("The sidebar panel provides 3 controls that enable:"),
                 tags$ul(
                   tags$li("Selection of one predictor variable,"),
                   tags$li("Selection of one data transformation to apply to the predictor variable,"),
                   tags$li("Optional plotting of lines for the prediction and confidence intervals.")
                 ),
                 h4("Processing"),
                 p("If a transformation is selected, then it is applied to the selected predictor", 
                   "variable in the formula passed to the", 
                   a("lm()",href="https://stat.ethz.ch/R-manual/R-patched/library/stats/html/lm.html", target="_blank"),
                   "function.  If prediction intervals or", 
                   "confidence intervals are selected then those predictions are calculated using the",
                   a("predict.lm()",href="https://stat.ethz.ch/R-manual/R-patched/library/stats/html/predict.lm.html", target="_blank"),
                   "function."
                 ),
                 h4("Output Tabs on Main Panel"),
                 p(strong("Plot - "),"A scatter plot with the regression line calculated using linear",
                   "regression. If prediction or confidence intervals were requested",
                   "then lines are included that should the upper and lower bounds",
                   "of those intervals. The confidence interval calculated at the 95% confidence level",
                   "represents the certainty associated with the model represented by the regression line.",
                   "The prediction interval calculated at the 95% confidence level",
                   "represents the certainty associated with the predictions of mpg given at each",
                   "value of the transformed predictor variable. Narrower bands represent higher certainty."),
                 p(strong("lm() Summary - "),"This tab is intended for advanced users.",
                   "The ouput of summary.lm() for the formula constructed based on the",
                   "selected predictor variable and transformation. The R function ",
                   a("summary.lm()", href="https://stat.ethz.ch/R-manual/R-patched/library/stats/html/summary.lm.html", target="_blank"),
                   "provides an explanation of the output."),
                 p(strong("lm() Residual Analysis Plots - "),"This tab is intended for advanced users.",
                   "The plots are generated using plot.lm() and are used to diagnose problems with", 
                   "the data or models.",
                   a("plot.lm()",href="https://stat.ethz.ch/R-manual/R-patched/library/stats/html/plot.lm.html", target="_blank"),
                   "provides an explanation of the output."),
                 p(strong("Source Code -"), "The source code for this Shiny app is available on",
                   a("github.",href="https://github.com/wilton2182/DevelopingDataProducts-ShinyApp", target="_blank"))
        )
      )
    )
    
    )
  )
)
