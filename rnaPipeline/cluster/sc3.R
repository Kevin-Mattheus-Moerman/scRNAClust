#======================================================================================================
# CLUSTER - SC3
#======================================================================================================

#======================
# argparse library
#======================
suppressMessages(library(argparse))
suppressMessages(library(SingleCellExperiment))
suppressMessages(library(SC3))
suppressMessages(library(scater))
suppressMessages(library(cowplot))


RSCRIPT <- "Rscript"


#======================
# arguments
#======================

# create parser object
parser <- ArgumentParser()

parser$add_argument("--name_dataset", type="character", help="name of the dataset")
parser$add_argument("--input_directory", default="None", type="character", help="path to directory containing preprocessed ssRNASeq data")
parser$add_argument("--data_output_directory", type="character", help="Path to the cluster data output directory")
parser$add_argument("--console_output_directory", type="character", help="Path to the .out file output directory")

args <- parser$parse_args()
print(args)

data_outdir <- args$data_output_directory
dir.create(file.path(data_outdir), showWarnings=FALSE, recursive=TRUE)

console_outdir <- args$console_output_directory
dir.create(file.path(console_outdir), showWarnings=FALSE, recursive=TRUE)

all_preprocessed_ssRNASeq_files <- list.files(args$input_directory, pattern="*.csv*")
print(all_preprocessed_ssRNASeq_files)

for (c in 1:length(all_preprocessed_ssRNASeq_files)){
  print(c)
  print(all_preprocessed_ssRNASeq_files)
  ### Create data frame
  data=read.csv(file.path(args$input_directory, all_preprocessed_ssRNASeq_files[c]),row.names = 1)
  print("  ...read")
  
  ### Cluster
  sce <- SingleCellExperiment(
    assays  = list(
      counts = as.matrix(data),
      normcounts = as.matrix(data),
      logcounts = as.matrix(data)))
  
  
  rowData(sce)$feature_symbol <- rownames(sce)
  sce <- sce[!duplicated(rowData(sce)$feature_symbol), ]
  
  sce <- runPCA(sce)
  
  ### Plot
  plot1=plotPCA(sce)
  save_plot(paste0(data_outdir,"/PCA_",c,"_",args$name_dataset,".pdf"),plot1)
  dev.off()
  print("  ...plot PCA")
  
  sce <- sc3_estimate_k(sce)
  optimal_K <- metadata(sce)$sc3$k_estimation
  print(optimal_K)
  
  sce <- sc3(sce, ks=optimal_K, biology=F)
  
  p_Data <- colData(sce)
  
  
  write.csv(p_Data, file=paste0(data_outdir,"/sc3_",args$name_dataset,".csv"))
  print("  ...export to .csv")
  
  rm(list = ls())

}

print("DONE")

#======================================================================================================