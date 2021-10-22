g3_read_amp <- function(g3index){

  main <- readr::read_file(paste0(g3index, ".CSV")) %>%
    read_lines()

  jobindex <- main[1] %>%
    str_split(pattern = "\t", simplify = TRUE) %>%
    .[,2]


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

  ### amplification data...

  amptib <- read_tsv(paste0(g3index, "-Amplification.CSV"), skip = 13, col_names = FALSE,
                     show_col_types = FALSE) %>%
    .[-c(2:9 * 2 - 1)]

  colnames(amptib) <- c("time", sumtib$well)


  amptib <- amptib %>% pivot_longer(-time, names_to = "dna", values_to = "flr")



  g3obj <- list(jobname = jobname, logpath = logpath,
                jobindex = jobindex, jobtime = jobtime,
                sumtib = sumtib, amplification = amptib)

  return(g3obj)

}
