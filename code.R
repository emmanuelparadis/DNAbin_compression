library(ape)

compressDNAbin <- function(x)
{
    if (!is.matrix(x)) {
        warning("'x' is not a matrix: it cannot be compressed with this method; returned unchanged")
        return(x)
    }
    s <- seg.sites(x, TRUE)
    z <- x[, s]
    attr(z, "pos") <- s
    attr(z, "ref") <- x[1, ]
    z
}

uncompressDNAbin <- function(x)
{
    pos <- attr(x, "pos")
    ref <- attr(x, "ref")
    n <- nrow(x)
    z <- matrix(rep.int(ref, n), n, ncol(ref), TRUE)
    z[cbind(rep(1:n, ncol(x)), rep(pos, each = n))] <- x[]
    rownames(z) <- rownames(x)
    class(z) <- "DNAbin"
    z
}

## test 1
data(woodmouse)
X <- compressDNAbin(woodmouse)
identical(woodmouse, uncompressDNAbin(X))
## running times < 1 ms, so call 1000 times:
system.time(for (i in 1:1000) dh <- dist.dna(X, "n")) # 3 times faster
system.time(for (i in 1:1000) dw <- dist.dna(woodmouse, "n"))
all(dh == dw)
object.size(X) / object.size(woodmouse) # 30%

## test 2
library(phangorn)
data(Laurasiatherian)
Laura <- as.DNAbin(Laurasiatherian)
L <- compressDNAbin(Laura)
identical(Laura, uncompressDNAbin(L))
system.time(dl <- dist.dna(L, "n")) # 1.5 times faster
system.time(da <- dist.dna(Laura, "n"))
all(dl == da)
object.size(L) / object.size(Laura) # 70%
