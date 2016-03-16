# Load ggplot and plyr packages
library("ggplot2", lib.loc="~/R/win-library/3.2")
library("plyr", lib.loc="~/R/win-library/3.2")

# Load the location data
locations <- read.csv("C:/Users/Noel/Google Drive/Masters/DataVis/Project_2/locations.csv")

counts <- count(locations)

# Generate map background
world <- map_data("world")
p <- ggplot()
p <- p + geom_polygon(data = world, aes(x=long, y=lat, group = group), color = "steelblue4", fill = "royalblue4") + 
theme(panel.background = element_rect(color = "midnightblue", fill = "midnightblue")) + 
theme(line = element_blank(), axis.title = element_blank(), axis.ticks = element_blank(), axis.text = element_blank())

p <- p + coord_cartesian(xlim = c(-150, 50), ylim = c(-40, 80))

# Put in the joining lines
for(i in 1:nrow(counts)){
	p <- p + geom_line(data = counts[c(16,i),], 
	aes(x=Longitude, y=Latitude, scale = 0.2, alpha = 0.5), 
	color = "lightgoldenrod2")} + 
	theme(legend.position = "none")

# Add points
p <- p + geom_point(data = counts, aes(x=Longitude, y=Latitude, size = freq), color = "red2")

# Title
p <- p + annotate("text", label="Incoming Mails", x = -100, y = -30, color = "white", size = 8)

# Save and display
ggsave("map.png")
p