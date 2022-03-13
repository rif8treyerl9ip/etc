Sub Macro4()
    Dim i As Range, yyyymmdd As Variant
    Cells(Rows.Count, 3).Select  '1048576行目からctrl+↑
    Selection.End(xlUp).Select
    yyyymmdd = Range(ActiveCell, "C2").Select
    Debug.Print yyyymmdd
End Sub
Sub Macro7()
    Columns("C:C").Select
End Sub
Sub 複数日をスライサーで選択()
    ' 最新の3日分をスライサーで選択
    
    Dim raw As Worksheet, tmp As Worksheet
    Set tmp = Sheets.Add(After:=Sheets(Sheets.Count))
    tmp.Name = "tmp"
    Set raw = Worksheets("raw")
    
    Sheets("raw").Select
    Dim a As New Collection, i As Long
    On Error Resume Next
    For i = 2 To Cells(Rows.Count, 5).End(xlUp).Row ' C列の値をコレクションに入れていく
        a.Add Cells(i, 5), Key:=Str(Cells(i, 5))
    Next i


    
    On Error GoTo 0
    For i = 1 To a.Count
        tmp.Cells(i, 4) = a(i)
        Debug.Print a(i)
    Next i
    
    Sheets("tmp").Select
    Dim B As New Collection
    B.Add Item:=WorksheetFunction.Large(Range("d1:d100"), 1), Key:=Str(WorksheetFunction.Large(Range("d1:d100"), 1))
    B.Add Item:=WorksheetFunction.Large(Range("d1:d100"), 2), Key:=Str(WorksheetFunction.Large(Range("d1:d100"), 2))
    B.Add Item:=WorksheetFunction.Large(Range("d1:d100"), 3), Key:=Str(WorksheetFunction.Large(Range("d1:d100"), 3))
    
    Dim j As Integer
    For j = 1 To B.Count
        Debug.Print B(j)
        Debug.Print Right(B(j), 2)
    Next j
    

    
    Debug.Print "-----------------------------------"
    Sheets("pivot").Select
    With ActiveWorkbook.SlicerCaches("スライサー_d")
        For Each Sitm In .SlicerItems
                If Sitm.Name <> Right(B(1), 2) And Sitm.Name <> Right(B(2), 2) And Sitm.Name <> Right(B(3), 2) Then
                    Sitm.Selected = False
                Else
                    MsgBox "スライサーをオンにします"
                    Debug.Print Sitm.Name
                    Debug.Print Right(B(1), 2)
                    Debug.Print Sitm.Name = Right(B(1), 2)
    
                    Sitm.Selected = True

                End If
            Next
        End With

    Sheets("tmp").Select
    ActiveWindow.SelectedSheets.Delete
End Sub
