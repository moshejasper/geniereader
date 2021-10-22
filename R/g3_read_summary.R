#' Read Genie-III csv summary file
#'
#' Takes character file location & name of a Genie csv set (minus the endings) and returns
#' summary data for the object, ready for further processing
#'
#' @param g3index character. Filepath and 'common' filename of the Genie-III csv trio. Should NOT include
#' either the .CSV ending
#'
#' @return returns a list containing key information about the Genie-III experiment run and tibbles covering
#' the summary data.
#' @export
#'
g3_read_summary <- function(g3index){

  main <- readr::read_file(paste0(g3index, ".CSV")) %>%
    read_lines()

  jobindex <- main[1] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,3] %>% str_split(pattern = "_", simplify = TRUE)
  jobindex <- jobindex[length(jobindex)] %>% str_sub(end = str_length(.) - 4)


  logpath <- main[1] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,3]

  print(logpath)

  jobname <- main[2] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,2] %>%
    str_sub(2, str_length(.) - 1)

  jobtime <- main[3] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,2]

  sumtib <- read_tsv(paste0(g3index, ".CSV"), skip = 7, col_names = FALSE,
                     show_col_types = FALSE)
  sumtib <- sumtib[1:8]

  names(sumtib) <- c("num", "well", "type", "b1", "time", "b2", "temp", "temptype")
  sumtib <- sumtib %>%
    filter(! type == "Yellow") %>%
    select(num, well, time, temp)

  sumtib$num <- 1:nrow(sumtib)


  g3obj <- list(jobname = jobname, logpath = logpath,
                jobindex = jobindex, jobtime = jobtime,
                sumtib = sumtib)

  return(g3obj)

}

