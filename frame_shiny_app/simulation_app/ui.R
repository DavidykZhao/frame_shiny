#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
#install.packages('shinydashboard')
library(shinydashboard)
source('www/func.R')




header <- dashboardHeader(
    title = 'Visualization of model performances',
    titleWidth = 350
    
    )






sidebar <- dashboardSidebar(
    
    sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Introduction", icon = icon("info-circle"), tabName = "Introduction",
                 badgeLabel = "new", badgeColor = "green")
        )
    )




body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Introduction",
                h2("Performances of models on a certain dataset"),
                br(),
                fluidRow( column(10, offset = 2,
                                 tb_stage1
                     )
                ), # closing bracket for the fluidRow
                h2("Performances of a certain model across datasets"),
                br(),
                fluidRow( column(10, offset = 2,
                                 tb_stage1_ds_base))
        
      #### 2nd tabItem in the 1st tabItems  
        )
        
        
      ) # closing bracket for tabItems
    
    
    
    
    
    
    
) # closing bracket for dashboardBody obj








dashboardPage(header, sidebar, body)


