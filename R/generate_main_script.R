#' @title Generate main script.
#'
#' @description
#' Generate the main R script for this project, which includes the global configuration and basic package installation of this project. It is a necessary script for the start of the project.
#'
#' @param target_path Target Generation Path
#' @param overwrite Do you want to overwrite?
#'
#' @return target_path
#' @export
#'
#' @examples donttest{}
generate_main_script = function(target_path, overwrite = FALSE){
  template_path = system.file("./extdata/template_files/main_script.R", package = "vulcan")
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
