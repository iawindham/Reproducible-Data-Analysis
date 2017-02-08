p<-ggplot(diamonds, aes(carat, x, colour = clarity)) +
    geom_raster()

print(p)