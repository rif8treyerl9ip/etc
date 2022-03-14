Sub ワークブック切り替え()
    ' アクティブなブックのなかである文字列にマッチしたブックに切り替えながら作業します。
    Dim i As Integer
    
    For i = 1 To Workbooks.Count
        If InStr(Workbooks(i).Name, "外部") Then
            Debug.Print Workbooks(i).Name
            Workbooks(i).Activate
        End If
    Next i
    
End Sub
