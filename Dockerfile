# Docker file for data_analysis_pipeline_eg
# Sidd Arora, Dec, 2017

# use rocker/tidyverse as the base image and
FROM rocker/tidyverse

# then install the ezknitr packages
RUN Rscript -e "install.packages('ezknitr', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('cowplot', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('jsonlite', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('lubridate', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('purrr', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('forcats', repos = 'http://cran.us.r-project.org')"
