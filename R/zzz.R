
.onAttach <- function (libname, pkgname) {
    # TODO:
    # Check whether symengine is available, and give verbose message if not.
    # Also check gmp library or MPFR library.
    
    version <- api_symengine_version()
    msg <- sprintf("SymEngine Version: %s", version)
    if (requireNamespace("crayon", quietly = TRUE))
        msg <- crayon::yellow(msg)
    packageStartupMessage(msg)
    
    logo <- api_symengine_logo()
    if (requireNamespace("crayon", quietly = TRUE)) {
        logo  <- strsplit(logo, "\n")[[1]]
        pres  <- substring(logo, 1, 16)
        posts <- substring(logo, 17)
        
        pres  <- crayon::red(pres)
        posts <- crayon::green(posts)
        
        com <- crayon::`%+%`(pres, posts)
        com <- paste(com, collapse = "\n")
        packageStartupMessage(com)
    }
    else
        packageStartupMessage(logo)
    
    invisible(TRUE)
}

.onUnload <- function (libpath) {
    library.dynam.unload("symengine", libpath)
}
