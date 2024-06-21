  # DO NOT EDIT 'install.R'; instead, edit 'install.R.in' and
# use 'rake' to generate 'install.R'.

if ("BiocManager" %in% rownames(installed.packages()))
  remove.packages("BiocManager")

install.packages("BiocManager", repos="https://cran.rstudio.com")
library(BiocManager)

if(BiocManager::version() != "3.18"){
  BiocManager::install(version="3.18",
                       update=TRUE, ask=FALSE)
}

# install dependency from source
install.packages("https://cran.r-project.org/src/contrib/Archive/howmany/howmany_0.3-1.tar.gz", repos=NULL, type="source")
install.packages('caret', dependencies = TRUE)
install.packages('glue')
install.packages('data.table')
install.packages("aricode")
install.packages("umap")
install.packages('ggcorrplot')
install.packages('pheatmap')

helpers <- c("devtools", "remotes", "batchelor", "pcaMethods")
for (helper in helpers)
  if (!suppressWarnings(require(helper, character.only=TRUE)))
    suppressWarnings(install.packages(helper, ask=FALSE))

std_pkgs <- c(
  "SingleCellExperiment", "scater", "scran", "scDblFinder",
  "ggthemes", "ggridges", "reshape2" , "ggpubr", "ggplot2", "ggrastr", "patchwork",
  "viridis", "shiny", "Signac", "EnsDb.Hsapiens.v86",
  "tidyverse", "plyr", "BiocParallel",
  "mclust", "DT", "DescTools", "tradeSeq",
  "edgeR", "Rtsne", "scales",
  "slingshot" , "UpSetR", 
  "clusterExperiment", "clusterProfiler", "scHOT", "org.Mm.eg.db",
  "BSgenome.Hsapiens.UCSC.hg38", "scuttle", "igraph", "CiteFuse",
  'rhdf5', 'HDF5Array', 'rtracklayer', 'GenomicRanges', 'scClassify',
)
remotes::install_github("satijalab/seurat", "seurat5", quiet = TRUE)
remotes::install_github("mojaveazure/seurat-disk", quiet = TRUE)

gh_pkgs <- c("MarioniLab/DropletUtils",
"jokergoo/ComplexHeatmap",
"immunogenomics/presto",
"PYangLab/Cepo",
"cole-trapnell-lab/monocle3",
"mojaveazure/seurat-disk")

builtins <- c(std_pkgs, gh_pkgs)

for (builtin in builtins)
  if (!suppressWarnings(require(builtin, character.only=TRUE)))
    suppressWarnings(BiocManager::install(builtin,
                                          version="3.18",
                                          update=TRUE, ask=FALSE))
