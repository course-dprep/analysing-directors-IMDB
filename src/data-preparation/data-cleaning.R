# Cleaning every dataset

## Load required packages
library(tidyverse)
library(dplyr)
library(readr)
library(tinytex)

## Loading in data and turning "\N" into actual NA
data_title_crew <- read_tsv("data/title.crew.tsv.gz", na = "\\N")
data_title_basics <- read_tsv("data/title.basics.tsv.gz", na =  "\\N")
data_title_ratings <- read_tsv("data/title.ratings.tsv.gz", na = "\\N")
data_name_basics <- read_tsv("data/name.basics.tsv.gz", na = "\\N")

# 1.1 Filter for movies
movies <- data_title_basics %>%
  filter(titleType == "movie") %>%
  select(tconst, primaryTitle, startYear, runtimeMinutes, genres)

# 1.2 Extract directors information
directors_movie_info <- data_title_crew %>%
  select(tconst, directors) %>%
  filter(!is.na(directors)) %>%
  separate_rows(directors, sep = ",")

# 1.3 Clean name.basics dataset
directors_personal_info <- data_name_basics %>%
  select(nconst, primaryName, birthYear, deathYear)

# 1.4 Convert year columns to numeric
directors_personal_info$birthYear <- as.numeric(directors_personal_info$birthYear)
directors_personal_info$deathYear <- as.numeric(directors_personal_info$deathYear)
movies$startYear <- as.numeric(movies$startYear)

# 1.5 Renaming data_title_ratings
title_ratings <- data_title_ratings

# 1.6 Putting cleaned datasets into gen/temp folder
write_tsv(movies, "gen/temp/movies.tsv.gz")
write_tsv(directors_movie_info, "gen/temp/directors_movie_info.tsv.gz")
write_tsv(directors_personal_info,"gen/temp/directors_personal_info.tsv.gz")
write_tsv(title_ratings,"gen/temp/title_ratings.tsv.gz")