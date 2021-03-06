
## Utils  ======================================================================

api_ptr_tag <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    .Call("R_ExternalPtrTag", ptr)
}

api_new_ptr_emptybasic <- function () {
    warning("Should not be used in R side, only for testing", immediate. = TRUE)
    .Call("new_ptr_emptybasic")
}


## Logo and Version  ===========================================================

api_symengine_logo <- function () {
    .Call("c_ascii_art_str")   
}

api_symengine_version <- function () {
    .Call("c_symengine_version")
}

api_symengine_have_component <- function (
    which = c("mpfr", "flint", "arb", "mpc", "ecm",
              "primesieve", "piranha", "boost", "pthread", "llvm"))
{
    vapply(which, FUN.VALUE = logical(1L),
           function (x) .Call("c_symengine_have_component", x))
}


## New Symbols  ================================================================

api_new_symbol <- function (string) {
    .Call("c_new_heap_symbol", string)
}

api_parse_str <- function (string) {
    .Call("c_parse_str", string)
}

## Accessors for Basic  ========================================================

api_basic_str <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    .Call("c_basic_str", ptr)
}

api_basic_str_julia <- function (ptr) {
    # I do not know all the difference between `basic_str` and `basic_str_julia`,
    # but `basic_str_julia` will show Pow with `^` instead of `**`.
    ptr <- as(ptr, "externalptr")
    .Call("c_basic_str_julia", ptr)
}


api_basic_type <- function (ptr) {
    .Call("c_basic_type", as(ptr, "externalptr"))
}


## Constants  ==================================================================

api_const_zero             <- function () .Call("c_const_zero")
api_const_one              <- function () .Call("c_const_one")
api_const_minus_one        <- function () .Call("c_const_minus_one")
api_const_I                <- function () .Call("c_const_I")
api_const_pi               <- function () .Call("c_const_pi")
api_const_E                <- function () .Call("c_const_E")
api_const_EulerGamma       <- function () .Call("c_const_EulerGamma")
api_const_Catalan          <- function () .Call("c_const_Catalan")
api_const_GoldenRatio      <- function () .Call("c_const_GoldenRatio")
api_const_infinity         <- function () .Call("c_const_infinity")
api_const_neginfinity      <- function () .Call("c_const_neginfinity")
api_const_complex_infinity <- function () .Call("c_const_complex_infinity")
api_const_nan              <- function () .Call("c_const_nan")

api_make_const <- function (string) {
    .Call("c_make_const", string)
}

## Integer  ====================================================================

api_integer_from_int <- function (x) {
    if (is.na(x) || is.infinite(x) || is.nan(x))
        warning("TODO: to support NA, Inf and NaN")
    
    stopifnot(is.integer(x)) # or as.integer(x)?
    .Call("c_integer_from_int", x)
}

api_integer_from_str <- function (x) {
    .Call("c_integer_from_str", x)
}

api_integer_get_int <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    
    stopifnot(api_is_a_Integer(ptr))
    .Call("c_integer_get_int", ptr)
}


## Real  =======================================================================

api_realdouble_from_d <- function (x) {
    # It seems that NA, Inf and NaN are directly supported, why??
    #
    # if (is.na(x) || is.infinite(x) || is.nan(x))
    #     warning("TODO: to support NA, Inf and NaN")
    
    stopifnot(is.double(x)) # or as.double for integer?
    .Call("c_realdouble_from_d", x)
}

api_realdouble_get_d <- function (ptr) {
    if (typeof(ptr) == "S4")
        ptr <- as(ptr, "externalptr")
    else
        stopifnot(typeof(ptr) == "externalptr")
    
    stopifnot(api_is_a_RealDouble(ptr))
    .Call("c_realdouble_get_d", ptr)
}

## Basic: is_a_XXX  ============================================================


api_is_a_Number        <- function(ptr) .Call("c_is_a_Number"        , as(ptr, "externalptr"))
api_is_a_Integer       <- function(ptr) .Call("c_is_a_Integer"       , as(ptr, "externalptr"))
api_is_a_Rational      <- function(ptr) .Call("c_is_a_Rational"      , as(ptr, "externalptr"))
api_is_a_Symbol        <- function(ptr) .Call("c_is_a_Symbol"        , as(ptr, "externalptr"))
api_is_a_Complex       <- function(ptr) .Call("c_is_a_Complex"       , as(ptr, "externalptr"))
api_is_a_RealDouble    <- function(ptr) .Call("c_is_a_RealDouble"    , as(ptr, "externalptr"))
api_is_a_ComplexDouble <- function(ptr) .Call("c_is_a_ComplexDouble" , as(ptr, "externalptr"))
api_is_a_RealMPFR      <- function(ptr) .Call("c_is_a_RealMPFR"      , as(ptr, "externalptr"))
api_is_a_ComplexMPC    <- function(ptr) .Call("c_is_a_ComplexMPC"    , as(ptr, "externalptr"))


## Number is  ==================================================================

api_number_is_zero <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    stopifnot(api_is_a_Number(ptr))
    .Call("c_number_is_zero", ptr)
}

api_number_is_negative <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    stopifnot(api_is_a_Number(ptr))
    .Call("c_number_is_negative", ptr)
}

api_number_is_positive <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    stopifnot(api_is_a_Number(ptr))
    .Call("c_number_is_positive", ptr)
}

api_number_is_complex <- function (ptr) {
    ptr <- as(ptr, "externalptr")
    stopifnot(api_is_a_Number(ptr))
    .Call("c_number_is_complex", ptr)
}

## Operations  =================================================================

api_basic_add <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_add", ptra, ptrb)
}

api_basic_sub <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_sub", ptra, ptrb)
}

api_basic_mul <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_mul", ptra, ptrb)
}

api_basic_div <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_div", ptra, ptrb)
}

api_basic_pow <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_pow", ptra, ptrb)
}

## Diff
api_basic_diff <- function (ptrexpr, ptrsym) {
    ptrexpr <- as(ptrexpr, "externalptr")
    ptrsym  <- as(ptrsym , "externalptr")
    stopifnot(api_basic_type(ptrsym) == "Symbol")
    .Call("c_basic_diff", ptrexpr, ptrsym)
}


api_basic_eq <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_eq", ptra, ptrb)
}

api_basic_neq <- function (ptra, ptrb) {
    ptra <- as(ptra, "externalptr")
    ptrb <- as(ptrb, "externalptr")
    .Call("c_basic_neq", ptra, ptrb)
}

api_basic_hash <- function (ptr) {
    .Call("c_basic_hash", as(ptr, "externalptr"))
}

if (FALSE) {
    api_basic_eq(S("x == x"), S("y == y"))
    api_basic_neq(S("x == x"), S("y == y"))
    api_basic_eq(S("x + 1 > x"), S("x + 2 > x + 1"))
}


## Functions with one argument

.flist <- c(
    alist(expand, neg, abs, erf, erfc),
    
    alist(sin, cos, tan, asin, acos, atan, csc, sec, cot, acsc, asec, acot, sinh,
          cosh, tanh, asinh, acosh, atanh, csch, sech, coth, acsch, asech, acoth),
    
    alist(lambertw, zeta, dirichlet_eta, gamma, sqrt, exp, log)
)

for (i in .flist) {
    fname    <- deparse(i)
    funcname <- paste0("api_basic_", deparse(i))
    callname <- paste0("c_basic_",   deparse(i))
    func <- eval(bquote(function (ptra) {
        .Call(.(callname), as(ptra, "externalptr"))
    }))
    assign(funcname, func)
    rm(fname, funcname, callname, func, i)
}

if (FALSE) {
    for (i in .flist) {
        cat("#' @useDynLib symengine c_basic_", deparse(i), "\n", sep = "")
    }
    for (i in .flist) {
        cat("#' @export\n")
        cat("api_basic_", i, " <- ", "api_basic_", i, "\n", sep = "")
    }
}

rm(.flist)


api_basic_expand <- api_basic_expand
api_basic_neg <- api_basic_neg
api_basic_abs <- api_basic_abs
api_basic_erf <- api_basic_erf
api_basic_erfc <- api_basic_erfc
api_basic_sin <- api_basic_sin
api_basic_cos <- api_basic_cos
api_basic_tan <- api_basic_tan
api_basic_asin <- api_basic_asin
api_basic_acos <- api_basic_acos
api_basic_atan <- api_basic_atan
api_basic_csc <- api_basic_csc
api_basic_sec <- api_basic_sec
api_basic_cot <- api_basic_cot
api_basic_acsc <- api_basic_acsc
api_basic_asec <- api_basic_asec
api_basic_acot <- api_basic_acot
api_basic_sinh <- api_basic_sinh
api_basic_cosh <- api_basic_cosh
api_basic_tanh <- api_basic_tanh
api_basic_asinh <- api_basic_asinh
api_basic_acosh <- api_basic_acosh
api_basic_atanh <- api_basic_atanh
api_basic_csch <- api_basic_csch
api_basic_sech <- api_basic_sech
api_basic_coth <- api_basic_coth
api_basic_acsch <- api_basic_acsch
api_basic_asech <- api_basic_asech
api_basic_acoth <- api_basic_acoth
api_basic_lambertw <- api_basic_lambertw
api_basic_zeta <- api_basic_zeta
api_basic_dirichlet_eta <- api_basic_dirichlet_eta
api_basic_gamma <- api_basic_gamma
api_basic_sqrt <- api_basic_sqrt
api_basic_exp <- api_basic_exp
api_basic_log <- api_basic_log


## subs
api_basic_subs2 <- function (ptrexpr, ptrold, ptrnew) {
    ptrexpr <- as(ptrexpr, "externalptr")
    ptrold  <- as(ptrold , "externalptr")
    ptrnew  <- as(ptrnew , "externalptr")
    .Call("c_basic_subs2", ptrexpr, ptrold, ptrnew)
}

## evalf
api_basic_evalf <- function(ptrb, bits = 53L, real = TRUE) {
    ptrb <- as(ptrb, "externalptr")
    bits <- as.integer(bits)
    real <- as.logical(real)
    .Call("c_basic_evalf", ptrb, bits, real)
}

