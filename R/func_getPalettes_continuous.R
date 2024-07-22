
#' @title Obtain a continuous color palette.
#' @description
#' Based on the RColorBrewer and circlize packages, conveniently obtain a continuous color palette for a range of numerical values.
#' - The function includes a package loading process, utilizing the CRAN mirror from the University of Science and Technology of China for network optimization.
#' @param index_floor The lower boundary of the color palette's numerical range.
#' @param index_middle The middle boundary of the color palette's numerical range.
#' @param index_celling The upper boundary of the color palette's numerical range.
#' @param color_floor The color corresponding to the lower boundary of the color palette.
#' @param color_middle The color corresponding to the middle boundary of the color palette.
#' @param color_celling The color corresponding to the upper boundary of the color palette.
#'
#' @return It returns a function which accepts a vector of numeric values and returns interpolated colors.
#' @export
#'
#' @examples donttest{}
func_getPalettes_continuous = function(index_floor = "blue3",
                            index_middle = "grey",
                            index_celling = "red2",
                            color_floor = -10,
                            color_middle = 0,
                            color_celling = 10){
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
  ##获取连续调色盘
  continuousPalette = colorRamp2(breaks = c(index_floor, index_middle, index_celling),
                                 colors = c(color_floor, color_middle, color_celling)
  )
  return(continuousPalette)
}
