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

helpers <- c("devtools", "remotes", "batchelor", "pcaMethods")
for (helper in helpers)
  if (!suppressWarnings(require(builtin, character.only=TRUE)))
    suppressWarnings(install.packages(builtin, ask=FALSE))

std_pkgs <- c(
  "SingleCellExperiment", "scater", "scran", "scDblFinder",
  "ggthemes", "ggridges", "reshape2" , "ggpubr", "ggplot2", "ggrastr", "patchwork",
  "viridis", "shiny",
  "tidyverse", "plyr", "BiocParallel",
  "mclust", "DT", "DescTools", "tradeSeq",
  "edgeR", "Rtsne", "scales",
  "slingshot" , "UpSetR", 
  "clusterExperiment", "clusterProfiler", "scHOT", "org.Mm.eg.db",
  "CiteFuse"
)
remotes::install_github("satijalab/seurat", "seurat5", quiet = TRUE)

gh_pkgs <- c("MarioniLab/DropletUtils",
"jokergoo/ComplexHeatmap",
"immunogenomics/presto",
"PYangLab/Cepo",
"cole-trapnell-lab/monocle3")

builtins <- c(std_pkgs, gh_pkgs)

for (builtin in builtins)
  if (!suppressWarnings(require(builtin, character.only=TRUE)))
    suppressWarnings(BiocManager::install(builtin,
                                          version="3.18",
                                          update=TRUE, ask=FALSE))
