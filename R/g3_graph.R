g3_graph_anneal <- function(g3obj){
  gg <- ggplot(g3obj$anneal) +
    aes(x = temp, y = flr, colour = dna) +
    geom_line(size = 1)+
    scale_color_manual(
      values = viridis::viridis(8),
      breaks = g3obj$sumtib$well,
    )+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Temperature (C)") + ylab("Derivative (F/C)") +
    theme_bw()
  return(gg)
}

g3_graph_amp <- function(g3obj){
  gg <- ggplot(g3obj$amplification) +
    aes(x = time, y = flr, colour = dna) +
    scale_color_manual(
      values = viridis::viridis(8),
      breaks = g3obj$sumtib$well,
    )+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Time (sec)") + ylab("Fluorescence") +
    geom_line(size = 1) +
    theme_bw()
  return(gg)
}

g3_graph_amp_point <- function(g3obj){
  gg <- ggplot(g3obj$amplification) +
    aes(x = time/60, y = flr, colour = dna) +
    scale_color_manual(
      values = viridis::viridis(8),
      breaks = g3obj$sumtib$well,
    )+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Time (min)") + ylab("Fluorescence") +
    geom_point(size = 1) +
    theme_bw()
  return(gg)
}
