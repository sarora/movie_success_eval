# Makefile to generate the Movie evaluation data analysis project
#
# Sidd Arora Dec 2017
#
# Usage: make all
#		(from the root directory of project)

all:	report

# Unzip data
data/tmdb_5000_movies.csv:	data/movie_data_set_zipped.zip	src/get_movies.R
										Rscript src/get_movies.R	data/movie_data_set_zipped.zip data
# Clean raw data
results/resources/cleaned_movies.csv:	data/tmdb_5000_movies.csv src/clean_movies.R
										Rscript src/clean_movies.R data/tmdb_5000_movies.csv results/resources/cleaned_movies.csv
# Generate Images
summary_plots:	results/resources/cleaned_movies.csv	src/plot_data.R
										Rscript src/plot_data.R	results/resources/cleaned_movies.csv
# Generate report
report:	summary_plots	src/movie_dataset_analysis.Rmd
										Rscript -e 'ezknitr::ezknit("src/movie_dataset_analysis.Rmd", out_dir = "doc")'

clean:
			rm -f data/*.csv
			rm -f results/resources/*.png
			rm -f doc/*.html
			rm -f doc/*.md
