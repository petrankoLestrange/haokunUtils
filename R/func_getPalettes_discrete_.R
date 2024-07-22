
#' @title Obtain a discrete color palette.
#'  @description
#'  Based on the RColorBrewer and circlize packages, conveniently obtain a continuous color palette for a range of numerical values.
#'  - The function includes a package loading process, utilizing the CRAN mirror from the University of Science and Technology of China for network optimization.
#' @param legendPath
#' By default, a log folder is created in the working directory to store the legend. You can customize the save folder or specify it as NULL (to output to the console).
#' - You can directly obtain the legend from my server: https://haokun-img-storage-1302331098.cos.ap-chengdu.myqcloud.com/img/discrete_palette.png.
#' @return A character vector including 74 types of color.
#' @export
#'
#' @examples donttest{}
func_getPalettes_discrete = function(legendPath = "./log"){
  options("repos" = c(CRAN="https://mirrors.ustc.edu.cn/CRAN/"))
  options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
  pkg = c("RColorBrewer", "circlize")
  sapply(pkg, simplify = T, function(x){
    if(!require(x,character.only=T)){
      install.packages(x,ask = F,update = F)
      require(x,character.only=T)
    }})
  library(RColorBrewer)
  library(circlize)
  ## 构建颜色向量表
  ### 获取调色盘
  qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
  ###处理后有74种差异还比较明显的颜色
  discretePalette = unlist(mapply(brewer.pal,qual_col_pals$maxcolors, rownames(qual_col_pals)))
  if(!is.null(legendPath)){
    dir.create(legendPath)
    png(paste0(dir, "/discrete_Palette_legend_pie.tiff"), height = 1000, width = 1000, res = 300)
    pie(rep(1,length(discretePalette)), col = discretePalette, radius = 1.07)
    dev.off()
  }else{
    pie(rep(1,length(discretePalette)), col = discretePalette, radius = 1.07)
  }
  return(discretePalette)
}
