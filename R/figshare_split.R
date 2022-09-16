# Load packages and sheets
pacman::p_load("dplyr", "tidyr")
figs <- read.csv("Data/figs.csv")
figs_sources <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTitzfoGBVhnBHkXcxBJezuMulBBkP3skLXCZ6v4PTVd-k6yVzn6yWTF1Fyt4VVY0T4nRTIvBcWapJw/pub?output=csv")

# Split figs
col_nums <- c(13:35)
figs_list <- list()
col_order <- c(1,5,6,3,4,7,2,8,9)

# map sources evidence type over
map_evidence <- function(source_name){
      index <- match(source_name, figs_sources$sources)
      return(figs_sources$Evidence[index])
}

for (x in col_nums){
      temp <- as.data.frame(figs[,c(2,4,5,x)])
      temp <- temp[!is.na(temp[[4]]),]
      temp$Genome_ID <- NA
      temp$Accession_ID <- NA
      temp$Attribute_value <- TRUE
      temp$Evidence <- map_evidence(temp$data_source)
      temp$Frequency <- "always"
      temp <- temp[,col_order]
      
      figs_list <- append(figs_list, list(temp))
}

names(figs_list) = colnames(figs)[13:35]
temp <- figs_list[[1]]
