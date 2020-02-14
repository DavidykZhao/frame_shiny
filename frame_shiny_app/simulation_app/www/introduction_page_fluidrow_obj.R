## This is the Introduction page for the visualization project
# This is the fluidRow object embedded into the tabItems --> tabItem. 

intro_fluidrow = fluidRow(
                column(12, 

                       HTML({
                         '<section class="hero">
                            <div class="hero-inner">
                               <h1>Deep learning for textual classification</h1>
                               <h2>Transfer learning for NLP classification under small training size</h2>
                              <a href="https://github.com/DavidykZhao/frame_shiny"><button class="action-button bttn bttn-pill bttn-md bttn-warning bttn-no-outline" type="button">
  <i class="fa fa-github"></i>
  View repo
</button></a>


                           </div>
                           </section> 
                         '}),
                       

                        br()),
  
  
                column(8, offset = 2,

                                 
                h1("Welcome"),
                br(),

                p("This is a project to visualize the simulation results from 
                            different machine learning and deep learning models' performances on
                            textual classification."),
                "This project is made to visualize the results from Yikai Zhao's dissertation:",
                tags$em("What deep learning could bring to framing analysis."),
                br(),
                p("The advising committee members are:"),
                
                tags$ul(
                  tags$li("Dr. Kirby Goidel (chair)"), 
                  tags$li("Dr. Alan Dabney"), 
                  tags$li("Dr. Hart Blanton"),
                  tags$li("Dr. Timothy Coombs")
                ),
               
                br(),
                h1('motivation'),
                br(),
                p("Even though transfer learning NLP models have pushed the boundary and
                  broken the SOTA (State-of-the-Art) records in multiple NLP tasks, little is known about 
                  their performances under small training sizes; especially, little research has shown the stability of the models' performances."),
                
                p(paste("Thus, this research run", nrow(data_all),"experiments/simulations to showcase the performances
                        of deep learning and machine learning models on textual classification.")),
                
                p("Further, this study adopts the most representative transfer learning models: BERT (Bidirectional Encoder Representations from Transformers) and 
                  XLNet (Generalized Autoregressive Pretraining for Language Understanding) and contrast them to the traditional bag-of-words approach utilized in machine learning models."),
                br(),
                
              
                
                
                h1("The experiments"),
                
                h3("Dataset"),
                p("There are in total of 5 datasets. These datasets were chosen because they
                  are either the benchmark datasets in NLP research, or the common dataset practitioners use.
                  These datasets and their corresponding information are provided below:"),
                tableOutput("data_infotable"),
                
                
                
                br(),
              
                p(paste("The", nrow(data_all), "experiments could be collapsed into 3 stages:")),
                
                tags$ul(
                  tags$li("Stage 1: The marginal accuracy of different models across different datasets"), 
                  tags$li("Stage 2: The accuracy of different models as training size grows across different datasets"), 
                  tags$li("Stage 2: The accuracy of different models as training size grows with different number of classes across different datasets")
                ), # closing the tags$ol obj
                
                br(),
                
                h3('Stage 1 information'), 
                p("In stage 1, the models were run across datasets at a relative large training size (10000). In this stage,
                the goal is to investigate the marginal performances of those models and compare them to the current SOTA results.
                  "),
                p("For each machine learning models, 10 simulations were run for each dataset; for each deep learning models, 
                  5 simulations were run for each dataset. See table below:"),
                DT::dataTableOutput("stage1_table" ),
                
                h3('Stage 2 information'), 
                p("In stage 2, the models were run across datasets at at different training sizes (from 100 to 5000). In this stage,
                the goal is to investigate the performances of models at different training sizes and contrast the deep learning models with traditional 
                machine learning models in the bag-of-words fashion."),
                p("For each machine learning models, 5 simulations were run for each dataset (with the exception that there are 10 simulations for each training size for the DBPeida and AG's NEWS datasets); 
                for each deep learning models, 5 simulations were run for each dataset. See table below:"),
                DT::dataTableOutput("stage2_table"),
                
                
                h3('Stage 3 information'), 
                p(paste("In stage 3, the models were run across datasets at at different training sizes (from 100 to 5000) at a smaller classes. In this stage,
                the goal is to investigate the performances of models at different training sizes with less classes (compared with stage 2) and contrast the deep learning models with traditional 
                machine learning models in the bag-of-words fashion.")),
                p("For each machine learning models, 5 simulations were run for each dataset (with the exception that there are 10 simulations for each training size for the DBPeida and AG's NEWS datasets); 
                for each deep learning models, 5 simulations were run for each dataset. See table below:"),
                p("Notice the datasets are with less classes (e.g. 3 or 5 classes rather than 5 or 13) than stage 2."),
                DT::dataTableOutput("stage3_table"),
                
                br(),
                
                h1("How to navigate this app"),
                br(),
                p("At the top left corner near the title 'Deep learning for NLP' you will find a button
                to unfold the sidebar menu."),
                p("You could click stages to view the accuracy of the experiments within the corresponding stage."),
                p("Within each stage, you will find 2 or 3 buttons showing different ways of visualizing the results. 
                  The results will be plotted after you click the buttons. Those results are also available for download
                  by clicking the corresponding download button below the plot."),
                p('Note: sometimes it may take some time for the server to perpare the download...'), 
                br(),
                br()
              
                
                
                
                
))