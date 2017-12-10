##! /usr/bin/env Rscript
# figure_generator.R
#
#
# Sidd Arora, Dec, 2016
#
# Takes in cleaned data file path and generates figures.
#
# Usage: Rscript plot_data ../results/resources <path>

# Packages used: jsonlite, lubridate, purrrr, tidyverse, forcats, cowplot.

library(jsonlite)
library(lubridate)
library(purrr)
library(tidyverse)
library(forcats)
library(cowplot)

# command line args
args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1]

main <- function() {
  
  movie_data <- read_csv(input_file)
  
  #filter movies 2012-Present
  movie_data_last5years <- movie_data %>% filter(year(release_date) > 2012)
  
  #filter movies 2008-2012
  movie_data_0812 <- movie_data %>% filter(year(release_date) %in% (2008:2012))
  
  #select relevant columns
  movie_data_last5years <- movie_data_last5years %>% select(original_title,release_date,popularity,revenue,budget,movie_genres_primary,movie_connected_genres)
  
  #select relevant columns
  movie_data_0812 <- movie_data_0812 %>% select(original_title,release_date,popularity, revenue,budget,movie_genres_primary,movie_connected_genres)
  
  

  # fig01 -- No of movies per genre between 2008-2012 and 2013-2017
  
  movie_data_0812_count<- movie_data_0812 %>% group_by(movie_genres_primary) %>% summarise(genre_count = n())
  movie_data_last5_count<- movie_data_last5years %>% group_by(movie_genres_primary) %>% summarise(genre_count = n())
  
  m0812<- ggplot(data=movie_data_0812_count, aes(x=fct_reorder((movie_genres_primary),genre_count), y=genre_count))+
    geom_bar(stat="identity", fill="indianred4") +
    labs(x="Movie Genre", y = "Number of Movies", title = "Genre of Movies released between 2008-2012" ) +
    coord_flip() + theme_minimal()
  
  mlast5<- ggplot(data=movie_data_last5_count, aes(x=fct_reorder((movie_genres_primary),genre_count), y=genre_count))+
    geom_bar(stat="identity", fill="tan2") +
    labs(x="Movie Genre", y = "Number of Movies", title = "Genre of Movies released between 2013-2017" ) +
    coord_flip() + theme_minimal()
  
  
  compare_plot_fre <- plot_grid(m0812,mlast5, ncol=2)
  
  ggsave(filename = "../results/resources/Frequency.png", plot = compare_plot_fre, width = 10, height = 3.5, dpi = 100)

  
  ############# plot 2- Avg revenue #######################
  
  
  movie_data_0812_Avg_Revenue <- movie_data_0812 %>% group_by(movie_genres_primary) %>% summarise(Total_Revenue = mean(revenue)) 
  movie_data_last5_Avg_Revenue <- movie_data_last5years %>% group_by(movie_genres_primary) %>% summarise(Total_Revenue = mean(revenue))
  
  
  
  m_08_12_ar <- ggplot(data=movie_data_0812_Avg_Revenue, aes(x=fct_reorder((movie_genres_primary),Total_Revenue), y=Total_Revenue))+
    geom_bar(stat="identity", fill="indianred4") +
    scale_y_continuous(labels = scales::dollar) +
    labs(x="Movie Genre", y = "Average Revenue per Genre", title = "Genre of Movies released between 2008-2012" ) +
    coord_flip() + theme_minimal()
  
  m_last_5_ar <- ggplot(data=movie_data_last5_Avg_Revenue, aes(x=fct_reorder((movie_genres_primary),Total_Revenue), y=Total_Revenue))+
    geom_bar(stat="identity", fill="tan2") +
    scale_y_continuous(labels = scales::dollar) +
    labs(x="Movie Genre", y = "Average Revenue per Genre", title = "Genre of Movies released between 2013-2017" ) + 
    coord_flip() + theme_minimal()
  
  compare_plot_ar <- plot_grid(m_08_12_ar,m_last_5_ar, ncol=2)
  
  ggsave(filename = "../results/resources/AverageRevenue.png", plot=compare_plot_ar,width=12, height=4.5,dpi = 100)
  
  
  
  
  ############# plot 3- Avg budget #######################
  
  
  
  movie_data_0812_Avg_Budget <- movie_data_0812 %>% group_by(movie_genres_primary) %>% summarise(Total_Budget = mean(budget)) 
  movie_data_last5_Avg_Budget <- movie_data_last5years %>% group_by(movie_genres_primary) %>% summarise(Total_Budget = mean(budget))
  
  
  
  m_08_12_ab <- ggplot(data=movie_data_0812_Avg_Budget, aes(x=fct_reorder((movie_genres_primary),Total_Budget), y=Total_Budget))+
    geom_bar(stat="identity", fill="indianred4") +
    scale_y_continuous(labels = scales::dollar) +
    labs(x="Movie Genre", y = "Average Budget per Genre", title = "Genre of Movies released between 2008-2012" ) +
    coord_flip() + theme_minimal()
  
  m_last_5_ab <- ggplot(data=movie_data_last5_Avg_Budget, aes(x=fct_reorder((movie_genres_primary),Total_Budget), y=Total_Budget))+
    geom_bar(stat="identity", fill="tan2") +
    scale_y_continuous(labels = scales::dollar) +
    labs(x="Movie Genre", y = "Average Budget per Genre", title = "Genre of Movies released between 2013-2017" ) + 
    coord_flip() + theme_minimal()
  
  
  ccompare_plot_b <- plot_grid(m_08_12_ab,m_last_5_ab, ncol=2)
  
  ggsave(filename = "../results/resources/AverageBudget.png", plot=ccompare_plot_b,width=12,height=4.5,dpi = 100)
 

}

main()