run_analysis <- function() {
    ## First do trainting dataset
    
    ## Read in column (feature) names
    actnmsfct <<- read.table("UCI\ HAR\ Dataset/features.txt")
    actnms <<- as.matrix(actnmsfct)
    
    ## Read in row (activity) labels
    rowlblsfct <<- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
    rowlbls <<- as.vector(rowlblsfct[,2])
    
    
    ## Read in data using actnms as column names
    trndat <<- read.table("UCI\ HAR\ Dataset/train/X_train.txt",
                          col.names=actnms[,2])
    
    ## Prune above data to include only means and 
    ## standard deviations
    keepvc <<- c(grep("mean",actnms[,2],ignore.case=TRUE),
                 grep("std",actnms[,2],ignore.case=TRUE))
    trndat_prune <<- trndat[,keepvc]
    
    ## Load activity vector
    trnlbls <<- read.table("UCI\ HAR\ Dataset/train/y_train.txt",
                           col.names="activity")
    
    ## Relabel activity vector
    trnlbls[,1] <<- rowlbls[trnlbls[,1]]
    
    ## Merge activity vector with dataset
    trnset_tot <<- cbind(trnlbls,trndat_prune)
    trnset_tot_frame <<- data.frame(training=trnset_tot)

}