
library(ggplot2)
library(colorspace)
source("../theme_dcjstd.R")
source("sample_labels.R")

xs <- read.table("comp_time.csv", sep = ",", header = T)

xs$prog <- factor(xs$prog,
    levels = c(
        "gzip",
        "bzip2",
        "xz",
        "sra",
        "dsrc",
        "cramtools",
        "quip-quick",
        "quip"))


# png("comp_time.png", width = 900, height = 300)
pdf("comp_time.pdf", width = 12, height = 3)

p <- qplot(
    data  = xs,
    x     = prog,
    y     = time,
    color = prog,
    fill  = prog,
    stat  = "identity",
    geom  = "bar")

p <- p + facet_grid(. ~ samp, labeller = sample_labeller)
p <- p + theme_dcjstd()

cs <- rainbow_hcl(n = 6, c = 60, l = 50)
p <- p + scale_color_manual(values = cs, guide = "none")

cs <- rainbow_hcl(n = 6, c = 60, l = 70)
p <- p + scale_fill_manual(values = cs, guide = "none")

p <- p + scale_x_discrete("Algorithm")
p <- p + scale_y_continuous("Compression Speed (MB/s)")

p <- p + opts(axis.text.x=theme_text(angle=45))

print(p)

dev.off()
