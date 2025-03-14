# Analysis of the final directors dataset

## Load required packages
library(tidyverse)
library(dplyr)
library(readr)
library(tinytex)
library(gplots)

## Loading in merged directors dataset 
final_data <- read_tsv("gen/temp/complete_directors_data.tsv.gz")


## 1.1a Multiple linear regression analysis
model_1 <- lm(avg_rating ~ career_length + num_movies, data = final_data)

## 1.1b Specify the path to save the PDF
pdf("gen/output/model_summary.pdf")

## 1.1c Print the summary to the PDF
textplot(capture.output(summary(model_1)))

# 1.1d Close the PDF device
dev.off()



## 1.2a Create plot effect number of movies on average movie rating 
plot <- ggplot(final_data, aes(x = num_movies, y = avg_rating)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "red", formula = y ~ x) +
  labs(title = "Does Productivity Impact IMDb Ratings?",
       x = "Number of Movies Directed",
       y = "Average IMDb Rating") +
  ggplot2::theme_minimal()  # Avoid name conflicts

## 1.2b Save plot in gen/output folder
ggsave("gen/output/productivity_vs_rating.pdf", plot = plot, width = 8, height = 6)


## 1.3a Boxplot analysis career length categories compared to IMBD rating
final_data <- final_data %>%
  mutate(career_category = case_when(
    career_length < 10 ~ "Short (<10 yrs)",
    career_length >= 10 & career_length <= 30 ~ "Medium (10-30 yrs)",
    career_length > 30 ~ "Long (>30 yrs)"
  ))

box_plot <- ggplot(na.omit(final_data), aes(x = career_category, y = avg_rating, fill = career_category)) +
  geom_boxplot() +
  labs(title = "IMDb Ratings by Director Career Length",
       x = "Career Length Category",
       y = "Average IMDb Rating") +
  theme_minimal()

## 1.3b Save boxplot in gen/output folder
ggsave("gen/output/box_plot.pdf", plot = box_plot, width = 8, height = 6)



## 1.4a Scatter Plots: Career Length & Productivity vs Ratings
scatter_plot <- ggplot(final_data, aes(x = career_length, y = avg_rating)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(title = "Does Career Length Impact IMDb Ratings?",
       x = "Career Length (Years)",
       y = "Average IMDb Rating") +
  theme_minimal()

## 1.4b Save scatter plot in gen/output folder
ggsave("gen/output/scatter_plot.pdf", plot = scatter_plot, width = 8, height = 6)