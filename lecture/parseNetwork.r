# Example of parsing an input MATSim network file

require(XML)

data <- xmlParse("matsim/examples/equil/network.xml")
data <- xmlToList(data)

# get all the nodes
nodes <- data$node

xs <- lapply(nodes, function(node) node["x"])
ys <- lapply(nodes, function(node) node["y"])

plot(xs, ys)


findNode <- function(id) {
  for (node in nodes) {
    if (node["id"] == id) {
      return(node)
    }
  }
  return(NA)
}

links <- data$link
for (link in links) {
  fromId <- link["from"]
  toId <- link["to"]
  
  # find the nodes with those ids
  if (!is.na(link["id"])) {
    fromNode <- findNode(fromId)
    toNode <- findNode(toId)
    
    # convert from strings to numbers
    x0 <- as.numeric(fromNode["x"])
    y0 <- as.numeric(fromNode["y"])
    x1 <- as.numeric(toNode["x"])
    y1 <- as.numeric(toNode["y"])
    
    arrows(x0, y0, x1, y1)
  }
}