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
output_file <- args[2]

main <- function() {
  
  movie_data <- read_csv(input_file)
  
  #filter movies 2012-Present
  movie_data_last5years <- movie_data %>% filter(year(release_date) > 2012)
  
  #filter movies 2008-2012
  movie_data_0812 <- movie_data %>% filter(year(release_date) %in% (2008:2012))
  
  #select relevant columns
  movie_data_last5years <- movie_data_last5years %>% select(original_title,release_date,popularity,movie_genres_primary,movie_connected_genres)
  
  #select relevant columns
  movie_data_0812 <- movie_data_0812 %>% select(original_title,release_date,popularity,movie_genres_primary,movie_connected_genres)
  

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
  
  
  compare_plot <- plot_grid(m0812,mlast5, ncol=2)
  
  ggsave(filename = output_file, plot = compare_plot, width = 10, height = 3.5, dpi = 100)


}

main()