# 適当なベクトルを作る。
c(1,2,3)->x

# xのメンバにnames属性を付与。
names(x)=c('first','second','third')
# nameとベクトルの要素はセットになっている。
# 一見列名に見えますがもちろんデータフレームではない。
x

# xのメンバ数未満のnameを付与すると<NA>で補完される
names(x)=c('first','second')
x

# 一方でメンバ数より多いnameは付与できない。
names(x)=c('first','second','third','fourth')
x


?comment
comment(x)=c('first','second')
x

# Rではcomment属性も付与できるらしい。
# any R objectを引数にとる。

# 3×4の行列にコメント属性を設定する
x <- matrix(1:12, 3,4)
comment(x) <- c("This is my very important data from experiment #0234",
                "Jun 5, 1998")
x
comment(x)

# NULLを入れるとコメントは消去される
comment(x) <- NULL
x

# ②文字列にコメントを設定してみる
x <- "moziretu"
comment(x) <- c("This is my very important data from experiment #0234",
                "Jun 5, 1998")
x
comment(x)


# 属性の一覧を$dimと$commentで確認できることがわかる
# ①行列はdim属性を持つ
x <- matrix(1:12, 3,4)
attributes(x)

# ②commentを設定
comment(x) <- c("This is my very important data from experiment #0234",
                "Jun 5, 1998")
attributes(x)
# ③属性の設定をまとめてできる、属性は集合なので順序がない
attributes(x) <- list(comment = c("コメントは",'更新','されました'),
                      names = c('更新','された','?'))
attributes(x)
x


# Get or set specific attributes of an object.
# 属性の参照・設定両方できる

# 以下でさっき付けたコメントを参照できる
attr(x,'comment')

# <-value の形式で属性を設定できる
attr(x,'comment')<-'コメントを更新したよ'
attr(x,'comment')







x <- cbind(a = 1:3, pi = pi) # simple matrix with dimnames
attributes(x)

## strip an object's attributes:
attributes(x) <- NULL
x # now just a vector of length 6

mostattributes(x) <- list(mycomment = "really special", dim = 3:2,
                          dimnames = list(LETTERS[1:3], letters[1:5]), names = paste(1:6))
x # dim(), but not {dim}names
















type,class,mode
x <- matrix(1:12, 3,4)
# type は、データを保存できる変数のオブジェクトに対する型であり、ベクトル型、リスト型
typeof(x)
# オブジェクトに格納されている要素に対する型
mode(x)
# class は、オブジェクトの属性に対する型であり、行列型、因子型、データフレーム型など
class(x)
