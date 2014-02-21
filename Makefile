all: move pandoc rmd2md

move:
		cp inst/vign/rsnps_vignette.md vignettes

pandoc:
		cd vignettes;\
		pandoc --latex-engine=xelatex -H margins.sty rsnps_vignette.md -o rsnps_vignette.pdf --highlight-style=tango;\
		pandoc --latex-engine=xelatex -H margins.sty rsnps_vignette.md -o rsnps_vignette.html --highlight-style=tango

rmd2md:
		cd vignettes;\
		cp rsnps_vignette.md rsnps_vignette.Rmd