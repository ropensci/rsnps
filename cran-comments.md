## Test environments

* local OS X install, R 4.1.1
* Ubuntu Linux 20.04.1 LTS (on R-hub), R 4.1.2
* Fedora Linux (on R-hub) R-devel
* Windows (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs. 

There is 3 NOTEs.  

1. Two that are only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

2. The second is 

```
* checking for non-standard things in the check directory ... NOTE
Found the following files/directories:
  ''NULL''
```

As noted in [R-hub issue #560](https://github.com/r-hub/rhub/issues/560), this seems to be an Rhub issue and so can likely be ignored. 

3. A third that is found with *Fedora Linux, R-devel, clang, gfortran* and *Ubuntu Linux 20.04.1 LTS, R-release, GCC*

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```

This also seems to be a recurring issue on Rhub [R-hub issue #560](https://github.com/r-hub/rhub/issues/548) and so can likely be ignored.

## Reverse dependencies

* We have run R CMD check on the 1 downstream dependency
(<https://github.com/ropensci/rsnps/blob/master/revdep/README.md>).
No problems were found related to this package.

---

This version includes more tests, some spelling corrections and some formatting corrections.


Thanks!
Julia Gustavsen 
