library(shiny)
library(ggplot2)

shinyServer(function(input, output) {

  # Fit the model once when the app starts
  model <- lm(mpg ~ wt + factor(cyl), data = mtcars)

  # Recompute the prediction only when the user clicks "Predict MPG"
  predicted <- eventReactive(input$go, {
    newdata <- data.frame(wt = input$weight, cyl = as.numeric(input$cyl))
    predict(model, newdata = newdata)
  }, ignoreNULL = FALSE)

  output$prediction <- renderText({
    paste0(round(predicted(), 1), " MPG")
  })

  output$mpgPlot <- renderPlot({
    newPoint <- data.frame(wt = isolate(input$weight),
                            cyl = isolate(as.numeric(input$cyl)),
                            mpg = predicted())

    ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
      geom_point(size = 3, alpha = 0.7) +
      geom_point(data = newPoint, aes(x = wt, y = mpg),
                 color = "red", size = 6, shape = 8, inherit.aes = FALSE) +
      labs(title = "mtcars: Weight vs. MPG (your prediction shown as a red star)",
           x = "Weight (1000 lbs)",
           y = "Miles per Gallon",
           color = "Cylinders") +
      theme_minimal(base_size = 14)
  })

})
