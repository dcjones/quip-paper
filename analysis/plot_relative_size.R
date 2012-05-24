
library(ggplot2)
library(colorspace)
source("../theme_dcjstd.R")
source("sample_labels.R")

xs <- read.table("quip_relative_size.csv", sep = ",", header = T)

xs <- subset(xs, as.character(samp) != "2")
xs$samp <- factor(xs$samp, levels = c("4", "5", "3", "1", "6", "7"))

xs$prog <- as.character(xs$prog)
xs$prog[xs$prog == "quip"]       <- "quip -a"
xs$prog[xs$prog == "quip-ref"] <- "quip -r"
xs$prog[xs$prog == "quip-quick"] <- "quip"
xs$prog[xs$prog == "uncompressed"] <- "Uncompressed"

xs$prog <- factor(xs$prog,
    levels = c(
        "quip -r",
        "quip -a",
        "quip",
        "Uncompressed"))

xs$grp <- as.character(xs$grp)
xs$grp[xs$grp == "id"] <- "ID"
xs$grp[xs$grp == "seq"] <- "Sequence"
xs$grp[xs$grp == "qual"] <- "Quality"

pdf("relative_sizes.pdf", width = 12, height = 2.5)

p <- qplot(
    data  = xs,
    x     = prog,
    y     = size,
    color = grp,
    fill  = grp,
    stat  = "identity",
    geom  = "bar")

p <- p + facet_grid(. ~ samp, labeller = sample_labeller)
p <- p + theme_dcjstd()

n <- length(levels(xs$prog))
cs_col <- rainbow_hcl(n = n, c = 60, l = 60, start = 30)
p <- p + scale_color_manual(values = cs_col, guide = "none")

cs_fil <- rainbow_hcl(n = n, c = 60, l = 70, start = 30)
p <- p + scale_fill_manual("Data", values = cs_fil)

p <- p + opts(axis.ticks = theme_blank(), axis.text.x = theme_blank())

p <- p + scale_x_discrete("Algorithm")
p <- p + scale_y_continuous("Relative Size")
p <- p + coord_flip()

print(p)

dev.off()