#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  url_data_training <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv";
  url_data_testing <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv";
  
  df_training <- read.csv(url(url_data_training));
  df_testing <- read.csv(url(url_data_testing));
  
  tmp_df_training <- df_training[, c(8:160)];
  tmp_df_testing <- df_testing[, c(8:160)];
  
  #Clean data
  not.na <- function(){
    pos_columns <- c()
    for(column in c(1:153)){
      exist.na <- sum(is.na(tmp_df_testing[,column]))
      if(20 == exist.na ){
        #print("exist")
      }else{
        #print("not exist")
        pos_columns <- c(pos_columns, column)
      }       
    }
    return(pos_columns)
  }
  
  columns <- not.na();
  
  #We create two new data set that will be used for analysis
  new_df_training <- tmp_df_training[, columns];
  new_df_testing <- tmp_df_testing[, columns];
  
  library(randomForest);
  
  modelo_random <- function(input){
    df_model<-randomForest(classe ~ ., data=new_df_training, ntree=input$n, mtry=6, replace=T);
  }
  
  output$carsPlot <- renderPlot({
    df_model_plot <- modelo_random(input)
    plot(modelo_random(input))
    legend("top", colnames(df_model_plot$err.rate),col=1:4,cex=0.8,fill=1:4)
    
  })
  
  output$carsSummary <- renderPrint({
    print(modelo_random(input))
  })
  
  output$tableData <- renderTable({
    data.frame(new_df_testing)
  })
  
})
