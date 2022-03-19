Function sortsheet(sheetname As String)
    ' 指定シートをA列で降順ソート。長いので関数化した。
    Dim tmp As Worksheet
    Set tmp = Worksheets(sheetname)
 
    tmp.Sort.SortFields.Clear
    tmp.Sort.SortFields.Add2 Key:=Range("A1:A1000" _
        ), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:=xlSortNormal ' 数値データとテキスト データを別々に並べ替え
    With tmp.Sort
        .SetRange Range("A1:A1000")
        .Header = xlNo                       ' 先頭行をタイトル行と見なさない
        .MatchCase = False                 ' 大文字と小文字を区別しない
        .Orientation = xlTopToBottom  ' 行方向の並べ替え
        .SortMethod = xlPinYin            ' 日本語なら音読み順。あまり関係ない
        .Apply
    End With
    
End Function