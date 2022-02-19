
l <- c('1','2')

# 暗黙的に基本形はvectorであるとしてintegerと表示される
?typeof(l)

typeof(l)
is.vector(l) # TRUE
mode(l)
class(l)

l <- matrix(1:4)
typeof(l)
class(l)
mode(l)

df <- iris
attributes(df)
class(df)
df$Species
class(df$Species)

