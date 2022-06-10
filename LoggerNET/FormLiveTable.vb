Imports System.IO
Imports System.Text

Public Class FormLiveTable
    Public Property LD As ClassLoggerDisplay
    Public Property LTModules As List(Of ClassModule)
    Public Property FilesInstCsvPath As String
    Private Sub FormLiveTable_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Try

            
            Call InitComponents()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub FormLiveTable_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        Try
            FormMDI.FLT = Nothing
            If FormMDI.FL IsNot Nothing Then
                If FormMDI.FL.FLT IsNot Nothing Then
                    FormMDI.FL.FLT = Nothing
                End If
            End If
        Catch ex As ArgumentException
        End Try
    End Sub

    Sub InitComponents()
        Try

            
            Me.Text = "Visualizzazione dati"

            
            With DataGridViewLogger

                
                

                
                .BackgroundColor = Color.WhiteSmoke

                
                .AutoGenerateColumns = True
                .MultiSelect = False

                
                .RowHeadersVisible = True
                .RowHeadersBorderStyle = DataGridViewHeaderBorderStyle.None
                .RowHeadersWidth = 25

                
                .BorderStyle = BorderStyle.None

                
                .EditMode = DataGridViewEditMode.EditProgrammatically
                .AllowUserToAddRows = False
                .AllowUserToDeleteRows = False
                .AllowUserToResizeRows = False
                .ReadOnly = True

                
                .SelectionMode = DataGridViewSelectionMode.FullRowSelect

                
                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft

                
                
                
                .ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText

            End With

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Function SetParametersList() As Boolean
        Try

            With CheckedListBoxParameters

                For Each MyModule As ClassModule In LTModules

                    For Each MyChannel As ClassChannel In MyModule.Channels
                        If MyChannel.IsDiagnostic Then
                            
                        Else
                            
                            .Items.Add(MyChannel)
                            .DisplayMember = "FullName"
                        End If
                    Next

                Next

            End With

        Catch ex As ArgumentException
        End Try
    End Function

    Private Sub CheckedListBoxParameters_SelectedValueChanged(sender As Object, e As EventArgs) Handles CheckedListBoxParameters.SelectedValueChanged
    End Sub

    Private Sub ToolStripButtonRun_Click(sender As Object, e As EventArgs) Handles ToolStripButtonRun.Click
        If ToolStripButtonRun.Checked Then
            
            ListItemChanged()
        End If
    End Sub

    Private Sub ToolStripButtonSelectAll_Click(sender As Object, e As EventArgs) Handles ToolStripButtonSelectAll.Click
        Try

            
            Dim newCheckedState As CheckState = CheckState.Checked
            For idx As Integer = 0 To CheckedListBoxParameters.Items.Count - 1
                Me.CheckedListBoxParameters.SetItemCheckState(idx, newCheckedState)
            Next

            
            ListItemChanged()

        Catch ex As ArgumentException
        End Try
    End Sub

    Sub ListItemChanged()
        Try

            
            Dim Headers As String() = {"Data & ora"}

            
            With DataGridViewLogger

                .Columns.Clear()

                .Columns.Add("Fulldate", "Data & ora")
                .Columns(0).Width = 150

                
                
                

                For Each Item As ClassChannel In CheckedListBoxParameters.CheckedItems
                    
                    .Columns.Add("Column" + Item.ID.ToString, Item.FullName)

                    
                    ReDim Preserve Headers(Headers.Length)
                    Headers(Headers.Length - 1) = Item.FullName

                Next

                .AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells
                .AutoResizeColumns()

            End With

            
            If Headers IsNot Nothing Then
                CsvAppenHeader(Headers)
            End If

        Catch ex As ArgumentException
        End Try
    End Sub

    Public Function AppendNewData(listMain As List(Of ClassLoggerDisplay)) As Boolean
        Try

            If ToolStripButtonRun.Checked = False Then Return False

            
            With DataGridViewLogger
                
                
                

                
                Dim row As List(Of String) = New List(Of String)

                
                For Each Item As ClassChannel In CheckedListBoxParameters.CheckedItems

                    
                    For Each rec As ClassLoggerDisplay In listMain

                        If Item.ID = rec.ID Then

                            row.Add(rec.LastValue.ToString)
                            
                            Exit For

                        End If
                    Next

                Next

                If row.Count > 0 And row.Count = CheckedListBoxParameters.CheckedItems.Count Then

                    
                    Dim arr As String() = {Now.ToString("dd/MM/yyyy HH:mm:ss")}
                    For Each item As String In row
                        ReDim Preserve arr(arr.Length)
                        arr(arr.Length - 1) = item
                    Next

                    
                    With .Rows
                        .Add(arr)
                    End With

                    
                    If Me.Visible And Me.WindowState <> FormWindowState.Minimized Then
                        .FirstDisplayedScrollingRowIndex = .Rows.Count - 1
                    End If

                    
                    If .Rows.Count > 3600 Then
                        
                        .Rows.RemoveAt(0)
                    End If

                    
                    Call CsvAppendData(arr)

                End If

            End With

        Catch ex As ArgumentException
            Debug.Print(ex.Message)
        End Try
    End Function

    Private Sub CsvAppenHeader(Headers As String())
        Try

            Dim FileName As String = GetCsvFilename()

            Dim Csvline As String
            Csvline = String.Join(";", Headers).Replace(".", ",")

            My.Computer.FileSystem.WriteAllText(FileName, Csvline.ToString + vbCrLf, True, System.Text.Encoding.ASCII)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub CsvAppendData(DataArray As String())
        Try

            Dim FileName As String = GetCsvFilename()

            
            
            

            Dim Csvline As String
            Csvline = String.Join(";", DataArray).Replace(".", ",")

            My.Computer.FileSystem.WriteAllText(FileName, Csvline.ToString + vbCrLf, True, System.Text.Encoding.ASCII)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Function GetCsvFilename() As String
        Try

            
            Dim FileName As String = Path.Combine(FilesInstCsvPath, "Tabella-" + Now.ToString("yyyy-MM-dd") + ".csv")

            Return FileName

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

End Class