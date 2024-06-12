require(future)
require(pbapply)
require(future.apply)

Extend <- function(x, upstream = 0, downstream = 0) {
  if (any(GenomicRanges::strand(x = x) == "*")) {
    warning("'*' ranges were treated as '+'")
  }
  on_plus <- GenomicRanges::strand(x = x) == "+" | GenomicRanges::strand(x = x) == "*"
  new_start <- GenomicRanges::start(x = x) - ifelse(test = on_plus, yes = upstream, no = downstream)
  new_end <- GenomicRanges::end(x = x) + ifelse(test = on_plus, yes = downstream, no = upstream)
  IRanges::ranges(x = x) <- IRanges::IRanges(start = new_start, end = new_end)
  x <- GenomicRanges::trim(x = x)
  return(x)
}

require(rtracklayer)
require(GenomicRanges)

CreateGeneActivityMatrix2 <- function(
  peak.matrix,
  annotation.file,
  seq.levels = c(1:22, "X", "Y"),
  include.body = TRUE,
  upstream = 2000,
  downstream = 0,
  keep.sparse = FALSE,
  verbose = TRUE,
  seq_replace = str
)
  {
  # convert peak matrix to GRanges object
  peak.df <- rownames(x = peak.matrix)
  peak.df <- do.call(what = rbind, args = strsplit(x = gsub(peak.df, pattern = seq_replace, replacement = "-"), split = "-"))
  peak.df <- as.data.frame(x = peak.df)
  colnames(x = peak.df) <- c("chromosome", 'start', 'end')
  peaks.gr <- GenomicRanges::makeGRangesFromDataFrame(df = peak.df)
  
  # if any peaks start at 0, change to 1
  # otherwise GenomicRanges::distanceToNearest will not work
  BiocGenerics::start(peaks.gr[BiocGenerics::start(peaks.gr) == 0, ]) <- 1
  
  # get annotation file, select genes
  gtf <- rtracklayer::import(con = annotation.file)
  gtf <- GenomeInfoDb::keepSeqlevels(x = gtf, value = seq.levels, pruning.mode = 'coarse')
  # change seqlevelsStyle if not the same
  
  if (!any(GenomeInfoDb::seqlevelsStyle(x = gtf) == GenomeInfoDb::seqlevelsStyle(x = peaks.gr))) {
    GenomeInfoDb::seqlevelsStyle(gtf) <- GenomeInfoDb::seqlevelsStyle(peaks.gr)
  }
  
  gtf.genes <- gtf[gtf$type == 'gene']
  # Extend definition up/downstream
  
  if (include.body) {
    gtf.body_prom <- Extend(x = gtf.genes, upstream = upstream, downstream = downstream)
  } else {
    gtf.body_prom <- SummarizedExperiment::promoters(x = gtf.genes, upstream = upstream, downstream = downstream)
  }
  
  gene.distances <- GenomicRanges::distanceToNearest(x = peaks.gr, subject = gtf.body_prom)
  keep.overlaps <- gene.distances[rtracklayer::mcols(x = gene.distances)$distance == 0]
  peak.ids <- peaks.gr[S4Vectors::queryHits(x = keep.overlaps)]
  gene.ids <- gtf.genes[S4Vectors::subjectHits(x = keep.overlaps)]
  
  # Some GTF rows will not have gene_name attribute
  # Replace it by gene_id attribute
  gene.ids$gene_name[is.na(gene.ids$gene_name)] <- gene.ids$gene_id[is.na(gene.ids$gene_name)]
  peak.ids$gene.name <- gene.ids$gene_name
  peak.ids <- as.data.frame(x = peak.ids)
  peak.ids$peak <- rownames(peak.matrix)[S4Vectors::queryHits(x = keep.overlaps)]
  annotations <- peak.ids[, c('peak', 'gene.name')]
  colnames(x = annotations) <- c('feature', 'new_feature')
  # collapse into expression matrix
  if (!keep.sparse) {
    peak.matrix <- as(object = peak.matrix, Class = 'matrix')
  }
  
  all.features <- unique(x = annotations$new_feature)
  if (nbrOfWorkers() > 1) {
    mysapply <- future_sapply
  } else {
    mysapply <- ifelse(test = verbose, yes = pbsapply, no = sapply)
  }
  
  newmat.list <- mysapply(X = 1:length(x = all.features), FUN = function(x){
    features.use <- annotations[annotations$new_feature == all.features[[x]], ]$feature
    submat <- peak.matrix[features.use, ]
    if (length(x = features.use) > 1) {
      submat <- Matrix::colSums(submat)
    }
    if (keep.sparse) {
      return(as(object = as.matrix(submat), Class = 'dgCMatrix'))
    } else {
      return(as.matrix(submat))
    }
  }, simplify = FALSE)
  
  newmat = do.call(what = cbind, args = newmat.list)
  newmat <- t(x = newmat)
  rownames(x = newmat) <- all.features
  return(as(object = newmat, Class = 'dgCMatrix'))
}