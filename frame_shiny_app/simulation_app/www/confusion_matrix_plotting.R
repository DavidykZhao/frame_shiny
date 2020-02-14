conf_matrix = matrix(c(42,  0,  2,  0,  7,  
                       1, 4,  3,  2,  1,  
                       3,  2, 22,  0,  2,  
                       1,  3,  0, 10,  0,  
                       7,  0,  1,  2,  40), nrow = 5, byrow = T)

conf_df = as.data.frame(conf_matrix)

rownames(conf_df) = c("Leisure banter", 
                      "Decision related",
                      "Concern",
                      "Control",
                      "Tech informational")

colnames(conf_df) = c("Leisure banter", 
                      "Decision related",
                      "Concern",
                      "Control",
                      "Tech informational")
colnames(conf_df)

conf_df = rownames_to_column(conf_df)


#library(caret)

library(reshape2)
melted_conf_df <- melt(conf_df, id.vars = 'rowname')
colnames(melted_conf_df) = c('Actual', 'Predicted', 'value')

melted_conf_df$Actual = factor(melted_conf_df$Actual, levels = melted_conf_df$Actual[1:5])


ggplot(data = melted_conf_df, aes(x= Actual, y= Predicted, fill = value)) + 
  geom_raster()+
  geom_text(label = melted_conf_df$value)+
  scale_fill_gradient(low = 'grey20', high = 'grey')+
  theme(axis.text.x = element_text(angle = 90),
        axis.title.x = element_blank(),
        legend.position = 'none')

ggsave('confusion_matrix_5frame-gpt2.png')  
