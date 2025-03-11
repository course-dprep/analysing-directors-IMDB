OUTPUT_FILE = data.exploration.html

all: $(OUTPUT_FILE)

$(OUTPUT_FILE): src/data-exploration/data.exploration.Rmd data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	Rscript -e "rmarkdown::find_pandoc()" && Rscript -e "rmarkdown::render('src/data-exploration/data.exploration.Rmd', output_file='$(OUTPUT_FILE)')"

data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz: src/data-download/download-data.R
	Rscript src/data-download/download-data.R

clean:
	if exist data\*.tsv.gz del /Q data\*.tsv.gz