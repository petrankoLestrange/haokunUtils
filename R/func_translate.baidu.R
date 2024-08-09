#' Translate your data by baidu
#'
#' @param data your data.
#' @param appid your appid of API.
#' @param key your key ou API.
#'
#' @return results of translation.
#' @export
#'
#' @examples donttest{}
func_translate.baidu = function(data, appid = "20240805002116930", key = "s9FjAndS9uQWFIuGiFhh"){
  options("repos" = c(CRAN="https://mirrors.ustc.edu.cn/CRAN/"))
  options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
  pkg = c("fanyi")
  sapply(pkg, simplify = T, function(x){
    if(!require(x,character.only=T)){
      install.packages(x,ask = F,update = F)
      require(x,character.only=T)
    }})
  library(fanyi)
  set_translate_option(appid = appid, key = key)
  return(baidu_translate(data))
}
