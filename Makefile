document = passList
document:
	mkdir -p trash
	./genPass.sh -d trash $(document)
	pdflatex --output-directory=trash "trash/$(document).tex"
	pdflatex --output-directory=trash "trash/$(document).tex"
	cp trash/$(document).pdf .
clean:
	rm -f trash/*
cleaner: clean
	rm -rf *.pdf trash
