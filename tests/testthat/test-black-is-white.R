
context("black-is-white")

func_list <- alist(
  # Short Name        # The Function to test
    Complex          =  api_is_a_Complex         ,
    ComplexDouble    =  api_is_a_ComplexDouble   ,
    ComplexMPC       =  api_is_a_ComplexMPC      ,
    Integer          =  api_is_a_Integer         ,
    Number           =  api_is_a_Number          ,
    Rational         =  api_is_a_Rational        ,
    RealDouble       =  api_is_a_RealDouble      ,
    RealMPFR         =  api_is_a_RealMPFR        ,
    Symbol           =  api_is_a_Symbol          ,
    is_complex       =  api_number_is_complex    ,
    is_negative      =  api_number_is_negative   ,
    is_positive      =  api_number_is_positive   ,
    is_zero          =  api_number_is_zero
)

expect_true_with <- function (x, ..., error_with = character(0)) {
    true_with <- c(...)
    if (!length(true_with))
        true_with <- character(0)
    stopifnot(is.character(true_with))
    stopifnot(is.character(error_with))
    stopifnot(all(true_with   %in% names(func_list)))
    stopifnot(all(error_with  %in% names(func_list)))
    stopifnot(length(intersect(true_with, error_with)) == 0)
    
    func_names <- vapply(func_list, deparse, FUN.VALUE = character(1), USE.NAMES = FALSE)
    func_list  <- lapply(func_list, eval)
    
    for (i in seq_along(func_list)) {
        label <- sprintf("%s(%s)", func_names[[i]], deparse(substitute(x)))
        if (requireNamespace("crayon"))
            label <- crayon::yellow(label)
        if (names(func_list)[[i]] %in% true_with)
            expect_true(func_list[[i]](x), label = label)
        else if (names(func_list)[[i]] %in% error_with)
            expect_error(func_list[[i]](x), label = label)
        else
            expect_false(func_list[[i]](x), label = label)
    }
    invisible()
}

test_that("Test Builtin Constants", {
    n_is_xxx <- c("is_complex", "is_negative", "is_positive", "is_zero")
    
    expect_true_with(Constant("zero"),        "is_zero", "Integer", "Number")
    expect_true_with(Constant("one"),         "is_positive", "Integer", "Number")
    expect_true_with(Constant("minus_one"),   "is_negative", "Integer", "Number")
    expect_true_with(Constant("I"),           "is_complex", "Number", "Complex")
    
    expect_identical(api_basic_type(Constant("pi")),           "Constant")
    expect_identical(api_basic_type(Constant("E")),            "Constant")
    expect_identical(api_basic_type(Constant("EulerGamma")),   "Constant")
    expect_identical(api_basic_type(Constant("Catalan")),      "Constant")
    expect_identical(api_basic_type(Constant("GoldenRatio")),  "Constant")
    expect_true_with(Constant("pi"),           error_with = n_is_xxx)
    expect_true_with(Constant("E"),            error_with = n_is_xxx)
    expect_true_with(Constant("EulerGamma"),   error_with = n_is_xxx)
    expect_true_with(Constant("Catalan"),      error_with = n_is_xxx)
    expect_true_with(Constant("GoldenRatio"),  error_with = n_is_xxx)
    
    expect_true_with(Constant("Inf"),         "is_positive", "Number")
    expect_true_with(Constant("NegInf"),      "is_negative", "Number")
    expect_true_with(Constant("ComplexInf"),  "is_complex", "Number")
    expect_true_with(Constant("Nan"),         "Number")
})