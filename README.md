
SWKM
====

The goal of SWKM is to perform (sparse) weighted K-Means algorithm on observations with weights. If some observations are known to be noisier than the others, the method in this package can be applied to adaptively tune weights and cluster the data.

Installation
------------

You can install the released version of SWKM from [CRAN](https://CRAN.R-project.org) with (NOT Available Now):

``` r
install.packages("SWKM")
```

Another option is to set your working path to the whole folder and run the following code:

``` r
library(devtools)
devtools::install("../SWKM")
```

Main Functions
--------------

`kmeans.weight`: Perform weighted K-Means algorithm on data.

`kmeans.weight.tune`: Choose weight parameter for (sparse) weighted K-Means algorithm. Usually used before `kmeans.weight` or `KMeansSparseCluster.weight`.

`KMeansSparseCluster.weight`: Perform sparse weighted K-Means algorithm on data.

`KMeansSparseCluster.permute.weight`: Choose sparsity parameter for sparse weighted K-Means algorithm. Usually used before `KMeansSparseCluster.weight`, and after weight parameter is tuned or known.

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
# generate data
set.seed(1)
require(mvtnorm)
n <- 60  #sample size
p <- 1000 #dimension of features
q <- 50  #dimension of cluster-specific features
mu <- 0.8
MU <- c(0,-mu,mu)
sigma0 <- 5
data <- rbind(rmvnorm(n/3,rep(0,p)),rmvnorm(n/3,c(rep(-mu,q),rep(0,p-q))),
rmvnorm(n/3,c(rep(mu,q),rep(0,p-q))))
# add noise to 10 random observations
noisy.lab <- sample(n,10)
for (k in 1:3){
check <- (noisy.lab<n*k/3+1) & (noisy.lab>n/3*(k-1))
temp.lab <- noisy.lab[check]
num <- length(temp.lab)
if(any(check))
  data[temp.lab,] <- rmvnorm(num,c(rep(MU[k],q),rep(0,p-q)),sigma = diag(sigma0,p))
}
library(SWKM)
# run kmeans.weight.tune to tune weight parameter U
res.tuneU <- kmeans.weight.tune(data,K=3,noisy.lab=noisy.lab)
plot(res.tuneU)
weight <- res.tuneU$bestweight
# run KMeansSparseCluster.weight.permute to tune sparsity parameter s
res.tunes <- KMeansSparseCluster.permute.weight(data,K=3,weight=weight)
res <- KMeansSparseCluster.weight(data,K=3,weight=weight,wbounds=res.tunes$bestw)
```