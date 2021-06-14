# BME-237-spr2021: Repository of R scripts & terminal commands used to complete RNA Bioinformatics problem sets
This readme lists each file and describes what they are in relation to my assignments

## List of projects from most recent->oldest

**Final project: Performance evaluation of different differential expression pipelines using publically available sequencing data**
* **Dataset:** NBCI-SRA SRP126155 
* **Pipelines:** STAR>HTSEQ-count>DESq2 ; Kallisto>Sleuth
* **Analytical benchmarks & QC:** FastP, FastQC, diffexp comparison between housekeeping genes in human lung bronchial epithelial cells (HBECs) not expected to be differentially expressed (negative ctrl) & genes validated by qPCR to be differentially expressed in HBECs exposed to cigarette smoke (positive ctrl). 
* **Conclusion:** Only Kallisto/Sleuth was able to recapitulate differential expression of positive control gene CYP1A1 in its heatmap. This gene may have failed to show up in DESeq2's heatmap clustering despite appearing in DESeq2's significantly differentially expressed genes because of an outlier HTSeq-count .txt result in CSC sample 3.

**Problem set 7: Reproduce published results of eCLIP peaks found in different regions of pre-mRNA or non-coding RNAs for RNA binding proteins UPF1 & PTBP1. https://www.nature.com/articles/s41586-020-2077-3**
* **Dataset:** Reproducible eCLIP peaks from K562 cell line. Encode accession #s ENCFF597NVR (UPF1 peaks), ENCFF907HNN (PTBP1 peaks)
* **Pipelines:** bedtools
* **Conclusion:** The fractions of reproducible eCLIP peaks for UPF1 and PTBP1 in the K562 cell line is similar to the fractions of peaks for these proteins in the HepG2 cell line.

**Problem set 2: Re-analysis of HOXA1 KD effect on gene expression using DESeq2**
* **Dataset:** Illumina MiSeq of human primary lung fibroblasts WT & KD for HOXA1. Encode accession #s SRR493372, SRR493373, SRR493374 (WT); SRR493375, SRR493376, SRR493377 (KD)
* **Pipelines:** HISAT2>HTSeq-count>DESeq2
* **Conclusions:** Trapnell et al. found TBX3, CDC14B, CDK2, and ORC6 to be differentially expressed between WT & KD cells. Only TBX3 & CDK2 were found by my analysis with FDR < 1%. The other genes could have been missed by my analysis because of our different aligners (Trapnell et al. used Tophat2, Hisat2's predecessor). When Tophat2 alignment is compared with HISAT2 on human fetal lung fibroblast short-read RNA seq data in "HISAT: a fast spliced aligner with low memory requirements", Tophat2 aligns fewer reads than HISAT2. Tophat2's alignment accuracy for human RNA-seq appears lower than HISAT2 in that comparison so the extra genes may have been inaccurately counted by Tophat2.

**Problem set 1:** Comparison of splice junctions found by alignment methods STAR vs. HISAT2
* **Dataset:** paired-end (76bp) mRNA sequencing of lung fibroblast primary cells. Encode accession #s ENCFF000IJA (read 1), ENCFF000IJH (read 2)
* **Pipelines:** STAR>Regtools ; HISAT2>Regtools
* **Conclusions:** STAR>Regtools detected 146054 unique splice junctions, while HISAT2 detected 159451. HISAT2 may have detected more unique SJs than STAR because HISAT2 is better at aligning intron-spanning reads with small anchors (1–7 bp aligned to one of the exons) but does not perform as well for reads with long anchors. It’s possible the junctions not detected by HISAT2 had longer anchors.

## File & Description
* Final-project-terminal-commands `Terminal commands from downloading dataset to getting Kallisto & HTSeq-count output for R`
* final_deseq2_script.R `R script for running DESeq2 on HTSeq-count files`
* final_kallistosleuth_script.R `R script for running Sleuth from Kallisto files`
* ps7-terminal-commands `Terminal commands for using bedtools to find reproducible eCLIP peaks for UPF1 & PTBP1`
* ps2-terminal-and-R-commands `Terminal & R commands for using Hisat2>HTSeq-count>DESeq2`
* ps1-terminal-commands `Terminal commands for comparing splice junctions found by STAR vs. HISAT2`
