#! /usr/bin/env Rscript
# 
# clean_movies.R
 
# Sidd Arora, Dec, 2017
#
# Takes raw data for movies, cleans it, and summarises genres for different movies. Cleaned data exported as csv to a specified path.
#
# Usage: Rscript clean_free_movies.R ../data/tmdb_5000_movies.csv <path>
#
# Packages used: jsonlite, lubridate, purrrr, tidyverse, forcats.

library(jsonlite)
library(lubridate)
library(purrr)
library(tidyverse)
library(forcats)

# command line args
args <- commandArgs(trailingOnly = TRUE)
file <- args[1]
path <- args[2]


# function to clean and summarise data
main <- function() {
  
  # assign the file to read in
  movies <-  file
  
  #read in data
  movie_data <- read.csv(movies, header=TRUE, sep=",")
  
  #filtering out rows which have empty genre json.
  movie_data <- movie_data %>%  filter(genres != "[]")
  
  #convert release_date to type date 
  movie_data <- movie_data %>% mutate(release_date = ymd(release_date))
  
  #get JSON data for genre from the table
  genre_from_json<- map(as.character(movie_data$genres),fromJSON)
  
  #empty vector to store primary genres for movies
  movie_genres_primary <- vector('character',length(genre_from_json)) 
  
  #empty vector to store connected genres for movies
  movie_connected_genres <- vector('character',length(genre_from_json)) 
  
  #populate all primary genre and connected genres associated with movies. The connected genres will be in csv format.
  for(g in seq_along(movie_genres_primary)){
    genre_json_length <- length(genre_from_json[[g]]$name)
    movie_genres_primary[g] <- genre_from_json[[g]]$name[[1]]
    if(genre_json_length>1){
      movie_connected_genres[g]  <- paste0(genre_from_json[[g]]$name[2:genre_json_length],collapse=",")
    }
  }
  
  # Join the genre vector to the dataframe
  movie_data <- cbind(movie_data,movie_genres_primary,movie_connected_genres)
  
  
  # export to path specified
  write_csv(movie_data, path)
  
}

# execute main function
main()