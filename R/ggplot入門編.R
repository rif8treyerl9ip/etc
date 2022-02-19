# ggplot2 

Country_df<-read.table("clipboard")

Country_df <- dplyr::rename(Country_df
, Country = V1, PPP = V2,HDI = V3, OECD = V4)

Country_df<-Country_df[-1,]


# V1    V2    V3       V4
# 1      Country   PPP   HDI     OECD
# 2  Afghanistan  2125 0.496 非加盟国
# 3      Albania 13781 0.791 非加盟国
# 4      Algeria 11324 0.759 非加盟国
# 5       Angola  6649 0.574 非加盟国
# 6    Argentina 22938 0.830 非加盟国
# 7      Armenia 12974 0.760 非加盟国
# 8    Australia 50001 0.938   加盟国
# 9      Austria 55824 0.914   加盟国
# 10  Azerbaijan 14257 0.754 非加盟国
# 11     Bahrain 43624 0.838 非加盟国

# このデータは各国 (Country) の一人当たり購買力平価基準GDP (PPP)
# 、人間開発指数 (HDI)、OECD加盟有無 (OECD)の変数で構成
# されています。このデータを使って横軸はPPP、縦軸はHDIとし、OECDの値によって色分けしたグラフを作成します。

# Base Rを用いた作図の例
# ifelseで色指定できるのか
plot(x = Country_df$PPP, y = Country_df$HDI, pch = 19, 
col = ifelse(Country_df$OECD == "加盟国", "red", "blue"),
xlab = "一人当たり購買力平価GDP (USD)", ylab = "人間開発指数")

legend("bottomright", pch = 19,
       legend = c("OECD加盟国", "OECD非加盟国"), 
       col    = c("red", "blue"))

library(ggplot2)
# ggplot2を用いた作図の例
ggplot(data = Country_df) +
  geom_point(aes(x = PPP, y = HDI, color = OECD)) +
  labs(x = "一人あたり購買力平価GDP (USD)", y = "人間開発指数",
       color = "OECD加盟有無") +
  theme_bw(base_family = "HiraKakuProN-W3")






Year	Company_Type1	P
2011	その他	4769
2011	JR	7399
2011	大手私鉄	19421
2011	準大手私鉄	7683
2012	その他	5014
2012	JR	7289
2012	大手私鉄	21286
2012	準大手私鉄	10471
2013	その他	5154
2013	JR	7383
2013	大手私鉄	21097
2013	準大手私鉄	10652
2014	その他	5517
2014	JR	7469
2014	大手私鉄	21013
2014	準大手私鉄	10569
2015	その他	5662
2015	JR	7495
2015	大手私鉄	21809
2015	準大手私鉄	10740
2016	その他	5807
2016	JR	7622
2016	大手私鉄	22474
2016	準大手私鉄	10767
2017	その他	5943
2017	JR	7707
2017	大手私鉄	22783
2017	準大手私鉄	10862

rail<-read.table("clipboard")

rail <- dplyr::rename(rail
, Year = V1, Company_Type1 = V2,P = V3,)

rail<-rail[-1,]

rail$Year<-as.integer(rail$Year)
rail$P<-as.integer(rail$P)
str(rail)

# 第2層: X軸はYear、Y軸はPにし、Company_type1ごとに色分けした折れ線グラフを作成し、線の太さは1とする。
ggplot(data = rail)+
  geom_line(aes(x = Year, y = P, color = Company_Type1), 
            size = 1)


# 第3層: X軸はYear、Y軸はPにし、Company_type1ごとに色分けした散布図を作成する。
#        点の大きさは3、点のタイプは21 (外線付き)、点の中身の色は白よする
ggplot(data = rail) +
  geom_line(aes(x = Year, y = P, color = Company_Type1), 
            size = 1) +
  geom_point(aes(x = Year, y = P, color = Company_Type1), 
             size = 3, shape = 21, fill = "white")

# 第4層: X軸、Y軸のラベルをそれぞれ「年度」、「平均利用者数 (人/日)」に
#        凡例のcolorのラベルは「事業者区分」にする
ggplot(data = rail) +
  geom_line(aes(x = Year, y = P, color = Company_Type1), 
            size = 1) +
  geom_point(aes(x = Year, y = P, color = Company_Type1), 
             size = 3, shape = 21, fill = "white") +
  labs(x = "年度", y = "平均利用者数 (人/日)", color = "事業者区分")


# 第5層: 連続変数で構成されたX軸を調整する
#        目盛りは2011, 2012, ..., 2017とし、ラベルも2011, 2012, ..., 2017に
ggplot(data = rail) +
  geom_line(aes(x = Year, y = P, color = Company_Type1), 
            size = 1) +
  geom_point(aes(x = Year, y = P, color = Company_Type1), 
             size = 3, shape = 21, fill = "white") +
  labs(x = "年度", y = "平均利用者数 (人/日)", color = "事業者区分") +
  scale_x_continuous(breaks = 2011:2017, labels = 2011:2017)




日本語が表示されないため、日本語に対応したフォントを指定します。グラフのテーマもggplot2が基本的に提供しているminimalに変更し、フォントはヒラギノ角ゴジックW3にします。
# 第6層: テーマをminimalに指定し、フォント群はHiraKakuProN-W3に
ggplot(data = rail) +
  geom_line(aes(x = Year, y = P, color = Company_Type1), 
            size = 1) +
  geom_point(aes(x = Year, y = P, color = Company_Type1), 
             size = 3, shape = 21, fill = "white") +
  labs(x = "年度", y = "平均利用者数 (人/日)", color = "事業者区分") +
  scale_x_continuous(breaks = 2011:2017, labels = 2011:2017) +
  theme_minimal(base_family = "HiraKakuProN-W3")


# 色分けしたいときはaesオブジェクトの内側にcol引数を入れる
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy,col=cyl))


# 座標系
coord_*()関数群

座標系のズームイン (zoom-in) やズームアウト (zoom-out) を行うcoord_cartesian()、

coord_flip


### coord_flip
# expandの挙動
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy,col=cyl))+
  coord_flip(expand=FALSE)

ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy,col=cyl))+
  coord_flip(expand=TRUE)

### coord_trans()
# coord_trans() is different to scale transformations in that it occurs after statistical transformation and will affect the visual appearance of geoms - there is no guarantee that straight lines will continue to be straight.
# データそのものを変えるわけではないので正確なスケールを保証できない？
str(austres)
> class(austres) # 時系列データオブジェクト形式のデータだった
[1] "ts"

start(austres)
end(austres)
frequency(austres)

install.packages("ggpmisc")
library("ggpmisc")


ggplot(data=austres) +
  geom_point(mapping=aes(x=displ,y=hwy,col=cyl))+
  coord_flip(expand=TRUE)

aust.data <- try_data_frame(austres, as.numeric = TRUE,
                 time.resolution = "year")

ggplot(austres,) +
  geom_line(mapping = aes(time, austres))



### coord_trans()
# coord_trans() is different to scale transformations in that it occurs after statistical transformation and will affect the visual appearance of geoms - there is no guarantee that straight lines will continue to be straight.
# データそのものを変えるわけではないので正確なスケールを保証できない？
str(austres)
> class(austres) # 時系列データオブジェクト形式のデータだった
[1] "ts"

start(austres)
end(austres)
frequency(austres)

install.packages("ggpmisc")
library("ggpmisc")


ggplot(data=austres) +
  geom_point(mapping=aes(x=displ,y=hwy,col=cyl))+
  coord_flip(expand=TRUE)

aust.data <- try_data_frame(austres, as.numeric = TRUE,
                            time.resolution = "year")

ggplot(austres,) +
  geom_line(mapping = aes(time, austres))




# 時系列データのプロット方法
# tsデータを読み込む(austresとか)
# ggpmiscのtry_data_frameを使用して時系列情報を列に落とし込む
# 後はggplotなり好きな関数で処理するだけ

start(austres)
end(austres)
frequency(austres)

install.packages("ggpmisc")
library("ggpmisc")

ggplot(data=austres) +
  geom_point(mapping=aes(x=displ,y=hwy,col=cyl))+
  coord_flip(expand=TRUE)

aust.data <- try_data_frame(austres, as.numeric = TRUE,
                            time.resolution = "year")
str(austres)
str(aust.data)

ggplot(austres,) +
  geom_line(mapping = aes(time, austres))

ggplot(austres,) +
  geom_line(mapping = aes(time, austres)) +
  coord_trans(x = "log10", y = "log10")

ggplot(aust.data,aes(time, austres)) +
  geom_line() +
  scale_x_log10() +
  scale_y_log10()

  # coord_trans(x = "log10", y = "log10")

iris

ggplot(iris, aes(Petal.Width, Sepal.Length)) +
  geom_point()

ggplot(iris, aes(Petal.Width, Sepal.Length)) +
  geom_point() +
  scale_y_log10()

ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  scale_y_log10()

ggplot(diamonds, aes(carat, price)) +
  geom_point()

## 座標系：スケール

### scale_y_continuous()の例
# 例
# このデータセットは30-39歳のアメリカ人の女性の平均の身長と体重を与えます。\
women %>%
  ggplot(aes(weight,height)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = c(120,140,160), # x軸は大雑把に20ポンドずつ
                     labels=c(120,140,160)) +
  scale_y_continuous(breaks = c(60,62,64,66,66.93,68), # y軸は日本目安に170cmのラベルだけ変更
                     labels=c(60,62,64,66,"66.93(170cm)",68))
# 器用にインチ→センチに変換して170cmになるところだけラベルを変えたりもできる。

# scale_color_manual()
# 手動で調整したけどこんな感じで色設定できる。
diamonds %>%
  ggplot() +
  geom_point(aes(x = carat, y = price, color = color)) +
  scale_color_manual(values = 
     c("D" = "#ff0000","E" = "#ff9000","F" = "#fff000",
       "G" = "#7fff00", "H" = "#33fee6", "I" = "#0011ff", "J" = "#4400ff"))





