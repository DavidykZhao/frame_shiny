#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#install.packages('shinyWidgets')
library(shiny)
library(tidyverse)
#install.packages('shinydashboard')
library(shinydashboard)
library(shinyWidgets)
#install.packages('shinythemes')
library(shinythemes)
source('www/func1.R')
source('www/func2.R')
source('www/func3.R')
source('www/introduction_page_fluidrow_obj.R')


data_all = read.csv('./www/all_stages.csv')
data_all$training_size = as.factor(data_all$training_size)
data_all$class_num = as.factor(data_all$class_num)




header <- dashboardHeader(
    title = 'Visualization of model performances',
    titleWidth = 350
    
)






sidebar <- dashboardSidebar(
    collapsed = T,
    sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Introduction", tabName = "Introduction", icon = icon("info-circle")),
        
        menuItem("Stage 1", icon = icon("database"), tabName = "Stage_1",
                 badgeLabel = "plot", badgeColor = "green"),
        menuItem("Stage 2", icon = icon("coins"), tabName = "Stage_2",
                 badgeLabel = "plot", badgeColor = "yellow"),
        menuItem("Stage 3", icon = icon("dice-three"), tabName = "Stage_3",
                 badgeLabel = "plot", badgeColor = "red")
        )
    )




body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "customshiny.css")
  ),
  #includeCSS("customeshiny.css"),
  
    tabItems(
       tabItem( tabName = "dashboard",
 
                intro_fluidrow         
                        
                         ), # closing bracket for the first tabItem

          
      
        tabItem(tabName = "Stage_1",
                # Add three buttons to control the panel presentations
                fluidRow( br(),
                         column(width = 3, offset = 1,
                  actionBttn("m_o_d", label = "Models on a dataset", style = 'unite',
                           color = 'default', size = 'sm', icon = icon("database"))
                  ),
                
                column(width = 3, offset = 1, actionBttn("m_a_d", label = "Model across datasets", style = 'unite',
                           color = 'success', size = 'sm',icon = icon("brain"))
                       ),
                
                column(width = 3, offset = 1, actionBttn("ms_a_d", label = "Models across datasets", style = 'unite',
                           color = 'royal', size = 'sm',icon = icon("object-group"))
                       ),
                ),
                uiOutput("button_reactive_plot")

            ), # closing the first tabItem
        
        
        tabItem(tabName = "Stage_2",
                fluidRow( br(), 
                  column(width = 3, offset = 1,
                                actionBttn("facet_model", label = "Facet by models", style = 'unite',
                                           color = 'default', icon = icon("database"))),
                column(width = 3, offset = 1,
                                actionBttn("facet_ds", label = "Facet by datasets", style = 'unite',
                                           color = 'royal', icon = icon("database"))),
                column(width = 3, offset = 1,
                       actionBttn("overview_stage2", label = "Overview", style = 'unite',
                                  color = 'success', icon = icon("database"))),
                
                ),      
                
                uiOutput('button_reactive_plot_stage2')
        
        ),# closing the second tabItem
        
        tabItem(tabName = "Stage_3",
                fluidRow( br(), 
                          column(width = 4, offset = 2,
                                 actionBttn("facet_model_stage3", label = "Facet by models", style = 'unite',
                                            color = 'default', icon = icon("database"))),
                          column(width = 4, offset = 2,
                                 actionBttn("facet_ds_stage3", label = "Facet by datasets", style = 'unite',
                                            color = 'royal', icon = icon("database"))),
              
                    
                ),      
                uiOutput('button_reactive_plot_stage3')
                
                
        )
        
        
        
        
        ) # closing bracket for tabItems
    
    
    
    
    
    
    
) # closing bracket for dashboardBody obj








dashboardPage(header, sidebar, body, skin = 'black')


