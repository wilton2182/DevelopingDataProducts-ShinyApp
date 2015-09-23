shinyServer(function(input, output) {
  
  library(datasets)
  data(mtcars)
  
  # Build formula based on inputs.
  lmForm <- reactive({
    paste('mpg ~ ', switch(
      input$trns, 
      none = input$predvar,
      sqrt = paste('I(sqrt(',input$predvar,'))'), 
      lg10 = paste('I(log10(',input$predvar,'))'), 
      sq = paste('I(',input$predvar,'^2)')
      )
    )
  })

  # Generate regression model based on inputs.
  fitlm <- reactive({
    lmFormula <-  as.formula(lmForm())
    lmmod <- lm(lmFormula, data=mtcars)
    return(lmmod)
  })
  
  # Generate a set of X values for prediction from selected predictor.
  newX <- reactive({
    xvar <- input$predvar
    x <- mtcars[,xvar]
    vals <- seq(min(x),max(x),by=(max(x)-min(x))/100)
    return(vals)
  })
  
  trnsX <- reactive({
    x <- newX()
    x <- switch(
      input$trns, 
      none = x,
      sqrt = sqrt(x), 
      lg2 = log2(x),
      lg10 = log10(x),
      sq = x^2, 
      cb = x^3
    )
    return(x)
  })
  
  # Make a data frame from x values for prediction.
  newxDF <- reactive({
    xVals <- newX()
    thedf <- data.frame(x=xVals)
    colnames(thedf) <- input$predvar
    return(thedf)
  })
  
  # Generate a confidence interval for lm model.
  cnf <- reactive({
    predict(fitlm(),newxDF(),interval=("confidence"))
  })
  
  # Generate a prediction interval for lm model.
  prd <- reactive({
    predict(fitlm(),newxDF(),interval=("prediction"))
  })

  # Plot data with regression lines
  output$lmplot <- renderPlot({         
    # par(mar = c(4, 4, .1, .1))
    lmFormula <-  as.formula(lmForm())

    plot(lmFormula, data = mtcars, pch = 19)
    title(lmForm(),outer=FALSE)
    abline(fitlm(), col = 'black', lwd = 2)

    ints <- input$intrvls
    if (is.null(ints)) {
      legend("topright", 
             legend = c("Regression Line"), 
             lty = 1, 
             col = c("black")
             )
    } else if (length(ints)== 2) {
      matlines(trnsX(),cnf()[,c("lwr","upr")],col="red",lty=1,type="l")
      matlines(trnsX(),prd()[,c("lwr","upr")],col="blue",lty=1,type="l")
      legend("topright", 
             legend = c("Regression Line","Confidence Interval", "Prediction Interval"), 
             lty = 1, 
             col = c("black","red", "blue")
             )
    } else if (ints== c("cnfdnc")) {
      matlines(trnsX(),cnf()[,c("lwr","upr")],col="red",lty=1,type="l")
      legend("topright", 
             legend = c("Regression Line","Confidence Interval"), 
             lty = 1, 
             col = c("black", "red")
             )
    } else if (ints== c("prd")) {
      matlines(trnsX(),prd()[,c("lwr","upr")],col="blue",lty=1,type="l")
      legend("topright", 
             legend = c("Regression Line","Prediction Interval"), 
             lty = 1, 
             col = c("black", "blue")
             )
    } else {}
  })
  
  # Show the lm() summary for the linear regression model
  output$lmsummry <- renderPrint({
    return(summary(fitlm()))
  })
  output$formla <- renderPrint({paste("lmFormula = ",lmForm())})

  # Analyze residuals for the linear regression model
  output$residplots <- renderPlot({
    par(mfrow=c(2,2))
    residplts <- plot(fitlm())
    return(summary(residplts))
  })

})