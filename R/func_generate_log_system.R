#' @title generate a log system for your project
#'
#' @return none.
#'
#' @examples donttest{}
func_generate_log_system = function(){
  library(data.table)
  warning("将在当前项目根目录下，新建log_RMD、log文件夹及项目初始特性表")
  template_path = system.file("extdata", "template_files", "main_log.rmd", package = "vulcan")
  if (is.null(template_path) | template_path == "") {
    stop("Template file not found in package.")
  }
  # 检查生成目录位置是否存在，不存在则创建
  if (!dir.exists(dirname("./log"))) {
    dir.create(dirname("./log"), recursive = TRUE)
    cat(paste0("日志路径不存在，已创建：", "./log"))
  }
  # 复制模板文件至"./log"
  file.copy(template_path, "./globl_log.Rmd", overwrite = overwrite)
  # 在/log新建日志表
  fwrite(data.frame(
    date = NA,
    description = NA,
    log = NA
  ), file = "./log/01_main_log.csv")
  # 返回复制后的文件路径
  return("./log")
}
