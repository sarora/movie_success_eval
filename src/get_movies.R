#! /usr/bin/env Rscript
#
# get_movies.R
# 
# Sidd Arora Nov. 2017
#
# This script unzips a dataset from the data folder
# and copies to directory provided
#
# Usage:
# 
# Packages used: Readr package

  library(readr)
  
  args <- commandArgs(trailingOnly = TRUE)
  zipFile <- args[1]
  outDir <- args[2]
  
  
  # define main function
  main <- function() {
    #unzips file to the directory mentioned.
    unzip(zipFile,exdir=outDir)
 
  }
  
  # call main function
  main()
