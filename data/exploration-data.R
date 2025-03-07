# Data Exploration 

## Load packages
library(tidyverse)
library(dplyr)
library(readr)
library(tinytex)

## Load needed data (temporary)
data_title_crew <- read_tsv("https://datasets.imdbws.com/title.crew.tsv.gz")
data_title_basics <- read_tsv("https://datasets.imdbws.com/title.basics.tsv.gz")
data_title_ratings <- read_tsv("https://datasets.imdbws.com/title.ratings.tsv.gz")
data_name_basics <- read_tsv("https://datasets.imdbws.com/name.basics.tsv.gz")  


## Understanding Data Structure
# View the first rows
head(data_name_basics)
head(data_title_basics)
head(data_title_crew)
head(data_title_ratings)

# Get dataset dimensions (rows, columns)
dim(data_name_basics)
dim(data_title_basics)
dim(data_title_crew)
dim(data_title_ratings)

# Check column names
colnames(data_name_basics)
colnames(data_title_basics)
colnames(data_title_crew)
colnames(data_title_ratings)

# Overview of data types
glimpse(data_name_basics)
glimpse(data_title_basics)
glimpse(data_title_crew)
glimpse(data_title_ratings)


# Summary statistics for numeric variables (only numeric in title_ratings)
data_title_ratings %>% summarise(across(where(is.numeric), ~mean(.x, na.rm = TRUE)))


## Handling Missing Values

# Turn "\N" into real NA's 
data_name_basics[data_name_basics == "\\N"] <- NA
data_title_basics[data_title_basics == "\\N"] <- NA
data_title_crew[data_title_crew == "\\N"] <- NA
data_title_ratings[data_title_ratings == "\\N"] <- NA


# Count total missing values in each column
data_name_basics %>% summarise(across(everything(), ~sum(is.na(.))))
data_title_basics %>% summarise(across(everything(), ~sum(is.na(.))))
data_title_crew %>% summarise(across(everything(), ~sum(is.na(.))))
data_title_ratings %>% summarise(across(everything(), ~sum(is.na(.))))


# Percentage of missing values per column
data_name_basics %>% summarise(across(everything(), ~mean(is.na(.)) * 100))
data_title_basics %>% summarise(across(everything(), ~mean(is.na(.)) * 100))
data_title_crew %>% summarise(across(everything(), ~mean(is.na(.)) * 100))
data_title_ratings %>% summarise(across(everything(), ~mean(is.na(.)) * 100))

