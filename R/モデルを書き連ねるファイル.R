# モデルを試すファイル

x<-(1:4)
is.vector(1:4)
is.vector(x)
y<-(1:4)*10
# ベクトル（や行列，リストなど）からデータフレームを作成する
xy = data.frame(x=x,y=y)
history = lm(data=xy,formula=y~x)
summary(history)

library(broom)
tidy(history)

0.979/0.77
