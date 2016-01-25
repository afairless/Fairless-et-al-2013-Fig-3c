# Andrew Fairless, August 2011
# modified May 2015 for posting onto Github
# This script constructs the bar graph for Figure 3c of Fairless et al 2013
# Fairless et al 2013, doi: 10.1016/j.bbr.2012.08.051, PMID: 22982070, PMCID: PMC3554266

install.packages("gplots", dependencies = TRUE)   # install package if not already installed

library(gplots)
source("barplot2af2.txt")                         # contains modified barplot2 function

bargraphtable = read.table("bargraphtable.txt", header = TRUE, sep = "\t")      # table of parameters for bar graph
bars = t((bargraphtable[ ,5:9] / 61) * 100)       # heights of the bars (group means)
barcolors = t(bargraphtable[ ,15:19])
btwnbarspace = bargraphtable$btwnspace            # specifies amount of open space to the left of each bar
plottop = 40
tkmks = seq(0, plottop, by = 5)                   # tickmarks for left-hand y-axis
tkmks2 = seq(0, 20, by = 5)                       # tickmarks for right-hand y-axis
xlabels = rep(c("female", "female", "   male", "   male"), 3)                   # x-axis labels
barmidpoints = c(2.1, 3.1, 4.9, 5.9, 8.5, 9.5, 11.3, 12.3, 14.9, 15.9, 17.7, 18.7)   # horizontal positions of bars
leg1 = c(barcolors[5, 1], barcolors[4, 1], barcolors[3, 1], barcolors[2, 1], barcolors[1, 1], 
         barcolors[5, 2], barcolors[4, 2], barcolors[3, 2], barcolors[2, 2], barcolors[1, 2])  # legend colors
leg2 = c("C57BL/6J active (anogenital)", "C57BL/6J active (body)", 
         "C57BL/6J passive (pawing)", "C57BL/6J passive (moving)", 
         "C57BL/6J passive (not moving)", "BALB/cJ active (anogenital)", 
         "BALB/cJ active (body)", "BALB/cJ passive (pawing)", 
         "BALB/cJ passive (moving)", "BALB/cJ passive (not moving)")            # legend labels
lwd = 2                       # line width
sexverticaloffset = 1         # vertical position of "male" and "female" x-axis labels
ageverticaloffset = 2.5       # vertical position of age x-axis labels
xlabelcex = 1.3               # x-axis labels size

png(file = "passive not moving, subparts, pct of 61 time bins.png", width = 640, height = 512)	
par(mar = c(5.1, 4.1, 4.1, 4.1))
barplot2af2(bars, plot.ci = FALSE, col = barcolors, space = btwnbarspace, 
            ylab = "Portion (%) of all scored time points", names.arg = NULL, 
            cex.names = 1.5, las = 2, yaxt = "n", cex.lab = 1.5, ylim = c(0, plottop))
abline(h = 0, lwd = lwd)
axis(1, at = c(7.2, 13.6), las = 2, lwd = lwd, labels = c("",""), tck = -0.1)
axis(2, at = tkmks, las = 2, lwd = lwd, cex.axis = 1.5)
axis(4, at = tkmks2/0.61, las = 2, lwd = lwd, cex.axis = 1.6, labels = tkmks2)
par(xpd = T) 
text(21.7, 20, "Number of time points", cex = 1.5, srt = 270)
par(xpd = F)
par(font = 2)
#legend(12.7, 22, leg2, fill = leg1, cex = 1.0, bty = "n")
legend(4.5, plottop, leg2[1:5], fill = leg1[1:5], cex = 1.0, bty = "n")
legend(12.2, plottop, leg2[6:10], fill = leg1[6:10], cex = 1.0, bty = "n")
par(font = 1)
text(4.0, labels = "30 days", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = ageverticaloffset, font = 2)
text(10.4, labels = "41 days", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = ageverticaloffset, font = 2)
text(16.8, labels = "69 days", par("usr")[3], pos = 1, xpd = T, cex = xlabelcex, 
     offset = ageverticaloffset, font = 2)
text(c(2.6, 9.0, 15.4), labels = "female", par("usr")[3], pos = 1, xpd = T, 
     cex = xlabelcex, offset = sexverticaloffset, font = 2)
text(c(5.4, 11.8, 18.2), labels = "male", par("usr")[3], pos = 1, xpd = T, 
     cex = xlabelcex, offset = sexverticaloffset, font = 2)
dev.off()	
