#' takes a flowframe, a group indicator and formulates another flowframe with 
#' group indicator as part of the
#' expression matrix of the new flowframe.
#'
#' @param flowfile flowframe after debris are removed.
#' @param group cluster group to be added to the expression matrix
#' @param togate channel detected to have more than one peak
#' @return flowframe with indicators for particle cluster
#' 
#' @examples
#' flowfile_path <- system.file("extdata", "B4_18_1.fcs", 
#'                   package = "cyanoFilter",
#'               mustWork = TRUE)
#' flowfile <- flowCore::read.FCS(flowfile_path, alter.names = TRUE,
#'                                transformation = FALSE, emptyValue = FALSE,
#'                                dataset = 1) 
#' flowfile_nona <- cyanoFilter::noNA(x = flowfile)
#' flowfile_noneg <- cyanoFilter::noNeg(x = flowfile_nona)
#' flowfile_logtrans <- cyanoFilter::lnTrans(x = flowfile_noneg, 
#' c('SSC.W', 'TIME'))
#' oneDgate(flowfile, 'RED.B.HLin')
#' 
#' @export newFlowframe

newFlowframe <- function(flowfile, group, togate) {


  if(!is.null(togate)) {

    ddata <- data.frame(name = paste(togate, "Cluster", sep = "_"),
                        desc = paste("Cluster Group for", togate),
                        range = max(group) - min(group),
                        minRange = range(group)[1],
                        maxRange = range(group)[2]
    )

  } else {

    ddata <- data.frame(name = "Clusters",
                        desc = paste("Detected Cluster groups"),
                        range = max(group) - min(group),
                        minRange = range(group)[1],
                        maxRange = range(group)[2]
    )

  }
  
  pd <- pData(flowCore::parameters(flowfile))
  dvarMetadata <- flowCore::varMetadata(flowCore::parameters(flowfile))
  ddimnames <- dimLabels(flowCore::parameters(flowfile))

  ddata <- rbind(pd, ddata)
  row.names(ddata) <- c(row.names(pd),
                        paste("$P", 
                              length(row.names(pd))+1,
                              sep = ""))

  
  paraa <- Biobase::AnnotatedDataFrame(data = ddata, 
                                       varMetadata = dvarMetadata,
                                       dimLabels = ddimnames
                                      )
  describe <- flowCore::keyword(flowfile)


  #flowframe with indicator added for each cluster
  nexp_mat <- as.matrix(cbind(flowCore::exprs(flowfile), group))
  # giving a name to the newly added column to the expression matrix
  colnames(nexp_mat) <- ddata$name

  # full flow frame with indicator for particly type
  fflowframe <- flowCore::flowFrame(exprs = nexp_mat, 
                                    parameters = paraa,
                             description = describe)
  return(fflowframe)
}
