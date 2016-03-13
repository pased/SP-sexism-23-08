library(igraph)        # work with graphs in R
library(ggnetwork)     # devtools::install_github("briatte/ggnetwork")
library(intergraph)    # ggnetwork needs this to wield igraph things
library(ggrepel)       # fancy, non-ovelapping labels
library(svgPanZoom)    # zoom, zoom
library(SVGAnnotation) # to help svgPanZoom; it's a bioconductor package
library(DT)            # pretty tables

load("./data/feb23_wnet.rda")

gr <- graph_from_data_frame(feb23_wnet[,c("Toi", "Word")], directed=F)
E(gr)$weight <- 1

V(gr)$size <- feb23_wnet[,1]

gr <- simplify(gr,edge.attr.comb="sum")
set.seed(1492)

dat <- ggnetwork(gr, layout="fruchtermanreingold", arrow.gap=0, cell.jitter=0)
ggplot() +
  geom_edges(data=dat, 
             aes(x=x, y=y, xend=xend, yend=yend),
             color="grey50", curvature=0.1, size=0.15, alpha=1/2) +
  geom_nodes(data=dat,
             aes(x=x, y=y, xend=xend, yend=yend),
             alpha=1/3) +
  geom_label_repel(data=unique(dat),
                   aes(x=x, y=y, label=vertex.names), 
                   size=2, color="#8856a7") +
  theme_blank() +
  theme(legend.position="none") -> gg

ggplot(data=dat, aes(x=x, y=y, xend=xend, yend=yend, label=vertex.names,
                     fill=feb23_wnet$Date[1:147])) +
  geom_edges(data=dat, 
             aes(x=x, y=y, xend=xend, yend=yend),
             color="grey50", curvature=0.1, alpha=1/2) +
  geom_nodes(alpha=1/3) +
  geom_label_repel() +
  theme_blank(legend.position = "none")