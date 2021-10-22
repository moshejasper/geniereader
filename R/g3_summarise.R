g3_summarise <- function(g3obj, threshold = 20000){
  g3obj$amplification %>%
    group_by(well) %>%
    filter( flr > threshold) %>%
    summarise(sample = max(sample), threshold_time = min(time)/60, flr = min(flr))

}
