# process day 1 demo data into sce object

counts = as.matrix(read.delim2("/Users/cchen/Dropbox (Sydney Uni)/workshop-CNRS/SCMultiome-CNRS-workshop-R/data/GSE104323_10X_expression_data_V2.tab.gz", row.names=1))
annot = read.delim2("/Users/cchen/Dropbox (Sydney Uni)/workshop-CNRS/SCMultiome-CNRS-workshop-R/data/GSE104323_metadata_barcodes_24185cells.txt.gz")

# tidy names 
colnames(annot) = janitor::make_clean_names(colnames(annot))
annot$cell_name = gsub("-", "", annot$sample_name_24185_single_cells)
colnames(counts) = gsub("^X|\\.", "", colnames(counts))
sum(annot$cell_name %in% colnames(counts))
colnames(annot) <- c("sample_name", "source_name", "organism", "strain", "age", "sex_of_pooled_animals", "cell_cluster", "molecule", "srr_run_accession", "raw_file_original_file_name", "umi_cellular_barcode", "cell_name")

sce = SingleCellExperiment::SingleCellExperiment(assays=list(counts=counts[,colnames(counts) %in% annot$cell_name]))
annot = annot[!duplicated(annot$cell_name), ]
rownames(annot) = annot$cell_name
colData(sce) = S4Vectors::DataFrame(annot[colnames(sce), ])
rowData(sce) = S4Vectors::DataFrame(gene_name = rownames(sce))
rownames(sce) = toupper(rownames(sce))
sce = sce[!duplicated(rownames(sce)), ]

saveRDS(sce, "/Users/cchen/Dropbox (Sydney Uni)/workshop-CNRS/SCMultiome-CNRS-workshop-R/data/sce_DentateGyrus_hippocampus_all_ages.rds")
