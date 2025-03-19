# Merging the cleaned datasets

## Load required packages
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(readr)
if (!requireNamespace("tinytex", quietly = TRUE)) install.packages("tinytex")
library(tinytex)
library(stringr)

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
directors_movies <- merged_directors_data %>%
  inner_join(movies, by = "tconst") %>%
  left_join(title_ratings, by = "tconst") %>%
  select(directors, primaryName, birthYear, deathYear, startYear, primaryTitle, averageRating, numVotes, runtimeMinutes, genres)

# 1.3 Create genre categories and original genre dummies
directors_movies <- directors_movies %>%
  mutate(
    # New genre categories
    is_dramatic = ifelse(str_detect(genres, "Drama|Biography|History"), 1, 0),
    is_light_entertainment = ifelse(str_detect(genres, "Comedy|Musical|Music"), 1, 0),
    is_action_suspense = ifelse(str_detect(genres, "Action|Adventure|Thriller|Crime"), 1, 0),
    is_speculative = ifelse(str_detect(genres, "Horror|Mystery|Sci-Fi|Fantasy"), 1, 0),
    is_non_fiction = ifelse(str_detect(genres, "Documentary|News|Reality-TV|Talk-Show"), 1, 0)
  )

# 1.4 Group and summarise per director
final_data <- directors_movies %>%
  group_by(directors) %>%
  summarise(
    career_start = min(startYear, na.rm = TRUE),
    career_end = max(startYear, na.rm = TRUE),
    num_movies = n(), 
    career_length = career_end - career_start,
    avg_rating = mean(averageRating, na.rm = TRUE),
    avg_runtime = mean(runtimeMinutes, na.rm = TRUE),
    avg_numVotes = mean(numVotes, na.rm = TRUE),
    
    # New genre category indicators
    is_dramatic = max(is_dramatic, na.rm = TRUE),
    is_light_entertainment = max(is_light_entertainment, na.rm = TRUE),
    is_action_suspense = max(is_action_suspense, na.rm = TRUE),
    is_speculative = max(is_speculative, na.rm = TRUE),
    is_non_fiction = max(is_non_fiction, na.rm = TRUE),
    
    # Calculate genre versatility (how many genre categories the director has worked in)
    genre_versatility = is_dramatic + is_light_entertainment + is_action_suspense + is_speculative + is_non_fiction,
    .groups = "drop"
  )

# 1.5 Changing -Inf/Inf values into NA's for all numerical columns
numeric_columns <- c("career_start", "career_end", "career_length", "num_movies", "avg_rating", "avg_runtime", "avg_numVotes", "genre_versatility")

for (col in numeric_columns) {
  final_data[[col]][!is.finite(final_data[[col]]) | is.na(final_data[[col]])] <- NA
}

# 1.6 Save in the temp-folder
write_tsv(final_data, "gen/temp/complete_directors_data.tsv.gz")  