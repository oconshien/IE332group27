args <- commandArgs(TRUE)

rinternal_n <- args[1]
rinternal_mu <- (if(!is.na(args[2])) args[2] else 0)
rinternal_stdev <- (if(!is.na(args[3])) args[3] else 1)
rinternal_normal <- rnorm(rinternal_n, rinternal_mu, rinternal_stdev)


print(rinternal_n, rinternal_mu, rinternal_normal)
getwd()

png(filename="testRhistpng.png", width=500, height=500)
hist(rinternal_normal, col="lightblue", main=Sys.time())
dev.off()

pdf("testRhistpdf.pdf")
hist(rinternal_normal, col=259, main=Sys.time())
dev.off()

sink("testRhistsink.txt")
print(rinternal_normal)
sink()