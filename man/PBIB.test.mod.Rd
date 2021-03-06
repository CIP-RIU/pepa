% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fun_utils.R
\name{PBIB.test.mod}
\alias{PBIB.test.mod}
\title{A modified version of Analysis of the Partially Balanced Incomplete Block Design}
\usage{
PBIB.test.mod(block, trt, replication, y, k, method = c("REML", "ML", "VC"),
  test = c("lsd", "tukey"), alpha = 0.05, console = FALSE, group = TRUE)
}
\arguments{
\item{block}{type of UI element, deault is a tab in a shinydashboard}

\item{trt}{diaply title name}

\item{replication}{UI TabName}

\item{y}{Response}

\item{k}{Block size}

\item{method}{Estimation method: REML, ML and VC}

\item{test}{Comparison treatments}

\item{alpha}{Significant test}

\item{console}{logical, print output}

\item{group}{logical, groups}
}
\description{
This modified version of PBIB.test (agricolae pkg) aims to analyze alpha design experiment, in case, it
surpass 50 treatments.
using alpha design experiment
}
\author{
Omar Benites
}
