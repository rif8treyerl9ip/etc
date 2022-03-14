' https://kuroeveryday.blogspot.com/2016/07/excel-diff.html
' を見て修正した

Option Explicit

'--------------------------------------------------------
'   引数：excel1  比較対象ファイル１のオブジェクト
'         excel2  比較対象ファイル２のオブジェクト
'   戻値：エラーリスト（Collection型）
'--------------------------------------------------------
Function Diff(ByRef excel1 As Workbook, ByRef excel2 As Workbook) As Collection
    Dim lastRow As Long: lastRow = excel1.Sheets(1).UsedRange.Rows.Count
    Dim lastCol As Long: lastCol = excel1.Sheets(1).UsedRange.Columns.Count
    Debug.Print Str(lastRow) & "行" & Str(lastCol) & "列"
    
    Dim errorList As New Collection
    
    '------------------------------------------------
    ' 列名をチェックし同一ファイルか確認する
    '------------------------------------------------
    Dim rowIdx As Long, colIdx As Long
    For colIdx = 1 To lastCol
        If excel1.Sheets(1).Cells(1, colIdx).value <> excel2.Sheets(1).Cells(1, colIdx).value Then
            errorList.Add ("ファイルが違います。")
            Set Diff = errorList

            Exit Function
        End If
    Next
        
    '------------------------------------------------
    ' Excelのデータを配列にコピー
    ' ※ 配列コピーには時間がかかるので列名チェック後に処理する
    '------------------------------------------------
    Dim excelRange1 As Variant
    With excel1.Sheets(1)
        excelRange1 = .Range(.Cells(1, 1), .Cells(lastRow, lastCol))
    End With
    
    Dim excelRange2 As Variant
    With excel2.Sheets(1)
        excelRange2 = .Range(.Cells(1, 1), .Cells(lastRow, lastCol))
    End With
    
    '------------------------------------------------
    ' データの内容チェック
    '------------------------------------------------
    '-- 1行目はラベルなので2行目からスタート
    For rowIdx = 2 To lastRow
        For colIdx = 1 To lastCol
            If excelRange1(rowIdx, colIdx) <> excelRange2(rowIdx, colIdx) Then
                '-- エラーメッセージの格納
                errorList.Add (PadLeft(rowIdx, 8, " ") & "行目：" & excelRange1(1, colIdx))
            End If
        Next
    Next

    Set Diff = errorList
    Debug.Print "Diffが終了しました"
    
End Function

'--------------------------------------------------------
' パディング処理（右寄せ）
'
'   引数：value        パディングする文字列
'         totalWidth   結果として生成される文字列の文字数
'         paddingChar  埋め込み文字列
'   戻値：totalWidth の長さになるまで左側に paddingChar の文字が埋め込まれた文字列
'--------------------------------------------------------
Function PadLeft(ByVal value As Variant, ByVal totalWidth As Long, ByVal paddingChar As String)
    PadLeft = String(totalWidth - Len(value), paddingChar) & value
End Function

'-------------------------------------------------------------------------------------------------------
'-------------------------------------------------------------------------------------------------------
'-------------------------------------------------------------------------------------------------------

Option Explicit
' 処理時間計測用
Private Declare PtrSafe Function GetTickCount Lib "kernel32" () As Long

Private Sub DiffButton_Click()
    Dim startTime As Long
    startTime = GetTickCount
    
    Dim Result As String
    Result = ""
    ' Result.Text = ""
    
    Application.EnableEvents = False
    Application.ScreenUpdating = False

    
    On Error GoTo ErrHandler
    
    '----------------------------------------
    ' Excelオブジェクトの作成
    '----------------------------------------
    ' Dim excel1 As Object
    ' Dim excel2 As Object
    ' Set excel1 = CreateObject("Excel.Application")
    ' Set excel2 = CreateObject("Excel.Application")
    ' excel1.Application.Workbooks.Open Filename:=Target1.Text
    ' excel2.Application.Workbooks.Open Filename:=Target2.Text

    Dim excel1 As Workbook
    Dim excel2 As Workbook
    
    Set excel1 = Workbooks("外部データソースサンプル.xlsx")
    Set excel2 = Workbooks("外部データソースサンプル - コピー.xlsx")
    
    
    '----------------------------------------
    ' ファイルの比較チェック開始
    '----------------------------------------
    Dim errorList As New Collection
    
    Set errorList = Diff(excel1, excel2)
    
    '----------------------------------------
    ' 比較チェックの結果表示
    '----------------------------------------
    If errorList.Count = 0 Then
        Result = "ファイルが一致しました。"
        ' Result.Text = "ファイルが一致しました。"
    Else
        Result = "ファイルが一致しませんでした。"
        ' Result.Text = "ファイルが一致しませんでした。"
        
        '-- エラーメッセージの出力
        Dim error As Variant
        For Each error In errorList
            Result = Result & vbCrLf & error
            ' Result.Text = Result.Text & vbCrLf & error
        Next
    End If
    
    GoTo Finally
    
ErrHandler:
    Result = Err.Number & ":" & Err.Description
    ' Result.Text = Err.Number & ":" & Err.Description
    Resume Finally

Finally:
    '-- 終了処理
    'excel1.Application.Workbooks.Close
    'excel2.Application.Workbooks.Close
    'excel1.Application.Quit
    'excel2.Application.Quit
    
    excel1.Close
    excel2.Close

    Result = Result & vbCrLf & "処理時間：" & (GetTickCount - startTime) / 1000 & "秒"
    ' Result.Text = Result.Text & vbCrLf & "処理時間：" & (GetTickCount - startTime) / 1000 & "秒"
    Debug.Print Result
    Application.EnableEvents = True
    Application.ScreenUpdating = True
End Sub
