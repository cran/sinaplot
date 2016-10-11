## ----example, fig.align='center', fig.width=5, fig.height=4--------------
x <- c(rnorm(200, 4, 1), rnorm(200, 5, 2), rnorm(400, 6, 1.5))
groups <- c(rep("Cond1", 200), rep("Cond2", 200), rep("Cond3", 400))

library(sinaplot)
sinaplot(x, groups)
#Use any "plot" argument
sinaplot(x, groups, col = c(2,3,4), pch = 20, bty = "n")

## ----blood, echo=FALSE, results='asis'-----------------------------------
knitr::kable(head(blood, 10))

## ----bloodDensity, fig.align='center', fig.height=6, fig.width=7---------
par(mar = c(9,4,4,2) + 0.1)
sinaplot(blood$value, blood$type, pch = 20)

## ----bloodCounts, fig.align='center', fig.height=6, fig.width=7----------
par(mar = c(9,4,4,2) + 0.1)
sinaplot(blood$value, blood$type, method = "counts", pch = 20)

## ----bloodScaleOff, fig.align='center', fig.height=6, fig.width=7--------
par(mar = c(9,4,4,2) + 0.1)
sinaplot(blood$value, blood$type, method = "counts", scale = FALSE,
         pch = 20)

## ----sessionInfo---------------------------------------------------------
sessionInfo()

