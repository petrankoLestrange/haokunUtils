# Global configuration
Sys.setenv(R_MAX_NUM_DLLS=999)
options(stringsAsFactors = F)
memory.limit(102400)
options(download.file.method = 'libcurl')
options(url.method='libcurl')

# Base R package installation and configuration
options("repos" = c(CRAN="https://mirrors.ustc.edu.cn/CRAN/"))
if(!require("BiocManager")) install.packages("BiocManager",update = F,ask = F)
library(BiocManager)
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")

# install basic CRAN packages
packages.CRAN =
  c("tidyverse",
    "ggplot2",
    "ggpubr",
    "tidyverse",
    "data.table",
    "rmarkdown",
    #"tinytex",
    "knitr",
    "rmdformats",
    "rticles",
    "kableExtra"
    )
for (pkg in packages.CRAN){
  #先检查环境中是否存在该包，没有的话则安装
  if (! require(pkg,character.only=T) ) {
    install.packages(pkg,ask = F,update = F)
    require(pkg,character.only=T)
  }
}
