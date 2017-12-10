#! /usr/bin/env Rscript
#
# download_mv_data.R
# 
# Sidd Arora Nov. 2017
#
# This script unzips a dataset from the data folder
# and copies to directory provided
#
#
# Dependicies: Readr package

  library(readr)
  
  args <- commandArgs(trailingOnly = TRUE)
  zipFile <- args[1]
  outDir <- args[2]
  
  
  # define main function
  main <- function() {
    
    unzip(zipFile,exdir=outDir)
 
  }
  
  # call main function
  main()
