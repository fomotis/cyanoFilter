% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/phytoFilterClass.R
\name{MarginEvents}
\alias{MarginEvents}
\title{the marginEvent class}
\usage{
MarginEvents(
  fullflowframe,
  reducedflowframe,
  N_margin,
  N_nonmargin,
  N_particle,
  Channel,
  y_toplot,
  cut
)

MarginEvents(
  fullflowframe,
  reducedflowframe,
  N_margin,
  N_nonmargin,
  N_particle,
  Channel,
  y_toplot,
  cut
)
}
\arguments{
\item{fullflowframe}{same as the input flowFrame}

\item{reducedflowframe}{a partial flowframe containing non-margin events}

\item{N_margin}{number of margin particles measured}

\item{N_nonmargin}{number of non-margine particles}

\item{N_particle}{total number of particles measured}

\item{Channel}{channel measuring the width of the particles}

\item{y_toplot}{another channel to use in a bivariate plot}

\item{cut}{the cut-off point estimated or supplied.}
}
\value{
object of class MarginEvents
}
\description{
the marginEvent class

constructor for the MarginEvents class
}
\section{Slots}{

\describe{
\item{\code{fullflowframe}}{object of class "flowFrame" same as the input flowFrame}

\item{\code{reducedflowframe}}{object of class "flowFrame" a partial flowframe 
containing a proportion of the measured particles}

\item{\code{N_margin}}{object of class "numeric" representing the 
proportion of particles in each cluster}

\item{\code{N_nonmargin}}{object of class "integer" representing the 
number of particles in each cluster}

\item{\code{N_particle}}{object of class "integer" representing the labels for each
cluster}

\item{\code{Channel}}{object of class character representing channel measuring cell 
width}

\item{\code{y_toplot}}{object of class character representing plot variable}

\item{\code{cut}}{object of class numberic representing estimated inflection point or
supplied cut-off point}
}}

\examples{
flowfile_path <- system.file("extdata", "B4_18_1.fcs", 
                 package = "cyanoFilter",
                 mustWork = TRUE)
flowfile <- flowCore::read.FCS(flowfile_path, alter.names = TRUE,
                               transformation = FALSE, emptyValue = FALSE,
                               dataset = 1)
flowfile_nona <- cyanoFilter::noNA(x = flowfile)
flowfile_noneg <- cyanoFilter::noNeg(x = flowfile_nona)
flowfile_logtrans <- lnTrans(x = flowfile_noneg, c('SSC.W', 'TIME'))
cellMargin(flowframe = flowfile_logtrans, Channel = 'SSC.W',
           type = 'estimate', y_toplot = "FSC.HLin")
}
