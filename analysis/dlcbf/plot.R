
library(ggplot2)
library(grid)
source("../../theme_dcjstd.R")

xs <- read.table("benchmark.tsv", header = T, sep = "\t")

xs <- subset(xs, fpr <= 0.01)
xs <- subset(xs, mem <= 1.0)

# png("benchmark.png", width = 800, height = 600)
pdf("benchmark.pdf", width = 6, height = 4)

p <- qplot(data = xs, x = mem, y = fpr, geom = "line")
p <- p + ylim(c(0, max(xs$fpr)))
p <- p + scale_y_continuous(name = "Collision Rate")
p <- p + scale_x_continuous(name = "Memory\n(in proportion to sparsehash)")
p <- p + theme_dcjstd()
print(p)
dev.off()
