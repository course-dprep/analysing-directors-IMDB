OUTPUT = gen/output
TEMP = gen/temp


all: ../../$(OUTPUT)/data.exploration.pdf $(OUTPUT)/model_summary.pdf $(OUTPUT)/productivity_vs_rating.pdf $(OUTPUT)/box_plot.pdf $(OUTPUT)/scatter_plot.pdf Analysing-Directors-IMBD.pdf

# Step 1: Downloading data
data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz: src/data-download/download-data.R
	Rscript -e "if (!dir.exists('data')) dir.create('data', recursive = TRUE)"
	Rscript src/data-download/download-data.R

# Step 2: Data exploration 
../../$(OUTPUT)/data.exploration.pdf: src/data-exploration/data.exploration.Rmd data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	Rscript -e "if (!dir.exists('$(OUTPUT)')) dir.create('$(OUTPUT)', recursive = TRUE)"
	Rscript -e "rmarkdown::find_pandoc(); rmarkdown::render('src/data-exploration/data.exploration.Rmd', output_file='../../$(OUTPUT)/data.exploration.pdf')"

# Step 3: Data cleaning
$(TEMP)/movies.tsv.gz $(TEMP)/directors_movie_info.tsv.gz $(TEMP)/directors_personal_info.tsv.gz $(TEMP)/title_ratings.tsv.gz: src/data-preparation/data-cleaning.R data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	R -e "if (!dir.exists('$(TEMP)')) dir.create('$(TEMP)', recursive = TRUE)"
	Rscript src/data-preparation/data-cleaning.R

# Step 4: Data merging
$(TEMP)/complete_directors_data.tsv.gz: src/data-preparation/data-merging.R $(TEMP)/movies.tsv.gz $(TEMP)/directors_movie_info.tsv.gz $(TEMP)/directors_personal_info.tsv.gz $(TEMP)/title_ratings.tsv.gz
	Rscript src/data-preparation/data-merging.R

# Step 5: Analysis
$(OUTPUT)/model_summary.pdf $(OUTPUT)/productivity_vs_rating.pdf $(OUTPUT)/box_plot.pdf $(OUTPUT)/scatter_plot.pdf $(OUTPUT)/genre_category_boxplot.pdf $(OUTPUT)/genre_versatility_plot.pdf $(OUTPUT)/correlation_heatmap.pdf: src/analysis/analysis.R $(TEMP)/complete_directors_data.tsv.gz
	Rscript src/analysis/analysis.R

# Step 6: Knitting the report
Analysing-Directors-IMBD.pdf: reporting/report.Rmd
	Rscript -e "rmarkdown::find_pandoc(); rmarkdown::render('reporting/report.Rmd', output_file='Analysing-Directors-IMBD.pdf')"

# Platform-independent clean rule
clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE, force = TRUE)"
	R -e "unlink('reporting/Analysing-Directors-IMBD.pdf', force = TRUE)"


