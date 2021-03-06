% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sinaplot.R
\name{sinaplot}
\alias{sinaplot}
\alias{sinaplot.default}
\alias{sinaplot.formula}
\title{sinaplot}
\usage{
sinaplot(x, ...)

\method{sinaplot}{default}(x, groups = NULL, method = c("density",
  "counts"), scale = TRUE, adjust = 0.75, bins = 50, bin_limit = 1,
  maxwidth = 1, seed = NULL, plot = TRUE, add = FALSE, log = FALSE,
  labels = NULL, xlab = "", ylab = "", col = NULL, pch = NULL, ...)

\method{sinaplot}{formula}(formula, data = NULL, ..., subset,
  na.action = NULL, xlab, ylab)
}
\arguments{
\item{x}{numeric vector or a data frame or a list of numeric vectors to be
plotted.}

\item{...}{arguments to be passed to \code{\link[graphics]{plot}}.}

\item{groups}{optional vector of \code{length(x)}.}

\item{method}{choose the method to spread the samples within the same
bin along the x-axis. Available methods: "density" and "counts".
See \code{Details}.}

\item{scale}{a logical that indicates whether the width of each group should
be scaled relative to the group with the highest density.
Default: \code{TRUE}.}

\item{adjust}{adjusts the bandwidth of the density kernel when
\code{method == "density"} (see \code{\link[stats]{density}}).}

\item{bins}{number of bins to divide the y-axis into when
\code{method == "counts"}. Default: 50.}

\item{bin_limit}{if the samples within the same y-axis bin are more
than \code{bin_limit}, the samples's X coordinates will be adjusted.}

\item{maxwidth}{control the maximum width the points can spread into. Values
between 0 and 1.}

\item{seed}{a single value that controls the random sample jittering. Set to
an integer to enable plot reproducibility. Default NULL.}

\item{plot}{logical. When \code{TRUE} the sinaplot is produced, otherwise the
function returns the new sample coordinates. Default: \code{TRUE}.}

\item{add}{logical. If true add boxplot to current plot.}

\item{log}{logical. If true it uses a logarihmic scale on the y-axis.}

\item{labels}{labels for each group. Recycled if necessary. By default,
these are inferred from the data.}

\item{xlab, ylab}{axis labels.}

\item{pch, col}{plotting characters and colors, specified by group.
Recycled if necessary.}

\item{formula}{a formula, such as y ~ grp, where y is a numeric vector of
data values to be split into groups according to the grouping variable grp
(usually a factor).}

\item{data}{a data.frame (or list) from which the variables in formula should
be taken.}

\item{subset}{an optional vector specifying a subset of observations to be
used for plotting.}

\item{na.action}{a function which indicates what should happen when the data
contain NAs. The default is to ignore missing values in either the response
or the group.}
}
\value{
\item{x}{discrete x-coordinates, split by group}
\item{y}{input values}
\item{group}{input groups}
\item{scaled}{final x-coordinates, adjusted by sinaplot}

\code{NULL}

\code{NULL}
}
\description{
The SinaPlot is a data visualization chart suitable for plotting
any single variable in a multiclass dataset. It is an enhanced jitter strip
chart, where the width of the jitter is controlled by the density
distribution of the data within each class.
}
\details{
There are two available ways to define the x-axis borders for the
samples to spread within:
\itemize{
 \item{\code{method = "density"}

  A density kernel is estimated along the y-axis for every sample group. The
  borders are then defined by the density curve. Tuning parameter
  \code{adjust} can be used to control the density bandwidth in the same way
  it is used in \code{\link[stats]{density}}. }

 \item{\code{method = "counts"}:

 The borders are defined by the number of samples that occupy the same
 bin and the parameter \code{maxwidth} in the following fashion:

 \code{xBorder = nsamples * maxwidth}

  }
}
}
\examples{

## sinaplot on a formula:

data("blood", package = "sinaplot")
boxplot(Gene ~ Class, data = blood)
sinaplot(Gene ~ Class, data = blood, pch = 20, add = TRUE)

## sinaplot on a data.frame:

df <- data.frame(Uni05 = (1:100)/21, Norm = rnorm(100),
                  `5T` = rt(100, df = 5), Gam2 = rgamma(100, shape = 2))
boxplot(df)
sinaplot(df, add = TRUE, pch = 20)

## sinaplot on a list:

bimodal <- c(rnorm(300, -2, 0.6), rnorm(300, 2, 0.6))
uniform <- runif(500, -4, 4)
normal <- rnorm(800,0,3)

distributions <- list(uniform = uniform, bimodal = bimodal, normal = normal)
boxplot(distributions, col = 2:4)
sinaplot(distributions, add = TRUE, pch = 20)

## sinaplot on a vector:

x <- c(rnorm(200, 4, 1), rnorm(200, 5, 2), rnorm(400, 6, 1.5))
groups <- c(rep("Cond1", 200), rep("Cond2", 200), rep("Cond3", 400))

sinaplot(x, groups)

par(mfrow = c(2, 2))

sinaplot(x, groups, pch = 20, col = 2:4)
sinaplot(x, groups, scale = FALSE, pch = 20, col = 2:4)
sinaplot(x, groups, scale = FALSE, adjust = 1/6, pch = 20, col = 2:4)
sinaplot(x, groups, scale = FALSE, adjust = 3, pch = 20, col = 2:4)

#blood

par(mfrow = c(1,1))
sinaplot(blood$Gene, blood$Class)

old.mar <- par()$mar
par(mar = c(9,4,4,2) + 0.1)
groups <- levels(blood$Class)

sinaplot(blood$Gene, blood$Class, pch = 20, xaxt = "n", col = rainbow(18))
axis(1, at = 1:length(groups), labels = FALSE)
text(1:length(groups), y = par()$usr[3] - 0.1 * (par()$usr[4] - par()$usr[3]),
     xpd = TRUE, srt = 45, adj = 1, labels = groups)
par(mar = old.mar)

}
