# Main target
all: data/data_title_crew data/data_title_basics data/data_title_ratings data/data_name_basics

# Step 1: Download data
data/data_title_crew data/data_title_basics data/data_title_ratings data/data_name_basics: data/download-data.R
	Rscript data/download-data.R
