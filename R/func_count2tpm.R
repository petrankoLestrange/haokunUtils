#' @title Convert Count to TPM
#' @description
#' Convert the raw read counts from high-throughput transcriptome sequencing to transcripts per million (TPM) normalized data.
#' - The function includes a package loading process, utilizing the CRAN mirror from the University of Science and Technology of China for network optimization.
#'
#' @param count_data
#' The raw count reads from high-throughput transcriptome sequencing must be in their original state and should not be subjected to log2 transformation or any other normalization processes.
#' @param annotation_gtf_dir
#' The path to the annotation file that includes transcript lengths must ensure consistency with the sequencing batch and platform version of the count data. For example, the version number corresponding to the count data at Xena-GDC is version 22 (this function provides the annotation file for version 22 by default).
#' - The channel for obtaining the annotation file is the "Annotation Files" section on the following website: https://gdc.cancer.gov/about-data/gdc-data-processing/gdc-reference-files.
#'
#' @return The completed TPM (Transcripts Per Million) normalized expression matrix.
#' @export
#'
#' @examples donttest{}
func_count2tpm = function(count_data, annotation_gtf_dir = "./extdata/gencode.v22.annotation.gtf.gz"){
  # 安装必备包
  options("repos" = c(CRAN="https://mirrors.ustc.edu.cn/CRAN/"))
  options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
  pkg = c("txdbmaker", "GenomicFeatures", "DGEobj.utils", "AnnoProbe")
  sapply(pkg, simplify = T, function(x){
    if (! require(x,character.only=T) ) {
      BiocManager::install(x,ask = F,update = F)
      require(x,character.only=T)
    }})
  library(GenomicFeatures)
  library(DGEobj.utils)
  library(AnnoProbe)
  # 读取基因组注释文件
  txdb = makeTxDbFromGFF(annotation_gtf_dir, format = "gtf")
  # 获取每个基因id的外显子数据
  exons.list.per.gene = exonsBy(txdb, by="gene")
  # 对于每个基因，将所有外显子减少成一组非重叠外显子，计算它们的长度(宽度)并求和
  exonic.gene.sizes = sum(width(GenomicRanges::reduce(exons.list.per.gene)))
  # 得到geneid和长度数据
  gfe = data.frame(gene_id=names(exonic.gene.sizes),
                   length=exonic.gene.sizes)
  # 去除版本号
  gfe$gene_id = str_split(gfe$gene_id, "\\.", simplify = T)[,1]

  # 同步矩阵和gfe内容和顺序
  filter = intersect(rownames(count_data), gfe$gene_id)
  count_data = count_data[rownames(count_data) %in% filter, ]
  gfe = gfe[gfe$gene_id %in% filter, ]
  if(!identical(rownames(count_data), gfe$gene_id)){
    gfe = gfe[match(rownames(count_data), gfe$gene_id), ]
  }
  if(!identical(rownames(count_data), gfe$gene_id)){
    stop("错误！基因长度列表并未和矩阵行名完成同步！")
  }
  # 进行转换
  res = convertCounts(
    countsMatrix = as.matrix(count_data),
    unit = "TPM",
    geneLength = gfe$length,
    log = FALSE,
    normalize = "none",
    prior.count = NULL
  )
  return(res)
}
