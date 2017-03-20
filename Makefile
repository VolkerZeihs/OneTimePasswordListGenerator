document = passList
document:
	./genPass.sh $(document) 
	pdflatex $(document) 
	pdflatex $(document)
clean:
	rm -f *.aux *.bbl *.blg *.lof *.lot *.log *.toc *.lol
cleaner: clean
	rm -f *.pdf *.out *.tex
