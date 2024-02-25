library(igraph)
library(rgl)
library(ggplot2)

# # Read in the data:
for (idex in c(1)){
filename <- paste0("20_80_5_insert_", idex)
nodesize = 20

nodes <- read.csv(paste0("../FLA/LON/data_", filename, "_nodes.csv"), header=T, as.is=T)
links <- read.csv(paste0("../FLA/LON/data_", filename, "_links.csv"), header=T)


# Examine the data:
head(nodes)
head(links)

  links <- as.matrix(links)
  # links is a matrix for a two-mode network:
  dim(links)
  dim(nodes)
  
  # Create an igraph network object from the two-mode matrix: 
  net <- graph_from_data_frame(d = links, vertices = nodes, directed=T) 

  net_vertex_colors <- matrix(0, dim(nodes)[1], 1)
  net_vertex_colors[nodes$group == 0] = 'Grey'
  group_amount <- unique(nodes$group)
  group_amount <- group_amount[which(group_amount != 0)]
  color_amount <- length(group_amount)
  library(RColorBrewer)
  colors <- colorRampPalette(brewer.pal(9, "YlOrRd"))(color_amount)
  colors <- rev(colors)
  group_rank <- group_amount
  for (i in 1:color_amount)
  {
    group_rank[i] <- min(nodes$fitness[nodes$group == group_amount[i]])
  }
  
  for (i in 1:color_amount)
  {
    net_vertex_colors[nodes$group == group_amount[i]] <- colors[rank(group_rank)[i]]
  }
  
  tenure_vertex_sizes = get.vertex.attribute(net,"radius")/nodesize
  edge_vertex_widths <- get.vertex.attribute(net, "width")
  
  ############################################################
  ## layout
  l_top <- layout_with_kk(net) 


  set.seed(123)
  opar<-par(no.readonly = TRUE)
  l_main <- matrix(c(l_top[,1], nodes$fitness), ncol=2)
  #  p1 
  setEPS()
  postscript(file=paste0(filename, "_main.eps"), width=6.94, height=6.94) # inches
  par(xaxs = "i", yaxs = "i",
      cex.lab = 3, cex.main = 3, cex.axis = 2,
      mgp = c(1,0.5,0), mex = 1.3)
  plot(net,
       layout = l_main,
       vertex.color=net_vertex_colors, 
       vertex.label=NA, 
       edge.arrow.size=0,
       vertex.size=tenure_vertex_sizes,
       ylab = "Objective value",
       main = "Front view")
  dev.off()

  #  p2
  setEPS()
  postscript(file=paste0(filename, "_top.eps"), width=6.94, height=6.94) # inches
  par(xaxs = "i", yaxs = "i",
      cex.lab = 3, cex.main = 3, cex.axis = 2,
      mgp = c(1,0.5,0), mex = 1.3)
  plot(net, 
       layout = l_top, 
       vertex.color=net_vertex_colors, 
       vertex.label=NA, 
       edge.arrow.size=0.03, edge.tweenness.weights=edge_vertex_widths,
       vertex.size=tenure_vertex_sizes,
       main = "Top view")
  dev.off()

  
  l_left <- matrix(c(l_top[,2], nodes$fitness), ncol=2)
  #  p3 
  setEPS()
  postscript(file=paste0(filename, "_left.eps"), width=6.94, height=6.94) # inches
  par(xaxs = "i", yaxs = "i",
      cex.lab = 3, cex.main = 3, cex.axis = 2,
      mgp = c(1,0.5,0), mex = 1.3)
  plot(net, layout = l_left,
       vertex.color=net_vertex_colors, 
       vertex.label=NA, 
       edge.arrow.size=0,
       vertex.size=tenure_vertex_sizes,
       ylab = "Objective value",
       main = "Side view")
  dev.off()

  setEPS()
  postscript(file=paste0(filename, "_label.eps"), width=2.5, height=6.94) # inches
  par(mar = c(4, 2, 3, 7), mex = 1,
      cex.lab = 3, cex.main = 3, cex.axis = 2)
  breaks <- seq(0,(color_amount-1),1)
  position <- c(1, floor(length(breaks)/2), (length(breaks)))
  breaks2 <- breaks[position]
  label_axis <- as.integer(sort(group_rank)[position])
  image(x=1/2, y=0:length(breaks),z=t(matrix(t(breaks)))*1.001,
        col=colors[breaks],axes=FALSE,breaks=breaks,
        xlab="", ylab="",xaxt="n")
  axis(side = 4, 
       at=position - 1, 
       labels= label_axis,
       col="white", col.ticks = "black",
       las=1)
  dev.off()

  
}