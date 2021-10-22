
g3load <- function(num){
  g3_read(paste0("C:/Users/mossu/Dropbox/RLEM Project/Results/reports/GEN3-1289_0", num))
}

g3loadamp <- function(num){
  g3_read_amp(paste0("C:/Users/mossu/Dropbox/RLEM Project/Results/reports/GEN3-1289_0", num))
}

g3loadsum <- function(num){
  g3_read_summary(paste0("C:/Users/mossu/Dropbox/RLEM Project/Results/reports/GEN3-1289_0", num))
}


#begin process from 264

#g3loadamp(264) %>% g3_graph_amp_point

#### New 10K discrimination tests

#g3loadamp(265) %>% g3_graph_amp_point # 1*Tx
#g3loadamp(266) %>% g3_graph_amp_point # 1*Gx
#g3loadamp(267) %>% g3_graph_amp_point # 1*Cy

#### Concentration curves (10k - 4)

#g3loadamp(268) %>% g3_graph_amp # 1*Tx
#g3loadamp(269) %>% g3_graph_amp_point # 1*Gx
#g3loadamp(270) %>% g3_graph_amp_point # 1*Cy


#### Concentraction curves (opposed: 10k-30)

#g3loadamp(271) %>% g3_graph_amp # 1*Tx vs G
#g3loadamp(272) %>% g3_graph_amp_point # 1*Tx vs C

#g3loadamp(273) %>% g3_graph_amp_point # 1*Gx vs T
#g3loadamp(274) %>% g3_graph_amp_point # 1*Gx vs C

#g3loadamp(275) %>% g3_graph_amp_point # 1*Cy vs T
#g3loadamp(276) %>% g3_graph_amp_point # 1*Cy vs G

#### Field test with HAll samples (1/10 concentration. Data to be added later) (1/100 next time)

#g3loadamp(279) %>% g3_graph_amp_point # 1*Tx primer!









