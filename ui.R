library(shiny)

shinyUI(fluidPage(

  titlePanel("MPG Predictor: How Weight & Cylinders Affect Fuel Economy"),

  sidebarLayout(
    sidebarPanel(
      h4("Choose your car's specs"),
      sliderInput("weight",
                   "Car weight (in 1,000 lbs):",
                   min = 1.5,
                   max = 5.5,
                   value = 3.2,
                   step = 0.1),
      radioButtons("cyl",
                    "Number of cylinders:",
                    choices = c("4 cylinders" = 4,
                                "6 cylinders" = 6,
                                "8 cylinders" = 8),
                    selected = 4),
      hr(),
      actionButton("go", "Predict MPG", class = "btn-primary"),
      hr(),
      helpText("Prediction is based on a linear regression model fit to the",
               "built-in mtcars dataset (32 cars, 1973-74 models).")
    ),

    mainPanel(
      tabsetPanel(
        type = "tabs",

        tabPanel("Prediction",
                 br(),
                 h3("Predicted Fuel Economy"),
                 h2(textOutput("prediction")),
                 br(),
                 plotOutput("mpgPlot")
        ),

        tabPanel("Documentation",
                 br(),
                 h3("How to use this app"),
                 tags$ol(
                   tags$li("Move the ", tags$b("weight slider"), " on the left to set your car's weight, in thousands of pounds (e.g. 3.2 = 3,200 lbs)."),
                   tags$li("Pick the number of ", tags$b("cylinders"), " your car has using the radio buttons (4, 6, or 8)."),
                   tags$li("Click the ", tags$b("'Predict MPG'"), " button."),
                   tags$li("Go to the ", tags$b("'Prediction'"), " tab to see:"),
                   tags$ul(
                     tags$li("The predicted miles-per-gallon (MPG) for a car with those specs."),
                     tags$li("A scatter plot of the mtcars dataset (weight vs. MPG, colored by cylinder count), with your prediction marked as a large red star.")
                   )
                 ),
                 h3("What's happening behind the scenes"),
                 p("This app fits a linear regression model, ",
                   tags$code("lm(mpg ~ wt + factor(cyl), data = mtcars)"),
                   ", to R's built-in ", tags$code("mtcars"), " dataset. When you move the slider ",
                   "or change the cylinder selection and click Predict, the app plugs your chosen ",
                   "weight and cylinder count into that model and calculates an expected MPG value."),
                 h3("About the data"),
                 p("mtcars comes pre-loaded with R and contains fuel consumption and 10 other ",
                   "measurements for 32 automobiles from 1973-74 issues of Motor Trend magazine."),
                 h3("No installation needed"),
                 p("Everything runs live in your browser through this Shiny app. You do not need ",
                   "R, RStudio, or any packages installed on your own computer to use it.")
        )
      )
    )
  )
))
