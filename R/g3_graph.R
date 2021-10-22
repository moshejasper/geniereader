#' Plot annealing graph
#'
#' @param g3obj g3 object
#'
#' @return returns ggplot graph of annealing curves
#' @export
#'
g3_graph_anneal <- function(g3obj){
  gg <- ggplot(g3obj$anneal) +
    aes(x = temp, y = flr, colour = well, text = sample) +
    geom_line(size = 1)+
    scale_color_manual(
      name = "target",
      values = RColorBrewer::brewer.pal(8, "Set2"),
      labels = g3obj$sumtib$well,
      breaks = paste0("x", 1:8),
    )+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Temperature (C)") + ylab("Derivative (F/C)") +
    theme_bw()
  return(gg)
}

#' Plot amplification graph
#'
#' @param g3obj g3 object
#'
#' @return returns graph of amplification curves
#' @export
#'
g3_graph_amp <- function(g3obj){
  gg <- ggplot(g3obj$amplification) +
    aes(x = time/60, y = flr, colour = well, text = sample) +
    scale_color_manual(
      name = "target",
      values = RColorBrewer::brewer.pal(8, "Set2"),
      labels = g3obj$sumtib$well,
      breaks = paste0("x", 1:8)
    )+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Time (min)") + ylab("Fluorescence") +
    geom_line(size = 1) +
    theme_bw()
  return(gg)
}

#' Plot amplification scatter
#'
#' @param g3obj g3 object
#'
#' @return returns scatter of amplification in a ploty-compatible form
#' @export
#'
g3_graph_amp_point <- function(g3obj){
  gg <- ggplot(g3obj$amplification) +
    aes(x = time/60, y = flr, colour = sample, text = well) +
    scale_color_manual(
      values = RColorBrewer::brewer.pal(8, "Set2"),
      breaks = g3obj$sumtib$well,
    )+
    ggtitle(g3obj$jobname, g3obj$jobindex) +
    xlab("Time (min)") + ylab("Fluorescence") +
    geom_point(size = 1) +
    theme_bw()
  return(gg)
}
