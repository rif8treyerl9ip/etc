' 実際に使用するときのスクリプト
Sub sagyou()

    Dim wbStr1 As String, wbStr2 As String, sheetStr1 As String, sheetStr2 As String
    wbStr1 = "sample2.xlsm"
    wbStr2 = "sample2.xlsm"
    sheetStr1 = "sheet2"
    sheetStr2 = "sheet2"
    Call copypaste(wbStr1, wbStr2, sheetStr1, sheetStr2, _
                            "A1:E6", "A9", True, False)
                            
    Dim sheets As Variant
    sheets = Array("pivotraw", "raw", "Sheet1", "sheet2")
    zoom_A1 (sheets)
End Sub

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