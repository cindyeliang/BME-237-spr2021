packageVersion("DESeq2")

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

#BiocManager::install("biocLite")
#BiocManager::install("rhdf5")
#BiocManager::install("vctrs")
#BiocManager::install("ellipsis")

#BiocManager::install("devtools")
library("devtools")
#devtools::install_github("pachterlab/sleuth", INSTALL_opts = '--no-lock')

#BiocManager::install("pachterlab/sleuth")
library(sleuth)

sample_id <- c("sample1", "sample2", "sample3", "sample4", "sample5", "sample6")
sample_id
kal_dirs <- file.path("C:/Users/liang/Desktop/kallisto", sample_id)
kal_dirs

s2c <- read.table(file.path("C:/Users/liang/Desktop/kallisto", "metadata.txt"), header=T, stringsAsFactors = F)
s2c <- dplyr::select(s2c, sample = sample, condition)
s2c <- dplyr::mutate(s2c, path = kal_dirs)

s2c


so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE)
so <- sleuth_fit(so, ~condition, 'full')
so <- sleuth_fit(so, ~1, 'reduced')
so <- sleuth_lrt(so, 'reduced', 'full')
sleuth_live(so)

install.packages("gridExtra")
library(gridExtra)

models(so)

sleuth_table <- sleuth_results(so, 'reduced:full', 'lrt', show_all = FALSE)
sleuth_significant <- dplyr::filter(sleuth_table, qval <= 0.05)
head(sleuth_significant, 20)

write.csv(sleuth_significant, "bmefinal-kallisto-res.txt", row.names=TRUE)
write.csv(sleuth_table, "bmefinal-unfilteredkallisto-res.txt", row.names=TRUE)