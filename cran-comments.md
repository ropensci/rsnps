R CMD CHECK passed on my local OS X install on R 3.1.2 and R development 
version, Ubuntu running on Travis-CI, and Win builder.

This submission is in response to the request from Brian Ripley about 
fixing problems with examples wrapped in \donttest. I have moved the one
example wrapped in \donttest to \dontrun. In addition, I have moved some 
examples for some functions to \donttest so that functionality can be
checked with R CMD CHECK --run-donttest. 

In addition to the above, there are a few updates listed in NEWS.

Thanks! Scott Chamberlain
