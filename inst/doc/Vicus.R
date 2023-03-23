## ----data, echo=TRUE----------------------------------------------------------
set.seed(1)
N <- 300
p <- sqrt(2 + 2 * seq(-1, 1 - 2 / N, 2 / N))
y <- 2 * runif(N, -1, 1)
X <- cbind(p * cos(2 * pi * p), y, p * sin(2 * pi * p))
X <- scale(X, center=TRUE, scale=TRUE) * 3
labelX <- c(rep(1:11, each = floor(N / 11)), rep(11, length=3))

## ----data2, echo=TRUE, fig.height=4, fig.width=4------------------------------
library("scatterplot3d")

# Color Setting
colors <- labelX
cols <- c("#9E0142", "#D53E4F", "#F46D43", "#FDAE61",
    "#FEE08B", "#FFFFBF", "#E6F598", "#ABDDA4",
    "#66C2A5", "#3288BD", "#5E4FA2")
for(i in seq_along(cols)){
    colors[which(colors == i)] <- cols[i]
}

oldpar <- par("cex")
par(cex = 1.2)
scatterplot3d(X, color=colors, pch=16, main="Original Data", angle=40)

## ----graph_matrix_2d, echo=TRUE-----------------------------------------------
library("Vicus")

objVicus <- graphMatrix(X, algorithm="Vicus", ndim=2, K=10)
objLEM <- graphMatrix(X, algorithm="LEM", ndim=2, K=10)
objHLLE <- graphMatrix(X, algorithm="HLLE", ndim=2, K=5)
str(objVicus, 2)
str(objLEM, 2)
str(objHLLE, 2)

## ----embed_2d, echo=TRUE------------------------------------------------------
outVicus <- embedding(objVicus)
outLEM <- embedding(objLEM)
outHLLE <- embedding(objHLLE)

## ----plot_2d, echo=TRUE, fig.height=3, fig.width=8----------------------------
layout(t(1:3))
plot(outVicus, col=colors, pch=16, main="Vicus", cex=2)
plot(outLEM, col=colors, pch=16, main="LEM", cex=2)
plot(outHLLE, col=colors, pch=16, main="HLLE", cex=2)

## ----graph_matrix_3d, echo=TRUE-----------------------------------------------
objVicus_3D <- graphMatrix(X, algorithm="Vicus", ndim=3)
objLEM_3D <- graphMatrix(X, algorithm="LEM", ndim=3)
objHLLE_3D <- graphMatrix(X, algorithm="HLLE", ndim=3)

## ----embed_3d, echo=TRUE------------------------------------------------------
outVicus_3D <- embedding(objVicus_3D)
outLEM_3D <- embedding(objLEM_3D)
outHLLE_3D <- embedding(objHLLE_3D)

## ----plot_3d, echo=TRUE, fig.height=7, fig.width=7----------------------------
layout(cbind(1:2, 3:4))
scatterplot3d(X, color=colors, pch=16, main="Original Data", angle=40)
scatterplot3d(outVicus_3D, color=colors, pch=16, main="Vicus", angle=40)
scatterplot3d(outLEM_3D, color=colors, pch=16, main="LEM", angle=70)
scatterplot3d(outHLLE_3D, color=colors, pch=16, main="HLLE", angle=70)

## ----setting, echo=TRUE-------------------------------------------------------
par(cex = oldpar)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

