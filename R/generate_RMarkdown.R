#' @title Generate RMarkdown.
#'
#' @description
#' Generate the main R script for this project, which includes the global configuration and basic package installation of this project. It is a necessary script for the start of the project.
#'
#' @param type Specified RMarkdown styles, should be one of the "downcute", "html_clean", "meterial", "readthedown", and "robobook".
#' @param target_path file path
#' @param overwrite Do you want to overwrite?
#'
#' @return file path
#' @export
#'
#' @examples donttest{}
generate_RMarkdown = function(type, target_path, overwrite = FALSE){
  if(!(type %in% c("downcute", "html_clean", "meterial", "readthedown", "robobook"))){
    stop("type need to take the following specified values: downcute, html_clean, meterial, readthedown, and robobook")
  }
  template_path = system.file(paste0("./extdata/template_files/", type, "_RMD.rmd"), package = "vulcan")
  if (is.null(template_path) | template_path == "") {
    stop("Template file not found in package.")
  }
  # 检查生成目标路径是否存在，不存在则创建
  if (!dir.exists(dirname(target_path))) {
    dir.create(dirname(target_path), recursive = TRUE)
    cat(paste0("目标路径不存在，已创建：", target_path))
  }
  # 复制模板文件至指定路径
  file.copy(template_path, target_path, overwrite = overwrite)
  # 返回复制后的文件路径
  return(target_path)
}
