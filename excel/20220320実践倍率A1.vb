Sub zoom_A1sagyou()
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
