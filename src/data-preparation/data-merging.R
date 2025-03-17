# Merging the cleaned datasets

## Load required packages
library(tidyverse)
library(dplyr)
library(readr)
library(tinytex)

## Loading in data
movies <- read_tsv("gen/temp/movies.tsv.gz")
directors_movie_info <- read_tsv("gen/temp/directors_movie_info.tsv.gz")
directors_personal_info <- read_tsv("gen/temp/directors_personal_info.tsv.gz")
title_ratings <- read_tsv("gen/temp/title_ratings.tsv.gz")

# 1.1 Merge directors movie and personal information
merged_directors_data <- directors_movie_info %>%
  inner_join(directors_personal_info, by = c("directors" = "nconst")) %>%
  select(directors, primaryName, birthYear, deathYear, tconst)


# 1.2 Merge directors dataset with movies dataset
data_directors_career <- merged_directors_data %>%
  inner_join(movies, by = "tconst") %>%
  group_by(directors) %>%
  summarise(
    career_start = min(startYear, na.rm = TRUE),
    career_end = max(startYear, na.rm = TRUE),
    num_movies = n(),  # Count movies directed
    career_length = career_end - career_start,
    .groups = "drop"
  )

# 1.3 Merge directors dataset with movie ratings data
data_directors_ratings <- directors_movie_info %>%
  inner_join(title_ratings, by = "tconst") %>%
  group_by(directors) %>%
  summarise(
    avg_rating = mean(averageRating, na.rm = TRUE),
    .groups = "drop"
  )

# 1.4 Final dataset merging career data with ratings data
final_data <- data_directors_career %>%
  left_join(data_directors_ratings, by = "directors") %>%
  filter(!is.na(avg_rating))  # Remove missing ratings

# 1.5 Changing -Inf/Inf values into regular NA's
final_data[!is.finite(final_data$career_start), "career_start"] <- NA
final_data[!is.finite(final_data$career_end), "career_end"] <- NA
final_data[!is.finite(final_data$career_length), "career_length"] <- NA
final_data[!is.finite(final_data$num_movies), "num_movies"] <- NA


# 1.6 Putting final dataset into gen/temp folder
write_tsv(final_data, "gen/temp/complete_directors_data.tsv.gz")