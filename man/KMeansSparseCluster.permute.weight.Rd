% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/KMeansSparseCluster_permute_weight.R
\name{KMeansSparseCluster.permute.weight}
\alias{KMeansSparseCluster.permute.weight}
\title{Choose Sparsity Parameter for Sparse Weighted K-Means Clustering}
\usage{
KMeansSparseCluster.permute.weight(x, K = NULL, weight = NULL,
  nperms = 20, nstart = 20, wbounds = NULL, silent = TRUE,
  nvals = 10, centers = NULL)
}
\arguments{
\item{x}{An \emph{n} by \emph{p} numeric data matrix, and \emph{n} is the number of observations and \emph{p} the number of features.}

\item{K}{The number of clusters. Omitted if \code{centers} are provided.}

\item{weight}{A vector of \emph{n} positive elements representing weights on observations.}

\item{nperms}{Number of permutations. Default is \code{20}.}

\item{nstart}{The number of initial random sets chosen from (distinct) rows in \code{x}. Omitted if \code{centers} is provided. Default is 20.}

\item{wbounds}{A single L1 bound on w (the feature weights), or a vector of L1 bounds on w. If wbound is small,
    then few features will have non-zero weights. If wbound is large then all
  features will have non-zero weights. Should be greater than 1.}

\item{silent}{Print out progress?}

\item{nvals}{The number of candidate tuning parameter values. Omitted if \code{wbounds} is given.}

\item{centers}{A \emph{K} by \emph{p} matrix indicating initial (distinct) cluster centers.}
}
\value{
\item{gaps}{The gap statistics obtained (one for each of the tuning
    parameters tried). If O(s) is the objective function evaluated at
    the tuning parameter s, and O*(s) is the same quantity but for the
    permuted data, then Gap(s)=log(O(s))-mean(log(O*(s))).}
  \item{sdgaps}{The standard deviation of log(O*(s)), for each value of the
    tuning parameter s.}
  \item{nnonzerows}{The number of features with non-zero weights, for
    each value of the tuning parameter.}
  \item{wbounds}{The tuning parameters considered.}
  \item{bestw}{The value of the tuning parameter corresponding to the
    highest gap statistic.}
}
\description{
The sparsity parameter controls the L1 bound on w, the feature weights.
 A permutation approach is used to select the sparsity parameter.
}
\examples{
\dontrun{
set.seed(1)
data("NormalDisData")
cK <- ChooseK(NormalDisData$data[-NormalDisData$noisy.label,],nClusters = 1:6)
plot(cK)
K <- cK$OptimalK
res.tuneU <- kmeans.weight.tune(x = NormalDisData$data,K = K,
noisy.lab = NormalDisData$noisy.label,weight.seq = NULL)
plot(res.tuneU)
res.tunes <- KMeansSparseCluster.permute.weight(x = NormalDisData$data,K = K,
weight = res.tuneU$bestweight)
res <- KMeansSparseCluster.weight(x = NormalDisData$data,K = K,
wbounds = res.tunes$bestw,weight = res.tuneU$bestweight)
#check the clustering result, the number of features selected and the 50 most important features 
table(res[[1]]$Cs,NormalDisData$true.label)
sum(res[[1]]$ws!=0)
order(res[[1]]$ws,decreasing = TRUE)[1:50]
}
}
\references{
Daniela M Witten and Robert Tibshirani (2010). A framework for feature selection in clustering.  \emph{Journal of the American Statistical Association}, \bold{105(490)}, 713-726.
}
\seealso{
Other sparse weighted K-Means functions: \code{\link{ChooseK}},
  \code{\link{KMeansSparseCluster.weight}},
  \code{\link{kmeans.weight.tune}},
  \code{\link{kmeans.weight}}
}
\author{
Wenyu Zhang
}
\concept{sparse weighted K-Means functions}
\keyword{Clustering}
\keyword{K-Means}
\keyword{Parameter}
\keyword{Sparse}
\keyword{Tuning}
\keyword{Weighted}
