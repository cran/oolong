## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  )
set.seed(46709394)

## -----------------------------------------------------------------------------
library(oolong)
wsi_test <- wsi(abstracts_seededlda)
wsi_test

## -----------------------------------------------------------------------------
export_oolong(wsi_test, dir = "./wsi_test", use_full_path = FALSE)

## -----------------------------------------------------------------------------
fs::dir_tree("./wsi_test")

## ----eval = FALSE-------------------------------------------------------------
#  library(shiny)
#  runApp("./wsi_test")

## ----include = FALSE----------------------------------------------------------
wsi_test <- readRDS(system.file("extdata", "wsi_test.RDS", package = "oolong"))

## ----echo = FALSE-------------------------------------------------------------
revert_oolong(wsi_test, system.file("extdata", "hadley.RDS", package = "oolong"))

## ----include = FALSE----------------------------------------------------------
unlink("./wsi_test", recursive = TRUE)

