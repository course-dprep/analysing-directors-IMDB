# In this directory, you will keep all source code files relevant for 
# preparing/cleaning your data.

---
title: "Data Cleaning"
author: "Paulien Beeker"
date: "2025-03-13"
output: pdf_document
---

## Filtering for movies

```{r echo=TRUE, warning=FALSE}
movies <- data_title_basics %>%
  filter(titleType == "movie") %>%
  select(tconst, primaryTitle, startYear)

```

## Extracting Director information

```{r echo=TRUE, warning=FALSE}
directors <- data_title_crew %>%
  select(tconst, directors) %>%
  filter(!is.na(directors)) %>%
  separate_rows(directors, sep = ",")
```

## Replacing `"\\N"` in director dataset with actual NA's

```{r echo=TRUE, warning=FALSE}
directors <- directors %>%
  mutate(directors = na_if(directors, "\\N"))
```

## Replacing `"\\N"` in dataset with actual NA's

```{r echo=TRUE, warning=FALSE}
data_director_career$birthYear[data_director_career$birthYear == "\\N"] <- NA 
data_director_career$deathYear[data_director_career$deathYear == "\\N"] <- NA 
data_director_career$startYear[data_director_career$startYear == "\\N"] <- NA 
```

## Turning character values into numeric values for the year variables

```{r echo=TRUE, warning=FALSE}
data_director_career$birthYear <- as.numeric(data_director_career$birthYear)
data_director_career$deathYear <- as.numeric(data_director_career$deathYear)
data_director_career$startYear <- as.numeric(data_director_career$startYear)
```
