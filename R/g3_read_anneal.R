#' Read Genie-III csv summary + anneal file duo
#'
#' Takes character file location & name of a Genie csv set (minus the endings) and returns a list of
#' summary and anneal data for the object, ready for further processing
#'
#' @param g3index character. Filepath and 'common' filename of the Genie-III csv trio. Should NOT include
#' either the .CSV ending or any fileendings after and including a - symbol (so if file is X/Gen123-Anneal),
#' would input 'X/Gen123'
#'
#' @return returns a list containing key information about the Genie-III experiment run and tibbles covering
#' summary and anneal data.
#' @export
#'
#' @examples
#' g3_read_anneal("test")
g3_read_anneal <- function(g3index){

  main <- readr::read_file(paste0(g3index, ".CSV")) %>%
    read_lines()

  jobindex <- main[1] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,3] %>% str_split(patter = "_", simplify = TRUE)
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


  ### anneal data

  anntib <- read_tsv(paste0(g3index, "-Anneal.CSV"), skip = 13, col_names = FALSE,
                     show_col_types = FALSE) %>%
    .[-c(2:9 * 2 - 1)]

  colnames(anntib) <- c("temp", sumtib$well)


  anntib <- anntib %>% pivot_longer(-temp, names_to = "dna", values_to = "flr")

  g3obj <- list(jobname = jobname, logpath = logpath,
                jobindex = jobindex, jobtime = jobtime,
                sumtib = sumtib, anneal = anntib)

  return(g3obj)

}
