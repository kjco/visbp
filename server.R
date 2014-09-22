
library(shiny)
library(ggplot2)
bp <- read.csv(file="bloodpressure.csv",header=TRUE)


perc.rank <- function(x, xo)  length(x[x <= xo])/length(x)*100
#perc.rank(bpx_newmerge2$BPXSY,150)

# hist(mybp$BPXSY, breaks=20, col="grey")
# hist(mtcars$mpg, breaks=20, col="grey")
# abline(v=output$systolicbp,col="red")

shinyServer(function(input, output) {
  
   
     output$plot1 <- renderPlot({
       
       #mybp <- bp[which(bp$RIAGENDR==input$gender & bp$RIDAGEYR==input$age),]
       mybp <- bp[which(bp$RIAGENDR == input$gender & 
                          bp$RIDAGEYR <= (input$age+5) &
                          bp$RIDAGEYR >= (input$age-5)),]
       
       p1 <- ggplot(mybp, aes(x=BPXSY)) +
         geom_histogram(aes(y=..density..),colour = "darkgreen",fill = "white",
                                 binwidth = 3) +
         xlab("Systolic Blood Pressure (mm Hg)") +
         geom_vline(aes(xintercept=140),colour="red",linetype="dashed",size=1) +
         geom_vline(xintercept=input$systolicbp,
                    colour="blue",alpha=0.8,size=2)
       print(p1)
     })
     
     output$calcpercent <- renderText({
       mybp <- bp[which(bp$RIAGENDR == input$gender & 
                          bp$RIDAGEYR <= (input$age+5) &
                          bp$RIDAGEYR >= (input$age-5)),]
      
       paste("Your systolic blood pressure is at the", 
             floor(perc.rank(mybp$BPXSY,input$systolicbp)),"percentile in the",
             input$gender," population of age", (input$age-5),"to",(input$age+5))
       
     })
     
     
     output$plot2 <- renderPlot({
       
       mybp <- bp[which(bp$RIAGENDR == input$gender & 
                          bp$RIDAGEYR <= (input$age+5) &
                          bp$RIDAGEYR >= (input$age-5)),]
       
       #fortext <- perc.rank(mybp$BPXSY,input$systolicbp)
       
       p2 <- ggplot(mybp, aes(x=BPXDI)) +
         geom_histogram(aes(y=..density..),colour = "darkgreen",fill = "white",
                        binwidth = 3) +
         xlab("Diastolic Blood Pressure (mm Hg)") +
         geom_vline(aes(xintercept=90),colour="red",linetype="dashed",size=1) +
         geom_vline(xintercept=input$diastolicbp,
                    colour="blue",alpha=0.8,size=2)
       print(p2)
     })
     
     
     output$calcpercent2 <- renderText({
       mybp <- bp[which(bp$RIAGENDR == input$gender & 
                          bp$RIDAGEYR <= (input$age+5) &
                          bp$RIDAGEYR >= (input$age-5)),]
       
       paste("Your diastolic blood pressure is at the", 
             floor(perc.rank(mybp$BPXDI,input$diastolicbp)), "percentile in the",
             input$gender,"population of age", (input$age-5),"to",(input$age+5))
       
     })
     
     

})   




# shinyServer(function(input, output) {
#   
#   mybp <- bp[which(bp$RIAGENDR == input$gender & 
#                      bp$RIDAGEYR <= (input$age+5) &
#                      bp$RIDAGEYR >= (input$age-5)),]
#   
#   
#   environment<-environment() 
#   p1 <- ggplot(mybp, aes(x=BPXSY))
#   p1 <- p1 + geom_histogram(aes(y=..density..),colour = "darkgreen",fill = "white",
#                             binwidth = 1) +
#     geom_vline(aes(xintercept=140),colour="red",linetype="dashed",size=1) +
#     geom_vline(aes(xintercept=get(input$systolicbp)),environment = environment,
#                colour="blue",size=2)
#   
#   
#   output$plot1 <- renderPlot({
#     print(p1)
#     
#   })
# })




# shinyServer(function(input, output, session) {
#   
#   # Combine the selected variables into a new data frame
#   mybp <- reactive({
#     bp[which(bp$RIAGENDR == input$gender & bp$RIDAGEYR <= (input$age+5) &
#                bp$RIDAGEYR >= (input$age-5)),]
#   })
#     
#   
#   output$plot1 <- renderPlot({
#     p1 <- ggplot(mybp(), aes(x=BPXSY))
#     p1 <- p1 + geom_histogram(aes(y=..density..),colour = "darkgreen",fill = "white",
#                               binwidth = 2) +
#       geom_vline(aes(xintercept=140),colour="red",linetype="dashed",size=1) +
#       geom_vline(aes(xintercept=input$num),colour="blue",size=2)
#     p1
#   })
#   
# })