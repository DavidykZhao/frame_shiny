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
source('www/func1.R')
data_all = read.csv('./www/all_stages.csv')




header <- dashboardHeader(
    title = 'Visualization of model performances',
    titleWidth = 350
    
    )






sidebar <- dashboardSidebar(
    
    sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Introduction", tabName = "Introduction", icon = icon("info-circle")),
        
        menuItem("Stage_1", icon = icon("subscript"), tabName = "Stage_1",
                 badgeLabel = "new", badgeColor = "green")
        )
    )




body <- dashboardBody(
    tabItems(
      
        tabItem(tabName = "Stage_1",
                # Add three buttons to control the panel presentations
                fluidRow(column(width = 4,
                  actionBttn("m_o_d", label = "Models on a dataset", style = 'unite',
                           color = 'default', icon = icon("database"))
                  ),
                
                column(width = 4, actionBttn("m_a_d", label = "Model across datasets", style = 'unite',
                           color = 'success', icon = icon("brain"))
                       ),
                
                column(width = 4, actionBttn("ms_a_d", label = "Models across datasets", style = 'unite',
                           color = 'royal', icon = icon("object-group"))
                       ),
                ),
                uiOutput("button_reactive_plot")
                #uiOutput("m_a_d_plot")
                
                

                

        
        
                # tags$h2("Performances of models on a certain dataset"),
                # br(),
                # fluidRow( column(10, offset = 2,
                #                  tb_stage1
                #      )), # closing bracket for the fluidRow
                # h2("Performances of a certain model across datasets"),
                # br(),
                # fluidRow( column(10, offset = 2,
                #                  tb_stage1_ds_base))
        
      #### 2nd tabItem in the 1st tabItems  
        )
        
        
      ) # closing bracket for tabItems
    
    
    
    
    
    
    
) # closing bracket for dashboardBody obj








dashboardPage(header, sidebar, body)


