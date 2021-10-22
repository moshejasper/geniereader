g3_graph_anneal <- function(g3obj){
  gg <- ggplot(g3obj$anneal) +
    aes(x = temp, y = flr, colour = dna) +
    geom_line()+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Temperature (C)") + ylab("Derivative (F/C)") +
    theme_bw()
  return(gg)
}

g3_graph_amp <- function(g3obj){
  gg <- ggplot(g3obj$amplification) +
    aes(x = time, y = flr, colour = dna) +
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Time (sec)") + ylab("Fluorescence") +
    geom_line() +
    theme_bw()
  return(gg)
}
