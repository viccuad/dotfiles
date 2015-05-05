
library(foreign)
detach("package:datasets")
x <- rnorm(1)
if(x > 0)
    cat("Yes\n")
else
    cat("No\n")
x <- numeric(123)
x <- NULL
