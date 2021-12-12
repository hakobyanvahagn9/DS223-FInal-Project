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

shinyServer(function(input, output){

  
  output$bayes_tab <- renderPlot({
    df_citations_reactive <- reactive({
      df <- big_data %>% 
        filter(gender %in% input$select_gender) %>%
        filter(age %in% input$select_age)
      df1 <- subset(df, select = c(-BLOCK, -QES, -ALT, -id, -gender, -age_group))
      return(df1)
    })
    
    df_citations_reactive1 <- as.data.frame(df_citations_reactive)
    model_bayesian <- glm(formula = RES ~., data = as.data.frame(df_citations_reactive1), 
                          family = binomial(link = 'logit'))
    bayes_df <- tidy(model_bayesian)
    
    
    choice1 <- 1 + 
      bayes_df$estimate[bayes_df$term==input$select_brand1] + 
      bayes_df$estimate[bayes_df$term==input$select_price1] + 
      bayes_df$estimate[bayes_df$term==input$select_sensor1]+
      bayes_df$estimate[bayes_df$term==input$select_camera1]+
      bayes_df$estimate[bayes_df$term==input$select_resolution1] 
    
    choice2 <- 1 + 
      bayes_df$estimate[bayes_df$term==input$select_brand2] + 
      bayes_df$estimate[bayes_df$term==input$select_price2] + 
      bayes_df$estimate[bayes_df$term==input$select_sensor2]+
      bayes_df$estimate[bayes_df$term==input$select_camera2]+
      bayes_df$estimate[bayes_df$term==input$select_resolution2] 
    
    choices_dt <- as.data.frame(Choices = c("Choice 1", "Choice 2"), 
                                Values = c(choice1, choice2))
    
    ggplot(choices_dt, aes(choices_dt$Choices, choices_dt$Values)) + geom_bar()
    
    })

  output$multinom_tab <- renderPlot({
    df_citations_reactive2 <- reactive({
      df <- big_data %>% 
        filter(gender %in% input$select_gender) %>%
        filter(age %in% input$select_age)
      df2 <- subset(df, select = c(-BLOCK, -QES, -ALT, -id, -gender, -age_group))
      return(df2)
    })
    
    df_citations_reactive2 <- as.data.frame(df_citations_reactive2)
    model_multinomLogit <- multinom(data = df_citations_reactive2, RES ~.)
    summary(model_multinomLogit)
    multi_df <- tidy(model_multinomLogit)
    
    
    choice1 <- 1 + 
      bayes_df$estimate[bayes_df$term==input$select_brand1] + 
      bayes_df$estimate[bayes_df$term==input$select_price1] + 
      bayes_df$estimate[bayes_df$term==input$select_sensor1]+
      bayes_df$estimate[bayes_df$term==input$select_camera1]+
      bayes_df$estimate[bayes_df$term==input$select_resolution1] 
    
    choice2 <- 1 + 
      bayes_df$estimate[bayes_df$term==input$select_brand2] + 
      bayes_df$estimate[bayes_df$term==input$select_price2] + 
      bayes_df$estimate[bayes_df$term==input$select_sensor2]+
      bayes_df$estimate[bayes_df$term==input$select_camera2]+
      bayes_df$estimate[bayes_df$term==input$select_resolution2] 

    choices_dt <- as.data.frame(Choices = c("Choice 1", "Choice 2"), 
                                Values = c(choice1, choice2))
    
    ggplot(choices_dt, aes(choices_dt$Choices, choices_dt$Values)) + geom_bar()
    
  })  
  
})
