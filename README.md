
# IMDB Movies Dataset Analysis


## Identify Dataset

The project accesses all movie data from ![Kaggle](https://www.kaggle.com/tmdb/tmdb-movie-metadata/data).

To download the data from Kaggle, initially I used ![Kaggle Cli](https://github.com/floydwch/kaggle-cli). My bash script to download can be found ![here](https://github.com/sarora/movie_success_eval/blob/master/src/downloaddata.sh). **However**, the files that got downloaded were in a 'strange' encoding which made it impossible for me to parse the file. Hence, I had to manually download the data (zip file) from Kaggle.  

## Question

> Which genre of movies released have been most frequent in the last 5 years. Was it different 5 years before that? What about money spent on each of the genres? Compare the Mean budget and Mean revenue per genre. Will also be interesting to explore the genre with highest and lowest rating.

## Plan of action / Visualization

> Used R throughout for cleaning and visualization. The genre column movie dataset is in JSON format. Parsed JSON using jsonlite library. Each movie can be associated with multiple genres (some upto 7). I will only be considering primary genre for simplicity. I can then group genre to find different statistics per genre, and plot them.

## Reproducing my analysis using Docker. Usage instructions:

The docker image contains all software/packages
necessary to reproduce the results. Please have docker installed and  git clone my repository. You can run the following command to run the analysis from beginning to end (you will need only change the local path <local-path-to-project-repository> to point to the location of the project repo on your local machine):

You can use the Docker image to remove the results with the following command:

`docker run --rm -it -v /path-to-the-cloned-repo-on-your-computer/movie_success_eval:/home/movie_success_eval siddfury/movie_success_eval make -C '/home/movie_success_eval' clean`

For example:

`docker run --rm -it -v /c/Users/sid/Documents/GitHub/Block-3MDS/movie_success_eval:/home/movie_success_eval siddfury/movie_success_eval make -C '/home/movie_success_eval' clean`


Then to reproduce my analysis from start to beginning.

`docker run --rm -it -v /path-to-the-cloned-repo-on-your-computer/movie_success_eval:/home/movie_success_eval siddfury/movie_success_eval make -C '/home/movie_success_eval'`

For example:

`docker run --rm -it -v /c/Users/sid/Documents/GitHub/Block-3MDS/movie_success_eval:/home/movie_success_eval siddfury/movie_success_eval make -C '/home/movie_success_eval'`



## Explicit Terminal commands that are used in Makefile are as follows.

My analysis is reproducible using four scripts which **should** be run from the **src** directory, in the following order, and with the expected commands:

1. `get_movies.R` : Unzips a dataset from the data folder and copies to **directory** provided. The command is

  `Rscript src/get_movies.R /data/movie_data_set_zipped.zip data`


2. `clean_movies.R`: Imports unzipped raw data from 1, cleans it, and extracts genres for different movies. Cleaned data exported as csv to a specified path. The command is

  `Rscript src/clean_movies.R /data/tmdb_5000_movies.csv  /results/resources/cleaned_movies.csv`


3. `plot_data.R`: Reads in cleaned dataset from (2) and generates the figures for the final report in the results folder. The command is:

`Rscript src/plot_data.R  /results/resources/cleaned_movies.csv`

4. Generates the final report. The Rmd lives in the src directory. The command is:

`Rscript -e 'ezknitr::ezknit("movie_dataset_analysis.Rmd", out_dir = "doc")`
