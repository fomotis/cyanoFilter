% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_functions.R
\name{ggplotDens}
\alias{ggplotDens}
\title{plots two channels of a flowframe.}
\usage{
ggplotDens(flowfile, channels, ...)
}
\arguments{
\item{flowfile}{flowframe to be plotted}

\item{channels}{a character vector of length 2, must contain channel names 
in the flowfile.}

\item{...}{not used at the moment}
}
\value{
a ggplot object
}
\description{
plots two channels of a flowframe.
}
\examples{
flowfile_path <- system.file("extdata", "B4_18_1.fcs", 
              package = "cyanoFilter",
              mustWork = TRUE)
flowfile <- flowCore::read.FCS(flowfile_path, alter.names = TRUE,
                               transformation = FALSE, emptyValue = FALSE,
                               dataset = 1) 
flowfile_nona <- cyanoFilter::noNA(x = flowfile)
flowfile_noneg <- cyanoFilter::noNeg(x = flowfile_nona)
flowfile_logtrans <- cyanoFilter::lnTrans(x = flowfile_noneg, 
                      c('SSC.W', 'TIME'))
ggplotDens(flowfile_logtrans,
           channels = c("FSC.HLin", "RED.R.HLin"))
}
