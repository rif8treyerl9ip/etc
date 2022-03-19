' 最終行を選択
Worksheets("Sheet1").Cells(Rows.Count, 1).End(xlUp).Select

' 2つのブックを宣言
Public wb As Workbook
Public wb2 As Workbook

' 2つのブックを使用してセル範囲のコピペ
Set wb = ThisWorkbook
Set wb2 = Workbooks("外部データソースサンプル.xlsx")

With wb2.Worksheets("Sheet1")
    .Range(.Cells(1, 1), .Cells(9, 4)).Copy
End With

wb.Worksheets("Sheet1").Range("B2").Activate
ActiveSheet.Paste



' -------------------- Function -------------------- '


Function zoom_A1(sheets As Variant)
    For i = LBound(sheets) To UBound(sheets)
        Worksheets(sheets(i)).Activate
        ActiveWindow.Zoom = 100
        Range("A1").Select
    Next i
    Worksheets(1).Activate
End Function



Function copypaste( _
    wbStr1 As String, wbStr2 As String, _
    sheetStr1 As String, sheetStr2 As String, _
    copyrange As Variant, _
    pastecell As String, _
    is_value As Boolean, _
    is_format)
    ' 2つのブックを使用してセル範囲のコピペを行う
    ' wbStr1/wbStr2 コピー元/先のブック名
    ' sheetStr1/sheetStr2 コピー元/先のシート名
    ' copyrange コピー範囲、構文上Variant型で宣言
    ' pastecell paste先のセルを文字列で指定 ex."A2"
    ' is_value Trueなら値貼り付け
    ' is_format Trueなら書式貼り付け

    arr = Split(copyrange, ":")
    
    With Workbooks(wbStr1).Worksheets(sheetStr1)
        .Range(arr(0) & ":" & arr(1)).Copy
    End With
    
    Workbooks(wbStr2).Worksheets(sheetStr2).Range(pastecell).Select

    ' 値と書式両方張り付ける場合に対応して評価を2回行っている
    If is_value Then
        Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
            :=False, Transpose:=False
    End If
    If is_format Then
        Selection.PasteSpecial Paste:=xlPasteFormats, Operation:=xlNone, _
            SkipBlanks:=False, Transpose:=False
    End If
    Application.CutCopyMode = False
End Function


