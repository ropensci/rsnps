## Test environments

* local OS X install, R 4.1.1
* Ubuntu Linux 20.04.1 LTS (on R-hub), R 4.1.2
* Fedora Linux (on R-hub) R-devel
* Windows (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs. 

There is one NOTE that is only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

## Reverse dependencies

* We have run R CMD check on the 1 downstream dependency
(<https://github.com/ropensci/rsnps/blob/master/revdep/README.md>).
No problems were found related to this package.

---

This version includes a new feature and two minor improvement of the function `ncbi_snp_query`,
and a change in the vignette (we now pre-compile the vignette to avoid long runtimes). 


Thanks!
Julia Gustavsen and Sina Rüeger
