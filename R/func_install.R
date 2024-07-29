#' @title install packages
#'
#' @param pkg_list pkg_list should be a List which includes CRAN, biocManager, or github vecter conteining packages names.
#' @param repos repos.
#' @param BioC_mirror biocManager repos.
#' @param update defult false.
#'
#' @return means nothing
#' @export
#'
#' @examples donttest{}
func_install = function(pkg_list, repos = c(CRAN="https://mirrors.ustc.edu.cn/CRAN/"), BioC_mirror = "https://mirrors.ustc.edu.cn/bioc/", update = FALSE){
  library(tidyverse)
  library(BiocManager)
  library(devtools)
  options("repos" = repos)
  options(BioC_mirror = BioC_mirror)

  # pkg_list = list(
  #   CRAN = c("ggplot2", "ggbubr"),
  #   github = c("MRCIEU/TwoSampleMR")
  # )
  if(!is.list(pkg_list)){
    stop("pkg_list is not a List!")
  }
  warning("pkg_list需要是一个列表，内含各类包名的向量，向量需要命名为CRAN, biocManager或github，否则将无法正常装包")
  if(any(names(pkg_list) == "CRAN")){
    pkg = pkg_list["CRAN"]$CRAN
    sapply(pkg, simplify = T, function(x){
      if(!require(x,character.only=T)){
        install.packages(x,ask = F,update = F)
        require(x,character.only=T)
      }})
  }
  if(any(names(pkg_list) == "biocManager")){
    pkg = pkg_list["biocManager"]$biocManager
    sapply(pkg, simplify = T, function(x){
      if (! require(x,character.only=T) ) {
        BiocManager::install(x,ask = F,update = F)
        require(x,character.only=T)
      }})
  }
  if(any(names(pkg_list) == "github")){
    pkg = pkg_list["github"]$github
    sapply(pkg, simplify = T, function(x){
      devtools::install_github(pkg)
      })
  }
}
