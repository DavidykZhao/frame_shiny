library(tidyverse)

gpt2_performance = read.csv('GPT2_data_model_performances.csv')
gpt2_performance_5frames = read.csv('GPT2_5class_modelperformances.csv')
colnames(gpt2_performance_5frames) = c('models', 'accuracy', 'X')
gpt2_performance$version = 'full'
gpt2_performance_5frames$version = '5-frame'
gpt2_performance_all = rbind(gpt2_performance, gpt2_performance_5frames)
gpt2_performance_all$version = as.factor(gpt2_performance_all$version)


scale_colour_Publication <- function(...){
  library(scales)
  discrete_scale("colour","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
}

gpt2_performance_all %>%
  ggplot(aes(x = models, y = accuracy, color = version))+
  geom_boxplot()+
  theme_bw() + 
  labs(title =  'Model performances on GPT2 dataset (full vs 5-frame)')+
  academic_theme +
  theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"),
        axis.text.x = element_text(size = 6),
        plot.title = element_text(size = 10))+
  scale_colour_Publication()

ggsave('gpt2_model_comparison.png')







gpt2_performance_5frames %>%
  ggplot(aes(x = model, y = accuracy))+
  geom_boxplot()+
  theme_bw() + 
  labs(title =  'Model performances on GPT2 5-frame dataset')+
  academic_theme +
  theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"),
        axis.text.x = element_text(size = 6))

ggsave('gpt2_model_5frames.png')
