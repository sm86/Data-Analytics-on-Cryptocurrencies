# Computing Peason Coorelation Coeffecient
X = cor(df,method="pearson")

# Correlation plot
library(corrplot)
corrplot(X, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)

# Heat map
col<- colorRampPalette(c("blue", "yellow", "red"))(20)
heatmap(x = X, col = col, symm = TRUE)

# We will identify outlier with KMeans clustering
C1 <- kmeans(X, 2)
C1
# Plotting K means
library(cluster)
library(fpc)
plotcluster(X, C1$cluster)

# PAM Clustering with k=5
C2 <- pam(X,5)
plot(C2)
C3 <- pam(X,3)
plot(C3)

library(reshape)

scaled.df = t(as.matrix(df))
# Clustering based on directional movement
D1 <- diss(scaled.df, "COR")
C1 <- hclust(D1)
plot(C1)

# Clustering by Frechets distance
D2 <- diss(scaled.df,  "FRECHET")
C2 <- hclust(D2)
plot(C2)