#' mouse dentate gyrus hippocampus unprocessed scRNA-seq dataset
#'
#' Data from Hochgerner et al. (2018) which contains the raw counts matrix and metadata in a #' SingleCellExperiment Object
#'
#' @usage data(hippocampus_all_ages, package = "SCMultiomeCNRSR")
#'
#' @references Hochgerner, H., Zeisel, A., Lönnerberg, P. et al.
#' Conserved properties of dentate gyrus neurogenesis across postnatal
#' development revealed by single-cell RNA sequencing.
#' Nat Neurosci 21, 290–299 (2018). https://doi.org/10.1038/s41593-017-0056-2
#'
#' @source Gene Expression Omnibus with the accession code GSE104323.
"hippocampus_all_ages"

#' mouse dentate gyrus hippocampus processed scRNA-seq dataset
#'
#' Data from Hochgerner et al. (2018) which contains the raw counts matrix and metadata in a #' SingleCellExperiment Object after performing basic pre-processing 
#' 
#' @usage data(hippocampus_processed, package = "SCMultiomeCNRSR")
"hippocampus_processed"

#' subset of mouse dentate gyrus hippocampus processed scRNA-seq dataset
#'
#' the mouse dentate gyrus hippocampus processed scRNA-seq dataset further
#' subsetted for cells in P0 and P5 stages showcasing cell types from two lineages
#'
#' @usage data(hippocampus_minimal, package = "SCMultiomeCNRSR")
"hippocampus_minimal"

#' wilcox DE test results for clustering results
#'
#' Data generated after running FindMarkers from Seurat for cluster 1
#' after performing louvain clustering. Output in a SeuratObject.
#'
#' @usage data(cluster1.markers_RNA_snn_res.0.1, package = "SCMultiomeCNRSR")
"cluster1.markers_RNA_snn_res.0.1"

#' output from fitting the NB-GAM model in TradeSeq
#'
#' Data generated after running fitGAM to model gene expression changes as a
#' function of pseudotime. Output as a SlingShot Object.
#'
#' @usage data(slingshot_umap, package = "SCMultiomeCNRSR")
"slingshot_umap"

#' output from running clusterExpressionPattern from TradeSeq
#'
#' Data generated after clustering the genes along the pseudotime for each lineage.
#'
#' @usage data(clusPat, package = "SCMultiomeCNRSR")
"clusPat"

#' scHOT output to identify differentially correlated gene pairs.
#'
#' Data generated after running scHOT function to identify gene pairs that vary
#' in correlation across pseudotime.
#'
#' @usage data(scHOT_obj, package = "SCMultiomeCNRSR")
"scHOT_obj"
