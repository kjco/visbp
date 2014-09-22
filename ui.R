library(shiny)

shinyUI(fluidPage(
  titlePanel("Visualize Your Blood Pressure Results"),
  
  sidebarLayout(
    sidebarPanel(
      helpText(
        strong("Visualize"),
        br(),
        p("A systolic reading over 140 mmHg or a diastolic reading over 90 mmHg 
          is considered High Blood Pressure*",
          br(),
          "(",
          span("dashed red lines", style = "color:red"),
          ")"),
        strong("Compare"),
        br(),
        p("Blood pressure can be affected by gender and age. See how your results",
          "(",
          span("solid blue lines", style = "color:blue"),
          ")",
          "compare to a population of the same gender and age range by the
          percentile listed."),
        strong("Interact"),
        br(),
        p("Enter different values. See how blood pressure changes with age.
          Compare differences in blood pressure between men and women."),
        br()
        
        ),
      
      selectInput("gender", 
                  label = "Select Gender",
                  choices = c("Female","Male"),
                  selected = "Female"),
      
      numericInput('age', 'Enter Age (5-85 years)', 35,
                   min = 5, max = 100),
            
      
      numericInput("systolicbp", 
                  label = "Your Systolic Blood Pressure (mmHg)",
                  value= 110),
      
      numericInput("diastolicbp", 
                   label = "Your Diastolic Blood Pressure (mmHg)",
                   value= 70),
      
      helpText(
        br(),
        p("* Recommendations from the American Heart Association"),
        p("Population blood pressure data source:
          National Health and Nutrition Examination Survey (NHANES) 2011-2012"),
        br(),
        a("See Slidify Summary", href="http://kjco.github.io/data-products",
          target="_blank")
        )
      
    ),
    
    mainPanel(
      h5("SYSTOLIC BLOOD PRESSURE", align = "center"),
      plotOutput("plot1"),
      textOutput("calcpercent"),
      br(),
      h5("DIASTOLIC BLOOD PRESSURE", align = "center"),
      plotOutput("plot2"),
      textOutput("calcpercent2"),
      br()
    )
  )
))