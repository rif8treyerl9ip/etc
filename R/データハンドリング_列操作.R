# データハンドリング
# 列に関する操作
# mpgデータセット使用。

##### select
select(.data=mpg, model)
select(.data=mpg, model,year,cyl,displ)
# どっちでも行ける
select(.data=mpg, 1,2,3)
select(.data=mpg, c(1,2,3))
# classだけいらないとき
select(.data=mpg, -class)
# classとyearがいらん時
select(mpg, -c(class,year))


# In addition, you can use selection helpers. Some helpers select specific columns:
### everything(): Matches all variables.
### last_col()
# yearカラムを一番前に持ってくることができる。これだけだと微妙な機能。
select(mpg, year, everything())

mpg %>% select(everything())
# 最後の列をとってくる。
mpg %>% select(last_col())
# 1:最後の列からn番目までの列を選択。
mpg %>% select(1:last_col(0))
mpg %>% select(1:last_col(1))
mpg %>% select(1:last_col(2))



# These helpers select variables by matching patterns in their names:
### starts_with(): Starts with a prefix.
### ends_with(): Ends with a suffix.
### contains(): Contains a literal string.
### matches(): Matches a regular expression.
### num_range(): Matches a numerical range like x01, x02, x03.


### starts_with()
?select
select(mpg, starts_with("c"))
# 大文字小文字区別なし
select(iris, starts_with("p"))
# 大文字小文字区別あり
select(iris, starts_with("p", ignore.case=FALSE))

### ends_with()
select(mpg,ends_with("r"))

### contains()
select(mpg,contains("s"))

### matches()

# dthで終わる列名の列を選択。便利。
dim(select(iris, matches("dth$")))
select(iris, matches("dth$"))


### num_range()
df <- as.data.frame(matrix(1:30, nrow = 3, ncol = 10))
colnames(df) <- c(paste0("beer", 1:5), paste0("sake0", 1:5))
ls(df)


# matrix creates a matrix from the given set of values.
matrix(1:1000, nrow = 10, ncol = 100)
# The function data.frame() creates data frames, 
# デフォで列名が通し番号になる
tmp<-data.frame(matrix(1:500, nrow = 10, ncol = 50))

# X1~X7まで選択
select(tmp, num_range(prefix = "X", range = 1:7, width = 1))
# width	
# Optionally, the "width" of the numeric range. For example, a range of 2 gives "01", a range of three "001", etc
# 001,002といった列が簡単に選択できてすごい。分析のための機能が豊富だ…
select(tmp, num_range(prefix = "X", range = 1:20, width = 2))

# 正規表現を利用して一気に列を連番処理するコード
# Data frame attributes are preserved.
select(mpg, mから始まる列 = starts_with("m"), everything())
select(mpg, mから始まる列 = starts_with("z"), everything())
select(mpg, rを含むよ = contains("r"), everything())
select(mpg, rを含むよ = contains("r"))

