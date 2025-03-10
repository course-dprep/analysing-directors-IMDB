OUTPUT_FILE = data.exploration.html

all: $(OUTPUT_FILE)

$(OUTPUT_FILE): data/data.exploration.Rmd data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	Rscript -e "rmarkdown::find_pandoc()" && Rscript -e "rmarkdown::render('data/data.exploration.Rmd', output_file='$(OUTPUT_FILE)')"

data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz: data/download-data.R
	Rscript data/download-data.R

clean:
	if exist data\*.tsv.gz del /Q data\*.tsv.gz