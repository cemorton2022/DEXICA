% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dexFastICA.R
\name{dexFastICA}
\alias{dexFastICA}
\title{Run the fastICA algorithm without matrix preprocessing}
\usage{
dexfastICA(X, n.comp, alg.typ = c("parallel", "deflation"), fun = c("logcosh", "exp"),
alpha = 1, maxit = 200, tol = 1e-04, verbose = FALSE, w.init = NULL, max.attempts = 3)
}
\arguments{
\item{X}{a numeric matrix(-like object)}

\item{n.comp}{an integer specifying the number of components to extract}

\item{alg.typ, fun, alpha, maxit, tol, verbose}{See \code{\link[fastICA]{fastICA}} documentation}

\item{w.init}{integer value to reset random number generator with (see Details)}

\item{max.attempts}{maximum number of attempts at convergence to make}
}
\value{
A list with the following elements:
\describe{
 \item{S}{The estimated source matrix}
 \item{A}{The estimated mixing matrix}
 \item{attempts}{The number of attempts made at finding a solution}
 \item{iterations}{The number of iterations made during the last attempt}
 \item{converged}{A logical value indicating whether convergence was reached}
}
}
\description{
Runs the fastICA algorithm but does not perform any matrix preprocessing operations
first (this differs from the \code{fastICA} function in the \pkg{fastICA} package.)  Preprocessing steps should be carried out
by running other functions, e.g. \code{\link{preprocessMatrix}}, on the input matrix prior to
using this function.
}
\details{
This function runs the fastICA algorithm on the input matrix but it does so without running
any preprocessing operations (such as centering and scaling on the rows and/or columns) on the input
matrix first.  This allows alternative preprocessing methods (such as \code{\link[scaleMatrix]{scaleMatrix}})
to be applied to the input matrix, which can improve results.  The \code{\link{preprocessMatrix}} function
may be run on the input matrix to carryout typical preprocessing steps, such as column centering.

Note: The default parameter values in \code{\link{preprocessMatrix}} match those of \code{\link[fastICA]{fastICA}},
thus, running \code{preprocessMatrix} followed by \code{dex.fastICA} with default parameter values is equivalent to running \code{fastICA}.

If \code{w.init} is not NULL, its value will be used to reset the random number generator
(using \code{\link[base]{set.seed}}) prior to randomly generarting the initial W ('unmixing') matrix.
This differs from \code{\link[fastICA]{fastICA}}, as w.init there can be either NULL or a matrix.
This modification to w.init was made in order to make reproducing results easier.

Another difference between this algorithm and \code{\link[fastICA]{fastICA}} is that multiple attempts
at convergence can be made if convergence fails in the first attempt.  The maximum number of attempts
that will be made is specified by the \code{max.attempts} parameter.  The maximum number of iterations in
each attempt, specified by \code{maxit}, is increased by 1.5x in each subsequent attempt.  If convergence
fails, the ICA solution found at the last iteration of the last attempt will be returned as an approximate
solution.
}
\examples{
x = matrix(rnorm(100), 10, 10)
x = preprocessMatrix(x)
m = dexFastICA(x, n.comp = 3)
m$converged

}
\seealso{
\code{\link[fastICA]{fastICA}}, \code{\link[DEXICA]{preprocessMatrix}},
\code{\link[DEXICA]{predictModules}}
}
