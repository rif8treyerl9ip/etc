# ベルヌーイ分布
xx<-seq(0,1,1)
prob<-dbinom(xx,1,0.8) # 事象生起確率は0.8
plot(xx,prob,type='h',lwd=3)

# 二項分布描画
xx<-seq(1:100)
prob<-dbinom(xx,100,0.5)
plot(xx,prob,ylim=c(0,0.1))
lines(xx,dbinom(xx,100,0.1))
lines(xx,dbinom(xx,100,0.2))
lines(xx,dbinom(xx,100,0.3))
lines(xx,dbinom(xx,100,0.4))
lines(xx,dbinom(xx,100,0.6))
lines(xx,dbinom(xx,100,0.7))
lines(xx,dbinom(xx,100,0.8))
lines(xx,dbinom(xx,100,0.9))

dbinom(1,1,0.5)
dbinom(0,1,0.5)





# dnorm gives the density
dnorm(x, mean = 0, sd = 1, log = FALSE)
dnorm(1.96,mean = 0, sd = 1)
dnorm(1.64,mean = 0, sd = 1)

# rnorm generates random deviates.
rnorm(10, mean = 0, sd = 1)
x<-rnorm(100000, mean = 0, sd = 1)
mean(x)
sd(x)

x2<-rnorm(100, mean = 0, sd = 1)
mean(x2)
sd(x2)

dnorm(0) == 1/sqrt(2*pi)
dnorm(1) == exp(-1/2)/sqrt(2*pi)
dnorm(1) == 1/sqrt(2*pi*exp(1))

## Using "log = TRUE" for an extended range :
par(mfrow = c(2,1))
plot(function(x) dnorm(x, log = TRUE), -60, 50,
     main = "log { Normal density }")
?function(x)
curve(log(dnorm(x)), add = TRUE, col = "red", lwd = 2)
mtext("dnorm(x, log=TRUE)", adj = 0)
mtext("log(dnorm(x))", col = "red", adj = 1)


# The Uniform Distribution
# d 確率密度を返す
# q 確率点を返す
# r 確率変数を返す
# p 累積分布関数(確率)を返す

qunif(0.7, min = 0, max = 20, log = FALSE)
punif(1, min = 0, max = 10, lower.tail = TRUE, log.p = FALSE)
punif(40, min = 0, max = 50, lower.tail = TRUE, log.p = FALSE)
dunif(15, min = 0, max = 30, log = FALSE)
runif(n = 10,min=0,max=1)


















# 個々の統計に関係ないメソッドを試すファイル
# str_detect
?str_detect
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a")
str_detect(fruit, "^a")
str_detect(fruit, "a$")
str_detect(fruit, "b")
str_detect(fruit, "[aeiou]")

# Also vectorised over pattern
str_detect("aecfg", letters)

# Returns TRUE if the pattern do NOT match
# negate	If TRUE, return non-matching elements.
str_detect(fruit, "^p", negate = TRUE)


?arrange
arrange(mtcars, cyl, disp)

rep(1:4)
# times
# an integer-valued vector giving the (non-negative) number of times to repeat each element if of length length(x), or to repeat the whole vector if of length 1. Negative or NA values are an error. A double vector is accepted, other inputs being coerced to an integer or double vector.
rep(1:4, times=2)
rep(1:4, times=c(2,2,2,2))
rep(1:4, times=c(2,1,2,1))

# each
# non-negative integer. Each element of x is repeated each times. Other inputs will be coerced to an integer or double vector and the first element taken. Treated as 1 if NA or invalid.
# Other inputは整数に強制される
rep(1:4, each=2)
rep(1:4, each=2.9) # 1個上と同じ
rep(1:4, each=3)
rep(1:4, each=3.7) # 1個上と同じ
# Other inputs will be coerced to an integer or double vector and the first element taken. 
# eachに無効なベクトルを入力したので一番前のelementが引数にとられてeach=5で実行される
rep(1:4, each=c(5,2,2,3))

?map
# Compute normal distributions from an atomic vector
1:10 %>%
  map(rnorm, n = 5)

# You can also use an anonymous function
1:10 %>%
  map(function(x) rnorm(10, x))

# Simplify output to a vector instead of a list by computing the mean of the distributions
1:10 %>%
  map(rnorm, n = 10) %>%  # output a list
  map_dbl(mean)           # output an atomic vector

# Using set_names() with character vectors is handy to keep track
# of the original inputs:
set_names(c("foo", "bar")) %>% map_chr(paste0, ":suffix")

# 他例
x<-1:10
f <- function(arg){arg**2}
#map(x, f)と書ける。
map(.x = x, .f = f)

# 
?replicate

# NROW,NCOL
NROW(mpg)
NCOL(mpg)


# Rの操作
# パッケージアップデート
tidyverse_update()

base::mean
dput(mtcars)
fil <- tempfile()
dput(base::mean, fil)

# コマンドライン操作
# カレントディレクトリ
getwd()
# ディレクトリ移動
setwd("C:/Users/thyt/Books/kubobook_2012")