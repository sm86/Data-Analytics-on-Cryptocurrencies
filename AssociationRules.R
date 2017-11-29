# Run the ClusteringDataPrep.R Scrpits and then this rules
hdf <- apply(df,2,function(x)(diff(x)))
hdf <- apply(hdf,2,function(x)(as.integer(as.logical(x>0))))
library("arules")
rules <- apriori(hdf, parameter = list(supp=0.5, conf=0.9))
inspect(head(rules, by = "lift"))
