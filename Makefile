SSH_USER = kjhealy@kjhealy.co
DOCUMENT_ROOT = ~/public/datamgmt.org/public_html
PUBLIC_DIR = public/
PREFIX = /Users/kjhealy/.pandoc
BIB = /Users/kjhealy/Documents/bibs/socbib-pandoc.bib
CSL = apsa
OUTPUTDIR = public_html
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))

.PHONY : all

all: deploy

clean:
	rm -rf public/

build:
	Rscript -e "blogdown::build_site()"

serve: build
	Rscript -e "blogdown::serve_site()"

deploy: build
	rsync --exclude='.DS_Store' -Prvzce 'ssh -p 22' $(PUBLIC_DIR) $(SSH_USER):$(DOCUMENT_ROOT) --delete-after
