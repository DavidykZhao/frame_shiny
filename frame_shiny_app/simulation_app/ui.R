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





########################################################
# tabBox for stage 1 - model performances across datasets
tb_stage1 = tabBox(
        title = "Datasets",
        # The id lets us use input$tabset1 on the server to find the current tab
        id = "tabset1", 
        width = 10, 
    tabPanel("AG News",
             fluidRow(           
                plotOutput('agnews_stage1'))
             ),

    tabPanel("DBPedia",
             fluidRow(           
                 plotOutput('dbpedia_stage1'))),
    tabPanel("Yelp",
             fluidRow(           
                 plotOutput('yelp_stage1'))),
    tabPanel("Amazon",
             fluidRow(           
                 plotOutput('amazon_stage1'))),
     tabPanel("Customer",
         fluidRow(           
             plotOutput('customer_stage1'))))


# tabPanel("Customer", 
#          "Tab content 2"),
# ),
########################################################



body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Introduction",
                h2("Performances of models on a certain dataset"),
                br(),
                fluidRow( column(10, offset = 2,
                                 tb_stage1
                     )
                ) # closing bracket for the fluidRow
        )
        
      ), # closing bracket for tabItems
    
    h2("Performances a model on across datasets")
    
    
    
    
    
    
) # closing bracket for dashboardBody obj








dashboardPage(header, sidebar, body)


