# Download data

## Install and load required packages
library(tidyverse)
library(dplyr)
library(readr)
library(tinytex)

## Step 1: Downloading and loading the IMBd data
data_title_crew <- read_tsv("https://datasets.imdbws.com/title.crew.tsv.gz")
data_title_basics <- read_tsv("https://datasets.imdbws.com/title.basics.tsv.gz")
data_title_ratings <- read_tsv("https://datasets.imdbws.com/title.ratings.tsv.gz")
data_name_basics <- read_tsv("https://datasets.imdbws.com/name.basics.tsv.gz")