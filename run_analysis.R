run_analysis <- function() {

    ## Read in column (feature) names
    actnmsfct <<- read.table("UCI\ HAR\ Dataset/features.txt")
    actnms <<- as.matrix(actnmsfct)
    
    ## Read in row (activity) labels
    rowlblsfct <<- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
    rowlbls <<- as.vector(rowlblsfct[,2])
    
    
    ## Read in data using actnms as column names
    trndat <<- read.table("UCI\ HAR\ Dataset/train/X_train.txt",
                          col.names=actnms[,2])
    testdat <<- read.table("UCI\ HAR\ Dataset/test/X_test.txt",
                          col.names=actnms[,2])
    
    
    
    ## Prune above data to include only means and 
    ## standard deviations
    keepvc <<- c(grep("mean",actnms[,2],ignore.case=TRUE),
                 grep("std",actnms[,2],ignore.case=TRUE))
    trndat_prune <<- trndat[,keepvc]
    testdat_prune <<- testdat[,keepvc]
    
    
    ## Load activity and subject vectors
    trnlbls <<- read.table("UCI\ HAR\ Dataset/train/y_train.txt",
                           col.names="activity")
    trnsbj <<- read.table("UCI\ HAR\ Dataset/train/subject_train.txt",
                           col.names="subject")
    testlbls <<- read.table("UCI\ HAR\ Dataset/test/y_test.txt",
                           col.names="activity")
    testsbj <<- read.table("UCI\ HAR\ Dataset/test/subject_test.txt",
                          col.names="subject")
    
    
    
    
    ## Relabel activity vector
    trnlbls[,1] <<- rowlbls[trnlbls[,1]]
    testlbls[,1] <<- rowlbls[testlbls[,1]]
    
    
    ## Merge activity and subject vectors with dataset
    trnset_tot <<- cbind(trnsbj,trnlbls,trndat_prune)
    ## trnset_tot_frame <<- data.frame(training=trnset_tot)
    testset_tot <<- cbind(testsbj,testlbls,testdat_prune)
    ## testset_tot_frame <<- data.frame(test=testset_tot)
    
    ## Merge test an training datasets
    allsets_tot_frame <<- rbind(trnset_tot,testset_tot)    
    
}