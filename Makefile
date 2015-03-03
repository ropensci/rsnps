all: move rmd2md

move:
		cp inst/vign/rsnps_vignette.md vignettes

rmd2md:
		cd vignettes;\
		mv rsnps_vignette.md rsnps_vignette.Rmd
