
library(ggplot2)
library(colorspace)
source("../theme_dcjstd.R")
source("sample_labels.R")

xs <- read.table("decomp_time.csv", sep = ",", header = T)

xs <- subset(xs, samp != "2")
xs$samp <- factor(xs$samp, levels = c("4", "5", "3", "1", "6", "7"))

xs$prog <- as.character(xs$prog)
xs$prog[xs$prog == "quip"]       <- "quip -a"
xs$prog[xs$prog == "quip-ref"] <- "quip -r"
xs$prog[xs$prog == "quip-quick"] <- "quip"

xs$prog <- factor(xs$prog,
    levels = c(
        "gzip",
        "bzip2",
        "xz",
        "sra",
        "dsrc",
        "cramtools",
        "quip",
        "quip -a",
        "quip -r"))


# png("decomp_time.png", width = 900, height = 300)
pdf("decomp_time.pdf", width = 12, height = 2.5)

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

n <- length(levels(xs$prog))
cs_col <- rainbow_hcl(n = n, c = 60, l = 60)
p <- p + scale_color_manual(values = cs_col, guide = "none")

cs_fil <- rainbow_hcl(n = n, c = 60, l = 70)
p <- p + scale_fill_manual(values = cs_fil, guide = "none")

p <- p + scale_x_discrete("Algorithm")
p <- p + scale_y_continuous("Decompression Speed (MB/s)")
p <- p + coord_flip()


print(p)

dev.off()
