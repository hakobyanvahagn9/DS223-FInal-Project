#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shinythemes)
library(shiny)
library(readxl)
library(ggplot2)
library(ggcorrplot)
library(dplyr)
library(GGally)
library(ggExtra)
library(RColorBrewer)
library(reshape2)
library("shinyWidgets")


ui <- fluidPage(
  
  navbarPage("Adaptive Conjoint Analysis",
             theme = shinytheme("flatly"),
             
             
             tabsetPanel(
               tabPanel("Page 1",
                        br(),
                        
                        sidebarPanel( width= 3,
                                      h3("Market demographics"), 
                                      br(),
                                      checkboxGroupInput(inputId = "select_gender",
                                                         label = "Gender:",
                                                         choices = unique(big_data$gender), 
                                                         selected = 1),
                                      br(),
                                      checkboxGroupInput(inputId = "select_age",
                                                         label = "Age Group:",
                                                         choices = unique(big_data$age_group), 
                                                         selected = 1),
                                      submitButton("Show"))
               ),
               fluidRow(    
                 
                 column(2,       
                        
                        h3 ("Choise set 1"),
                        selectInput(inputId = "select_brand1",
                                    label = "Brand",
                                    choices = c("Canon" = "BrandCanon","Sony" = 
                                                  "BrandSony", "Nikon" = "BrandNikon"),
                                    selected = 1),
                        selectInput(inputId = "select_price1",
                                    label = "Price",
                                    choices = c("$1000" = "Price.1.000","$2000" = 
                                                  "Price.2.000", "$3000" = "Price.3.000"),
                                    selected = 1),
                        selectInput(inputId = "select_sensor1",
                                    label = "Sensor Size",
                                    choices = c("Full-Frame" = "Sensor.SizeFull.Frame..36x24mm",
                                                "APS-H" = "Sensor.SizeAPS.H..27.9x18.6mm", 
                                                "APS-C" = "Sensor.SizeAPS.C..23.6x15.6mm"),
                                    selected = 1),
                        selectInput(inputId = "select_camera1",
                                    label = "Camera Type",
                                    choices = c("DSLR" = "Camera.TypeDSLR", 
                                                "Mirrorless" = "Camera.TypeMirrorless"),
                                    selected = 1),
                        selectInput(inputId = "select_resolution1",
                                    label = "Resolution",
                                    choices = c("64 MP" = "Resolution64.megapixel", 
                                                "24 MP" = "Resolution24.megapixel", 
                                                "12 MP" = "Resolution12.megapixel"),
                                    selected = 1),
                        submitButton("Submit")
                 ),
                 column(2,
                        
                        h3 ("Choise set 2"),
                        selectInput(inputId = "select_brand2",
                                    label = "Brand",
                                    choices = c("Canon" = "BrandCanon","Sony" = 
                                                  "BrandSony", "Nikon" = "BrandNikon"),
                                    selected = 1),
                        selectInput(inputId = "select_price2",
                                    label = "Price",
                                    choices = c("$1000" = "Price.1.000","$2000" = 
                                      "Price.2.000", "$3000" = "Price.3.000"),
                                    selected = 1),
                        selectInput(inputId = "select_camera2",
                                    label = "Sensor Size",
                                    choices = c("Full-Frame" = "Sensor.SizeFull.Frame..36x24mm",
                                                "APS-H" = "Sensor.SizeAPS.H..27.9x18.6mm", 
                                                "APS-C" = "Sensor.SizeAPS.C..23.6x15.6mm"),
                                    selected = 1),
                        selectInput(inputId = "select_camera2",
                                    label = "Camera Type",
                                    choices = c("DSLR" = "Camera.TypeDSLR", 
                                                "Mirrorless" = "Camera.TypeMirrorless"),
                                    selected = 1),
                        selectInput(inputId = "select_resolution2",
                                    label = "Resolution",
                                    choices = c("64 MP" = "Resolution64.megapixel", 
                                                "24 MP" = "Resolution24.megapixel", 
                                                "12 MP" = "Resolution12.megapixel"),
                                    selected = 1),
                        submitButton("Submit")
                 ),
                 
                 
                 mainPanel(
                   tabsetPanel(
                     tabPanel("Multinom Logit", plotOutput("logit_tab")), 
                     tabPanel("Bayes", DTOutput("bayes_tab"))
                   )
                 )
               )
             )
             
  ))


server <- function(input, output) {
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)