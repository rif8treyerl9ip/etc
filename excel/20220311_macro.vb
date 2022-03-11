Sub RawDataCopy()
    ' SourceFileをCloseしないとSourceFileの行数がなぜか急増する。読み取り専用だから問題はないが…
    
    Dim PasteFile As String
    ToPasteFile = ActiveWorkbook.Name
    
    ' 開きたいエクセルファイルをパスを取得して開く
    Dim path1 As String, Source As String, excel_path As String
    path1 = "C:\Users\thyt\SELF_S\excel\"
    SourceFile = Dir("C:\Users\thyt\SELF_S\excel\*外部*")
    excel_path = path + SourceFile
    Dim wb As Workbook
    Set wb = Workbooks.Open(Filename:=excel_path, UpdateLinks:=3, ReadOnly:=True)
    Windows(SourceFile).Activate
    
      ' 特定範囲のデータをコピー
    Range("A2").Select
    Range(Selection, Selection.End(xlToRight)).Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.Copy
    
    ' 貼り付け先のブックに貼り付け
    Windows(ToPasteFile).Activate
    Cells(Rows.Count, 1).Select  '1048576行目からctrl+↑
    Selection.End(xlUp).Select
    ' Debug.Print ActiveCell.Value ' debugのため
    ActiveCell.Offset(1, 0).Select
    ActiveSheet.Paste
    
    Windows(SourceFile).Activate
    Range("A1:A1").Select
    Selection.Copy
    wb.Close SaveChanges:=False
End Sub

Sub DeleteWithoutColumns()
    Cells(Rows.Count, Columns.Count).Select
    Range(ActiveCell, "A2").Select
    Selection.ClearContents
End Sub

Sub test()
    Cells(Rows.Count, Columns.Count).Select
    Range(ActiveCell, "A2").Select
    Selection.ClearContents
    

End Sub

