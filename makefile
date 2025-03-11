OUTPUT = ../../gen/output

all: $(OUTPUT)/data.exploration.pdf

$(OUTPUT)/data.exploration.pdf: src/data-exploration/data.exploration.Rmd data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz
	Rscript -e "rmarkdown::find_pandoc()" && Rscript -e "rmarkdown::render('src/data-exploration/data.exploration.Rmd', output_file='$(OUTPUT)/data.exploration.pdf')"

data/title.crew.tsv.gz data/title.basics.tsv.gz data/title.ratings.tsv.gz data/name.basics.tsv.gz: src/data-download/download-data.R
	Rscript src/data-download/download-data.R

clean:
	if exist data\*.tsv.gz del /Q data\*.tsv.gz
