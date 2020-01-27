# read in the data
data_all = read.csv('./www/all_stages.csv')
data_all$training_size = as.factor(data_all$training_size)









# UI funtions
########################################################
# tabBox for stage 1 - model performances over datasets
tb_stage1 = tabBox(
  title = "Datasets",
  # The id lets us use input$tabset1 on the server to find the current tab
  id = "tabset1", 
  width = 10, 
  tabPanel("AG News",
           fluidRow(   
           plotOutput('agnews_stage1')),
           downloadBttn("agnews_button_stage1", "Download", style = 'unite', size = 'sm')
           
  ),
  
  tabPanel("DBPedia",
           fluidRow(   
             plotOutput('dbpedia_stage1'),
             downloadBttn("dbpedia_button_stage1", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Yelp",
           fluidRow( 
             plotOutput('yelp_stage1'),
             downloadBttn("yelp_button_stage1", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Amazon",
           fluidRow(   
             plotOutput('amazon_stage1'),
             downloadBttn("amazon_button_stage1", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Customer",
           fluidRow(  
             plotOutput('customer_stage1'),
             downloadBttn("customer_button_stage1", "Download", 
                          style = 'unite', size = 'sm')
           )))
########################################################

# tabBox for stage 1 - model performances across datasets
tb_stage1_ds_base = tabBox(
  title = "Models",
  # The id lets us use input$tabset1 on the server to find the current tab
  id = "tabset1_ds_base", 
  width = 10, 
  tabPanel("BERT",
           fluidRow(           
             plotOutput('bert_stage1')),
           downloadBttn("BERT_button_stage1", "Download", 
                        style = 'unite', size = 'sm')
  ),
  
  tabPanel("LinearSVC",
           fluidRow(           
             plotOutput('linear_svc_stage1'),
             downloadBttn("LinearSVC_button_stage1", "Download", 
                          style = 'unite', size = 'sm'))),
  
  tabPanel("LogisticRegression",
           fluidRow(           
             plotOutput('logistic_stage1'),
             downloadBttn("LogisticRegression_button_stage1", "Download", 
                          style = 'unite', size = 'sm'))),
  
  tabPanel("NaiveBayes",
           fluidRow(           
             plotOutput('nb_stage1'),
             downloadBttn("NaiveBayes_button_stage1", "Download", 
                          style = 'unite', size = 'sm'))),
  
  tabPanel("RandomForest",
           fluidRow(           
             plotOutput('rf_stage1'),
             downloadBttn("RandomForest_button_stage1", "Download", 
                          style = 'unite', size = 'sm'))))
#####################################################

# tabBox for stage 1 - model performances over datasets
tb_comprehensive_stage1 = tabBox(
  title = "Overview",
  # The id lets us use input$tabset1 on the server to find the current tab
  id = "tabset1_overview", 
  width = 12, 

  fluidRow( 
    plotOutput('overview_stage1'), 
    downloadBttn("overview_button_stage1", "Download", 
                 style = 'unite', size = 'sm')
   )
  
)
########################################################
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Server functions
########################################################


########### dict for converting ds name to title name
ds_names = as.vector(unique(data_all$dataset))
title_names = c("DBPedia", "AG News", "Yelp-full", "Customer Complaints", 'Amazon-full')
names(title_names) = ds_names  # ----> title_names is the dict name title_names['dbpedia]
#################################################################


############## Set the sota_error dict #######################
sota_errors = c(0.0062, 0.0449, 1-0.732, 0 ,0.3226 )
names(sota_errors) = ds_names
################################################################

###

############ Func for plotting stage1 over datasets ############
plot_stage1 = function(ds_name) {
  ## add control for the customer dataset because it does not have SOTA.
  if (ds_name == 'customer'){
    data_all %>%
      filter(stage == "stage1") %>%
      filter(dataset == ds_name) -> ds
    ggplot(ds, aes(x = model_name))+
      geom_boxplot(aes(y = accuracy)) +
      theme_bw() + 
      labs(title = paste("Algorithm performances on",  title_names[ds_name],  "dataset"))+
      academic_theme +
      geom_hline(yintercept= mean(ds$accuracy),linetype="dotted" )+
      annotate("text", x= 5, y= mean(ds$accuracy) - 0.005, size = 3, label="Average")+
      theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  } else {
    
    data_all %>%
      filter(stage == "stage1") %>%
      filter(dataset == ds_name) -> ds
    ggplot(ds, aes(x = model_name))+
      geom_boxplot(aes(y = accuracy)) +
      theme_bw() + 
      labs(title = paste("Algorithm performances on",  title_names[ds_name],  "dataset"))+
      academic_theme +
      geom_hline(yintercept= mean(ds$accuracy),linetype="dotted" )+
      annotate("text", x= 5, y= mean(ds$accuracy) - 0.005, size = 3, label="Average")+
      geom_hline(yintercept = 1 - sota_errors[ds_name], linetype = 'dotted')+
      annotate('text', x = 1, y = 1 - sota_errors[ds_name], label = 'SOTA',size = 3)+
      theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  }
}

#################################################################

############### Academic_plotting theme #######################
academic_theme =  theme(plot.title = element_text(face="bold", size=15), # use theme_get() to see available options
                        axis.title.x = element_blank(),
                        axis.title.y = element_text(face="bold", size=10, angle=90),
                        panel.grid.major.y = element_blank(), # switch off major gridlines
                        panel.grid.minor = element_blank(), # switch off minor gridlines
                        legend.position = 'bottom', # manually position the legend (numbers being from 0,0 at bottom left of whole plot to 1,1 at top right)
                        legend.title = element_blank(), # switch off the legend title
                        legend.text = element_text(size=8),
                        legend.key.size = unit(0.5, "lines"),
                        legend.key = element_blank(),
                        axis.text.x = element_text(size = 12),
                        panel.border = element_blank() )
####################################################################################



########### Func for plotting stage1 across datasets #####
plot_stage1_ds_base = function(model) {
  
  data_all  %>%
    filter(stage == "stage1") %>%
    filter(model_name == model) %>%
    ggplot(aes(x = dataset))+
    geom_boxplot(aes(y = accuracy)) +
    theme_bw() + 
    labs(title = paste(model, "'s performances across different datasets"))+
    academic_theme +
    theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  
}
######################################################################

########### Func for plotting stage1 overview #####
plot_stage1_overview = function() {

  data_all  %>%
    filter(stage == "stage1") %>%
    ggplot(aes(x = dataset))+
    geom_boxplot(aes(y = accuracy, color = model_name)) +
    theme_bw() + 
    labs(title = "Model performances across different datasets")+
    academic_theme +
    theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  
  
}
######################################################################





