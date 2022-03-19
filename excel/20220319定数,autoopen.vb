' モジュール1
Option Explicit

Private Const MOTO_BOOK As String = "外部データソースサンプル.xlsx"
Private Const SAKI_BOOK As String = "外部データソースサンプル - コピー.xlsx"
Public Const CHECK_BOOK As String = "ブックチェック2.xlsm"
Private Const Sheet1 As String = "Sheet1"
Private Const raw As String = "raw"
Private Const pivot As String = "pivot"

Sub auto_open()
    Workbooks(CHECK_BOOK).Sheets(1).Cells(1, 1) = "手作業"
    Workbooks(CHECK_BOOK).Sheets(1).Cells(1, 2) = "マクロあり"
    Workbooks(CHECK_BOOK).Sheets(1).Cells(1, 3) = "シート名"
    Workbooks(CHECK_BOOK).Sheets(1).Cells(1, 4) = "比較範囲"
    Workbooks(CHECK_BOOK).Sheets(1).Cells(1, 5) = "k(0で正常)"
End Sub

Sub test()
    Dim Number As Integer
    Number = 1 ' 何行目に判定の結果を書き込むかを表す
    
    ' シートごとに対象範囲を全て指定してValueが一致することを確かめる
    ' Sheet1シート
    Call Comparison(MOTO_BOOK, SAKI_BOOK, Sheet1, "A1:h4", Number)
    ' rawシート
    Call Comparison(MOTO_BOOK, SAKI_BOOK, raw, "B2:K38", Number)
    ' pivotシート
    Call Comparison(MOTO_BOOK, SAKI_BOOK, pivot, "A3:b40", Number)

End Sub

' モジュール2
Function Comparison(MotoBook As String, SakiBook As String, SheetName As String, hani As String, Number As Integer)
    Debug.Print SheetName & "の" & hani & "について処理を開始します。"
    '配列格納
    Dim Moto As Variant, Saki As Variant
    With Workbooks(MotoBook).Sheets(SheetName)
        Moto = .Range(hani).value
    End With
    With Workbooks(SakiBook).Sheets(SheetName)
        Saki = .Range(hani).value
    End With
    
    Dim i As Integer, j As Integer, k As Integer
    k = 0
    For i = LBound(Moto, 1) To UBound(Moto, 1)
        For j = LBound(Moto, 2) To UBound(Moto, 2)
'             Debug.Print Moto(i, j), Saki(i, j) ' デバッグするならコメント解除
            If Moto(i, j) <> Saki(i, j) Then
                Debug.Print Moto(i, j), Saki(i, j)
                Debug.Print "ERROR"
                k = k + 1
                GoTo last
            End If
        Next
    Next
   
last:
    Debug.Print Str(k) ' (": 終了ステータス0で完全一致です")
    If k > 0 Then
        Debug.Print ("FAIL!")
    Else
        Debug.Print ("SUCCESS!")
    End If
    
    Workbooks(CHECK_BOOK).Sheets(1).Cells(Number + 1, 1) = MotoBook
    Workbooks(CHECK_BOOK).Sheets(1).Cells(Number + 1, 2) = SakiBook
    Workbooks(CHECK_BOOK).Sheets(1).Cells(Number + 1, 3) = SheetName
    Workbooks(CHECK_BOOK).Sheets(1).Cells(Number + 1, 4) = hani
    Workbooks(CHECK_BOOK).Sheets(1).Cells(Number + 1, 5) = k

    Number = Number + 1
End Function