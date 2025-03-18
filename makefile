all: ../../gen/output/data.exploration.pdf gen/output/model_summary.pdf gen/output/productivity_vs_rating.pdf gen/output/box_plot.pdf gen/output/scatter_plot.pdf

# Step 1: Downloading data
data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz: src/data-download/download-data.R
	Rscript -e "if (!dir.exists('data')) dir.create('data', recursive = TRUE)"
	Rscript src/data-download/download-data.R

# Step 2: Data exploration 
../../gen/output/data.exploration.pdf: src/data-exploration/data.exploration.Rmd data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	Rscript -e "if (!dir.exists('gen/output')) dir.create('gen/output', recursive = TRUE)"
	Rscript -e "rmarkdown::find_pandoc(); rmarkdown::render('src/data-exploration/data.exploration.Rmd', output_file='../../gen/output/data.exploration.pdf')"

# Step 3: Data cleaning
gen/temp/movies.tsv.gz gen/temp/directors_movie_info.tsv.gz gen/temp/directors_personal_info.tsv.gz gen/temp/title_ratings.tsv.gz: src/data-preparation/data-cleaning.R data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	R -e "if (!dir.exists('gen/temp')) dir.create('gen/temp', recursive = TRUE)"
	Rscript src/data-preparation/data-cleaning.R

# Step 4: Data merging
gen/temp/complete_directors_data.tsv.gz: src/data-preparation/data-merging.R gen/temp/movies.tsv.gz gen/temp/directors_movie_info.tsv.gz gen/temp/directors_personal_info.tsv.gz gen/temp/title_ratings.tsv.gz
	Rscript src/data-preparation/data-merging.R

# Step 5: Analysis
gen/output/model_summary.pdf gen/output/productivity_vs_rating.pdf gen/output/box_plot.pdf gen/output/scatter_plot.pdf gen/output/genre_category_boxplot.pdf gen/output/genre_versatility_plot.pdf gen/output/correlation_heatmap.pdf: src/analysis/analysis.R gen/temp/complete_directors_data.tsv.gz
	Rscript src/analysis/analysis.R

# Platform-independent clean rule
clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE, force = TRUE)"
