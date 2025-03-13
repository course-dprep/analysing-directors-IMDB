---
title: "Data Merging"
author: "Pauien Beeker"
date: "2025-03-13"
output: pdf_document
---

## Merging director IDs with name.basics.tsv.gz to get birthYear and calculate career span.

### inner_join is used so only matching rows are selected

```{r echo=TRUE, warning=FALSE}
merged_director_data <- directors %>%
  inner_join(data_name_basics, by = c("directors" = "nconst"))
```

## Selecting relevant columns in merged director data set

```{r echo=TRUE, warning=FALSE}
merged_director_data <- merged_director_data %>% 
  select(directors, primaryName, birthYear, deathYear, tconst)

```

## Merging director dataset with movies dataset

```{r echo=TRUE, warning=FALSE}
data_director_career <- merged_director_data %>%
  inner_join(movies, by = "tconst") %>%
  group_by(directors)
```

## Computing career length in merged director/movie dataset

```{r echo=TRUE, warning=FALSE}
data_director_career <- data_director_career %>% 
summarise(
    career_start = min(startYear),
    career_end = max(startYear),
    num_movies = n(),  # Count movies directed
    .groups = "drop"
  ) %>%
  mutate(career_length = career_end - career_start)
```

## Merging director career data with movie ratings data

```{r echo=TRUE, warning=FALSE}
data_director_ratings <- directors %>%
  inner_join(data_title_ratings, by = "tconst") %>%
  group_by(directors) %>%
  summarise(
    avg_rating = mean(averageRating, na.rm = TRUE),
    .groups = "drop"
)
```

## Final data (merge director career data with director ratings data)

```{r echo=TRUE, warning=FALSE}
final_data <- data_director_career %>%
  left_join(data_director_ratings, by = "directors") %>%
  filter(!is.na(avg_rating))  # Remove missing rating

```