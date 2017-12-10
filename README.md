
# IMDB Movies Dataset Analysis


## Identify Dataset

The project accesses all movie data from ![Kaggle](https://www.kaggle.com/tmdb/tmdb-movie-metadata/data).

To download the data from Kaggle, initially I used ![Kaggle Cli](https://github.com/floydwch/kaggle-cli). My bash script to download can be found ![here](https://github.com/sarora/movie_success_eval/blob/master/src/downloaddata.sh). **However**, the files that got downloaded were in a 'strange' encoding which made it impossible for me to parse the file. Hence, I had to manually download the data (zip file) from Kaggle.  

## Question

> Which genre of movies released have been most frequent in the last 5 years. Was it different 5 years before that? What about money spent on each of the genres? Compare the Mean budget and Mean revenue per genre. Will also be interesting to explore the genre with highest and lowest rating. 

### Next Milestone
>* Distribution of ratings across various genres
>* Explore actors associated with these popular genres (time permitting).

## Plan of action / Visualization

> I will be using R throughout for cleaning and visualization. The genre column movie dataset is in JSON format. It will be a bit of challenge to parse JSON (hopefully can find a library). Each movie can be associated with multiple genres (some upto 7). I will only be considering primary genre for simplicity. I can then group genre to find different statistics per genre, and plot them.


## Reproducing my Analysis

My analysis is reproducible using four scripts which **should** be run from the **src** directory, in the following order, and with the expected commands:

1. `get_movies.R` : Unzips a dataset from the data folder and copies to **directory** provided. The command is

  `Rscript get_movies.R ../data/movie_data_set_zipped.zip ../data`


2. `clean_movies.R`: Imports unzipped raw data from 1, cleans it, and extracts genres for different movies. Cleaned data exported as csv to a specified path. The command is:

  `Rscript clean_movies.R ../data/tmdb_5000_movies.csv ../results/resources/cleaned_movies.csv`


3. `figure_generator.R`: Reads in cleaned dataset from (2) and generates the figures for the final report in the results folder. The command is:

`Rscript plot_data.R ../results/resources/cleaned_movies.csv

4. Generates the final report. The Rmd lives in the src directory. The command is:

``Rscript -e 'ezknitr::ezknit("movie_dataset_analysis.Rmd", out_dir = "../doc")'``
