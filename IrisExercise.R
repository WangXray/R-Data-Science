
#==========================
#This exercise is to try to build and evaluate a classification tree model for Iris data
#Then deploy a shiny app to allow users to predict Iris species by inputting petal length and width
#install.packages("ggplot2")
#install.packages("caret")
#install.packages('e1071', dependencies=TRUE)
#install.packages("rpart")
#==========================
# Load the Iris data
data(iris)
myData <- iris

#Peek at the data
str(iris)
head(iris,n=10)
tail(iris,n=10)


#Data visualization

library(ggplot2)
ggplot(data=iris, aes(x=Petal.Length, Petal.Width))+
  geom_point(aes(color=Species, shape=Species))+ggtitle("Iris Petal Width vs. Length")


# Data Split for modeling
set.seed(24)
indexes <- sample(x = 1:150,size = 90)
print(indexes)

trainData <- iris[indexes, ]
validateData<-iris[-indexes,]

# Train a classification tree model
library(rpart)
model <- rpart(
  formula = Species ~ .,
  data = trainData,
  method = "class")

# Inspect the model
summary(model)
#plot(model)
#text(model)

library(RColorBrewer)
palette <- brewer.pal(3, "Set1")

# Evaluate the model
predictions <- predict(
  object = model,
  newdata = validateData,
  type = "class")

library(caret)

confusionMatrix(
  data = predictions,
  reference = validateData$Species)

#Deploy the model to web service
library(shiny)

ui <- fluidPage(
  theme = "bootstrap.css",
  titlePanel("Iris Species Classification"),
  sidebarLayout(
    sidebarPanel (
      sliderInput(
        inputId = "petal.length",
        label = "petal Length (cm)",
        min=1,
        max=7,
        value=4),
      sliderInput(
        inputId = "petal.width",
        label = "petal Width (cm)",
        min=0,
        max=2.5,
        step=0.5,
        value = 1.25)),
  mainPanel(
      htmlOutput(
        outputId = "text"),
      
      plotOutput(
        outputId = "plot"))))

server <- function(input, output) {
  
  
  output$plot=renderPlot( {
      par(mfrow=c(1,2))
      
      plot(
        x = iris$Petal.Length, 
        y = iris$Petal.Width,
        pch = 8,
        col = palette[as.numeric(iris$Species)],
        main = "Iris Petal Width vs. Length",
        xlab = "Petal Length (cm)",
        ylab = "Petal Width (cm)")
      
      points(
        x = input$petal.length,
        y = input$petal.width,
        pch = 4,
        col = "red",
        cex=2,
        lwd=2
      )
      
      plot(model)
      text(model)
  })
  
  output$text = renderText({
    
    # Create predictors
    predictors <- data.frame(
      Petal.Length = input$petal.length,
      Petal.Width = input$petal.width,
      Sepal.Length = 0,
      Sepal.Width = 0)
    
    # Make prediction
    predictionOutput <- predict(
      object = model,
      newdata = predictors,
      type = "class")
    
    # Create prediction text
 
    paste(
      '<B> The predicted species is  ',
       as.character(predictionOutput) ,
       '</B>'
        )
  })
}

shinyApp(ui=ui, server=server)
