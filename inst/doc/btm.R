## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  )
set.seed(46709394)

## -----------------------------------------------------------------------------
require(BTM)
require(quanteda)
require(oolong)
trump_corpus <- corpus(trump2k)

## -----------------------------------------------------------------------------
tokens(trump_corpus, remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE, split_hyphens = TRUE, remove_url = TRUE) %>% tokens_tolower() %>% tokens_remove(stopwords("en")) %>% tokens_remove("@*")  -> trump_toks

## -----------------------------------------------------------------------------
as.data.frame.tokens <- function(x) {
  data.frame(
    doc_id = rep(names(x), lengths(x)),
    tokens = unlist(x, use.names = FALSE)
  )
}

trump_dat <- as.data.frame.tokens(trump_toks)

## ----message = FALSE, results = 'hide', warning = FALSE-----------------------
trump_btm <- BTM(trump_dat, k = 8, iter = 500, trace = 10)

## -----------------------------------------------------------------------------
theta <- predict(trump_btm, newdata = trump_dat)
dim(theta)

## -----------------------------------------------------------------------------
setdiff(docid(trump_corpus), row.names(theta))

## -----------------------------------------------------------------------------
trump_corpus[604]

## -----------------------------------------------------------------------------
head(row.names(theta), 100)

## -----------------------------------------------------------------------------
oolong <- create_oolong(trump_btm)
oolong

## -----------------------------------------------------------------------------
oolong <- create_oolong(trump_btm, trump_corpus, btm_dataframe = trump_dat)
oolong

## ----btm_error1, error = TRUE-------------------------------------------------
oolong <- create_oolong(trump_btm, trump_corpus)

## ----btm_error2, error = TRUE-------------------------------------------------
oolong <- create_oolong(trump_btm, trump2k, btm_dataframe = trump_dat)

