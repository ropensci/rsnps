# Precompiled vignettes that depend on API key
# Must manually move image files from rsnps/ to rsnps/vignettes/ after knit

library(knitr)
knit("vignettes/rsnps.Rmd.orig", "vignettes/rsnps.Rmd")