## Test environments

* local OS X install, R 4.1.1
* Ubuntu Linux 20.04.1 LTS (on R-hub), R 4.1.2
* Fedora Linux (on R-hub) R-devel
* Windows (devel and release)

## R CMD check results

I think this package was archived because a re-submission  was submitted with the
same release (0.6.0) as the release that I was trying to correct (0.6.0). This 
submission (0.6.1) attempts to correct this in line with CRAN policy (https://cran.r-project.org/web/packages/policies.html).

There were no ERRORs or WARNINGs. 

There are 4 NOTEs.


1. One related to the archival of this package:
```
Maintainer: 'Julia Gustavsen <j.gustavsen@gmail.com>'

New submission

Package was archived on CRAN

CRAN repository db overrides:
  X-CRAN-Comment: Archived on 2023-07-09 for policy violation.
  
On Internet access.

```

2. Two that are only found on Windows (Server 2022, R-devel 64-bit): 

```
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'
```
As noted in [R-hub issue #503](https://github.com/r-hub/rhub/issues/503), this could be due to a bug/crash in MiKTeX and can likely be ignored.

3. The third is 

```
* checking for non-standard things in the check directory ... NOTE
Found the following files/directories:
  ''NULL''
```

As noted in [R-hub issue #560](https://github.com/r-hub/rhub/issues/560), this seems to be an Rhub issue and so can likely be ignored. 

4. A fourth that is found with *Fedora Linux, R-devel, clang, gfortran* and *Ubuntu Linux 20.04.1 LTS, R-release, GCC*

```
* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found
```

This also seems to be a recurring issue on Rhub [R-hub issue #560](https://github.com/r-hub/rhub/issues/548) and so can likely be ignored.

## revdepcheck results

Not available for this submission the package was archived. 



---

This version includes more tests, fixes and catches for failing tests,some spelling corrections and some formatting corrections.


Thanks!
Julia Gustavsen 
