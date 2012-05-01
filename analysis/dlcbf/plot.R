
library(ggplot2)

xs <- read.table("benchmark.tsv", header = T, sep = "\t")

xs <- subset(xs, fpr <= 0.01)
xs <- subset(xs, mem <= 1.0)

png("benchmark.png", width = 800, height = 600)
# svg("benchmark.svg", width = 8, height = 6)
p <- qplot(data = xs, x = mem, y = fpr, geom = "line")
p <- p + ylim(c(0, max(xs$fpr)))
p <- p + scale_y_continuous(name = "False Positive Rate")
p <- p + scale_x_continuous(name = "Memory\n(in proportion to sparsehash)")
print(p)
dev.off()
