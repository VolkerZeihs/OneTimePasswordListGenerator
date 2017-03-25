
ifndef document
document=passList
endif

ifndef rndBytes
rndBytes=12
endif

help:
	@echo ""
	@echo "Aufruf   : make [rndBytes=<number>] [doument=<filename>] target"
	@echo ""
	@echo "Targets  : help     - shows this help text"
	@echo "           document - create the target passList.pdf"
	@echo "           clean    - delete the trash directory"
	@echo "           cleaner  - same as clean, but also delete all *.pdf files"
	@echo ""
	@echo "Options  : rndBytes - set the number of random bytes used for the password generator"
	@echo "                      default is 12 bytes"
	@echo "         : document - set the name of output file without .pdf"
	@echo "                      default is passList"
	@echo ""
	@echo "Examples : make document"
	@echo "           make rndBytes=9 document"
	@echo ""

document:
	mkdir -p trash
	./genPass.sh -n $(rndBytes) -d trash $(document)
	pdflatex --output-directory=trash -interaction nonstopmode "trash/$(document).tex"
	pdflatex --output-directory=trash -interaction nonstopmode "trash/$(document).tex"
	cp trash/$(document).pdf .
clean:
	rm -f trash/*
cleaner: clean
	rm -rf *.pdf trash
