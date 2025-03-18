# Analysis of the final directors dataset

## Load required packages
if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(readr)
if (!requireNamespace("tinytex", quietly = TRUE)) install.packages("tinytex")
library(tinytex)
if (!requireNamespace("gplots", quietly = TRUE)) install.packages("gplots")
library(gplots)
library(ggplot2)

## Loading in merged directors dataset 
final_data <- read_tsv("gen/temp/complete_directors_data.tsv.gz")

# Create the directories if they don't exist
dir.create("gen", showWarnings = FALSE)
dir.create("gen/output", showWarnings = FALSE, recursive = TRUE)

## 1.1a Multiple linear regression analysis (expanded with genre categories)
# Original model
model_1 <- lm(avg_rating ~ career_length + num_movies + avg_runtime + avg_numVotes + is_dramatic + is_light_entertainment + is_action_suspense + is_speculative + is_non_fiction + genre_versatility, data = final_data)

## 1.1b Capture the summary as text
summary_text <- capture.output(summary(model_1))

## 1.1c Specify the path to save the PDFs
pdf("gen/output/model_summary.pdf")

## 1.1d Print the original model summary to the PDF using textplot
textplot(summary_text, halign = "left", valign = "top", cex = 0.8)

## 1.1e Close the PDF device
dev.off()

## 1.2a Create plot effect number of movies on average movie rating 
plot <- ggplot(final_data, aes(x = num_movies, y = avg_rating)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "red", formula = y ~ x) +
  labs(title = "Does Productivity Impact IMDb Ratings?",
       x = "Number of Movies Directed",
       y = "Average IMDb Rating") +
  ggplot2::theme_minimal()

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

## 1.5a New Boxplot: IMDb Ratings per Genre Category
genre_category_boxplot <- final_data %>%
  pivot_longer(cols = c(is_dramatic, is_light_entertainment, is_action_suspense, is_speculative, is_non_fiction), 
               names_to = "genre_category", values_to = "value") %>%
  filter(value == 1) %>%
  mutate(genre_category = str_replace_all(genre_category, "is_", "")) %>%
  mutate(genre_category = str_replace_all(genre_category, "_", " ")) %>%
  ggplot(aes(x = genre_category, y = avg_rating, fill = genre_category)) +
  geom_boxplot() +
  labs(title = "IMDb Ratings by Genre Categories",
       x = "Genre Category",
       y = "Average IMDb Rating") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## 1.5b Save new genre category boxplot
ggsave("gen/output/genre_category_boxplot.pdf", plot = genre_category_boxplot, width = 10, height = 7)

## 1.6a Visualize Genre Versatility's Impact on Ratings
versatility_plot <- ggplot(final_data, aes(x = as.factor(genre_versatility), y = avg_rating)) +
  geom_boxplot(aes(fill = as.factor(genre_versatility))) +
  labs(title = "Impact of Genre Versatility on IMDb Ratings",
       x = "Number of Genre Categories Directed",
       y = "Average IMDb Rating",
       fill = "Genre Versatility") +
  theme_minimal()

## 1.6b Save versatility plot
ggsave("gen/output/genre_versatility_plot.pdf", plot = versatility_plot, width = 9, height = 6)

## 1.7a Create a correlation heatmap of key variables including new genre categories
library(reshape2)

correlation_vars <- final_data %>%
  select(avg_rating, career_length, num_movies, avg_runtime, avg_numVotes, 
         is_dramatic, is_light_entertainment, is_action_suspense, is_speculative, is_non_fiction, genre_versatility)

cor_matrix <- cor(correlation_vars, use = "complete.obs")
melted_cor <- melt(cor_matrix)

heatmap_plot <- ggplot(melted_cor, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  labs(title = "Correlation Heatmap of Key Variables",
       x = "", y = "", fill = "Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## 1.7b Save heatmap
ggsave("gen/output/correlation_heatmap.pdf", plot = heatmap_plot, width = 10, height = 8)