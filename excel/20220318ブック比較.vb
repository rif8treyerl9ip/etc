Sub test()
    Dim Number As Integer
    Number = 1 ' 何行目に判定の結果を書き込むかを表す
    
    dim Sheet1 As string, raw As string, pivot As string
    Sheet1 = "Sheet1"
    raw = "raw"
    pivot = "pivot"

    ' あとはシートごとに対象範囲を全て指定してValueが一致することを確かめる
    ' Sheet1シート
    Call Comparison("外部データソースサンプル.xlsx", "外部データソースサンプル - コピー.xlsx", Sheet1, "A1:h4", Number)
    ' rawシート
    Call Comparison("外部データソースサンプル.xlsx", "外部データソースサンプル - コピー.xlsx", raw, "B2:K38", Number)
    ' pivotシート
    Call Comparison("外部データソースサンプル.xlsx", "外部データソースサンプル - コピー.xlsx", pivot, "A3:b40", Number)

End Sub

