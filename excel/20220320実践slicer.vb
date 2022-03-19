
Sub slicer_update_use()
    Call slicer_update("pivotraw", 2, "y", "m")
End Sub
Function slicer_update(raw As String, col_number As Integer, slicer_name_y As String, slicer_name_m As String)
    ' スライサーの最新の3つの要素を選択
    ' raw スライサー選択のもとになるデータを取得できるシート
    ' col_number rawで取得する列番号。slicer_name
    ' slicer_name スライサー_d 等の _d の部分。col_numberと選択するスライサーを一致させないとエラーになります。

    Dim rawsheet As Worksheet, tmp As Worksheet
    Set tmp = sheets.Add(After:=sheets(sheets.Count))
    tmp.Name = "tmpsheet_sagyou"
    Set rawsheet = Worksheets(raw)
    rawsheet.Activate
    
    Dim i As Integer, j As Integer, k As Integer, m As Integer
    Dim tmpList As New Collection
    On Error Resume Next
    For i = 2 To Cells(Rows.Count, col_number).End(xlUp).Row
        tmpList.Add CStr(Cells(i, col_number)) & CStr(Cells(i, col_number + 1)) _
        , Key:=CStr(Cells(i, col_number)) & CStr(Cells(i, col_number + 1))
    Next i
    
    tmp.Activate
    For j = 1 To tmpList.Count
        Columns("A:Z").NumberFormatLocal = "@"
        tmp.Cells(j, 1) = tmpList(j)
    Next j

    Call sortsheet("tmpsheet_sagyou")

    Dim A As Variant, n As Integer
    n = 1
    For Each A In Range("A1:A3")
        tmp.Cells(n, 5) = Left(A, 4)
        tmp.Cells(n, 6) = Mid(A, 5, 2)
        n = n + 1
    Next

    Dim tmpList2 As Variant, tmpList3 As Variant
    Dim result As Integer, result2 As Integer
    tmpList2 = Range("E1:E3").Value
    tmpList3 = Range("F1:F3").Value
    
    sheets("pivot").Activate
    
    Dim whichslicer As String
    whichslicer = "スライサー_" & slicer_name_y
    With ActiveWorkbook.SlicerCaches(whichslicer)
        For Each sitm In .SlicerItems
            For o = 1 To UBound(tmpList2, 1)
                result = InStr(tmpList2(o, 1), sitm.Name)
                If result > 0 Then
                    Exit For
                End If
            Next o
        If result > 0 Then
                MsgBox sitm.Name & "のスライサーをオンにします"
                Debug.Print sitm.Name & "のスライサーをオンにします"
                sitm.Selected = True
            Else
                sitm.Selected = False
            End If
        Next
    End With
    
  
    whichslicer = "スライサー_" & slicer_name_m
    With ActiveWorkbook.SlicerCaches(whichslicer)
        For Each sitm In .SlicerItems
            For p = 1 To UBound(tmpList3, 1)
                'Debug.Print InStr(tmpList3(p, 1), sitm.Name)
                'Debug.Print sitm.Name, tmpList3(p, 1)
                result = InStr(tmpList3(p, 1), sitm.Name)
                If result > 0 Then
                    Exit For
                End If
            Next p
        If result > 0 Then
                MsgBox sitm.Name & "のスライサーをオンにします"
                Debug.Print sitm.Name & "のスライサーをオンにします"
                sitm.Selected = True
            Else
                sitm.Selected = False
            End If
        Next
    End With
    sheets("tmpsheet_sagyou").Select
    ActiveWindow.SelectedSheets.Delete

End Function


