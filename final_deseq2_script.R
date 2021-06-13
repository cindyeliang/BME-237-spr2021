setwd("C:/Users/liang/Desktop/htseq-cts")
directory <- "C:/Users/liang/Desktop/htseq-cts"
sampleFiles <- list.files(directory)
sampleCondition <- factor(c("air", "air", "air", "csc", "csc", "csc"))
sampleCondition
sampleFiles
sampleTable <- data.frame(sampleName = sampleFiles,
                          fileName = sampleFiles,
                          condition = sampleCondition)

sampleTable$condition <- factor(sampleTable$condition)
sampleTable

library("DESeq2")
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design= ~ condition)

keep <- rowSums(counts(ddsHTSeq)) >= 10
ddsHTSeq <- ddsHTSeq[keep,]

ddsHTSeq

ddsHTSeq$condition <- relevel(ddsHTSeq$condition, ref = "air")

colData(ddsHTSeq)$condition<-factor(colData(ddsHTSeq)$condition, levels=c('air','csc'))
dds<-DESeq(ddsHTSeq)
res05<-results(dds, alpha=0.1)
summary(res$pvalue <0.05)

res<-res[order(res$pvalue),]
head(res)
res

res <- results(dds, contrast=c("csc","air"))
resOrdered <- res[order(res$pvalue),]
resOrdered
summary(res)

write.csv(res, "bmefinal-filtereddeseq2-res.txt", row.names=TRUE)

#do transformations for plotting

BiocManager::install("vsn")

library("vsn")
vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)
ntd <- normTransform(dds)

library("pheatmap")
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:20]
heatmap_df <- as.data.frame(colData(dds)[c("condition")])

heatmap_df

heatmapimage <- pheatmap(assay(ntd)[select,], cluster_rows=TRUE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=heatmap_df)

save_pheatmap_png <- function(x, filename, width=1200, height=1000, res = 150) {
  png(filename, width = width, height = height, res = res)
  grid::grid.newpage()
  grid::grid.draw(x$gtable)
  dev.off()
}



save_pheatmap_png(heatmapimage, "my_heatmap2.png")


