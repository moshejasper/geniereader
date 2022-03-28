#' Read Genie-III csv trio
#'
#' Takes character file location & name of a Genie csv set (minus the endings) and returns a list of
#' summary, anneal, and amplification data for the object, ready for further processing
#'
#' @param g3index character. Filepath and 'common' filename of the Genie-III csv trio. Should NOT include
#' either the .CSV ending or any fileendings after and including a - symbol (so if file is X/Gen123-Anneal),
#' would input 'X/Gen123'
#'
#' @return returns a list containing key information about the Genie-III experiment run and tibbles covering
#' summary, anneal, and amplification data.
#' @export
#'
g3_read <- function(g3index){

  main <- readr::read_file(paste0(g3index, ".CSV")) %>%
    read_lines()

  if (stringr::str_starts(main[2], "Experiment")){
    newformat <- FALSE
  }
  else {
    newformat <- TRUE
  }

  jobindex <- main[1] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,3] %>% str_split(pattern = "_", simplify = TRUE)
  jobindex <- jobindex[length(jobindex)] %>% str_sub(end = str_length(.) - 4)

  logpath <- main[1] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,3]

  #print(logpath)

  if (newformat){
    jobname <- main[3] %>%
      str_split(pattern = "\t", simplify = TRUE) %>%
      .[,2] %>%
      str_sub(2, str_length(.) - 1)

    jobtime <- main[4] %>%
      str_split(pattern = "\t", simplify = TRUE) %>%
      .[,3]
  }
  else {
    jobname <- main[2] %>%
      str_split(pattern = "\t", simplify = TRUE) %>%
      .[,2] %>%
      str_sub(2, str_length(.) - 1)

    jobtime <- main[3] %>%
      str_split(pattern = "\t", simplify = TRUE) %>%
      .[,2]
  }

  if (newformat){
    sumtib <- read_tsv(paste0(g3index, ".CSV"), skip = 11, col_names = FALSE,
                       show_col_types = FALSE)
  }
  else{
    sumtib <- read_tsv(paste0(g3index, ".CSV"), skip = 7, col_names = FALSE,
                       show_col_types = FALSE)
  }

  sumtib <- sumtib[1:8]

  names(sumtib) <- c("num", "well", "type", "b1", "time", "b2", "temp", "temptype")
  sumtib <- sumtib %>%
    filter(! type == "Yellow") %>%
    select(num, well, time, temp)

  sumtib$num <- 1:nrow(sumtib)

  ### amplification data...

  amptib <- read_tsv(paste0(g3index, "-Amplification.CSV"), skip = 13, col_names = FALSE,
                     show_col_types = FALSE) %>%
    .[-c(2:9 * 2 - 1)]

  colnames(amptib) <- c("time", paste0("x", 1:8))


  amptib1 <- amptib %>% pivot_longer(-time, names_to = "well", values_to = "flr")
  colnames(amptib) <- c("time", sumtib$well)
  amptib2 <- amptib %>% pivot_longer(-time, names_to = "sample", values_to = "flr")
  amptib <- amptib1 %>% add_column(sample = amptib2$sample)

  ### anneal data

  anntib <- read_tsv(paste0(g3index, "-Anneal.CSV"), skip = 13, col_names = FALSE,
                     show_col_types = FALSE) %>%
    .[-c(2:9 * 2 - 1)]

  colnames(anntib) <- c("temp", paste0("x", 1:8))


  anntib1 <- anntib %>% pivot_longer(-temp, names_to = "well", values_to = "flr")
  colnames(anntib) <- c("temp", sumtib$well)
  anntib2 <- anntib %>% pivot_longer(-temp, names_to = "sample", values_to = "flr")
  anntib <- anntib1 %>% add_column(sample = anntib2$sample)

  g3obj <- list(jobname = jobname, logpath = logpath,
                jobindex = jobindex, jobtime = jobtime,
                sumtib = sumtib, amplification = amptib, anneal = anntib)

  return(g3obj)

}
