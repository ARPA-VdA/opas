Public Class FormEvents

    Private Sub FormEvents_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try

            Me.Text = "Eventi applicazione"

            With ListViewEvents
                .Dock = DockStyle.Fill
                .Columns.Add("Data", 140, HorizontalAlignment.Left)
                .Columns.Add("Evento", Me.Width - .Columns(0).Width - 40, HorizontalAlignment.Left)
            End With

            Me.Location = New Point(0, FormMDI.ClientSize.Height - 250)

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub FormEvents_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        Try
            FormMDI.FE = Nothing
            If FormMDI.FL IsNot Nothing Then
                FormMDI.FL.FE = Nothing
            End If
        Catch ex As ArgumentException
        End Try
    End Sub

    Delegate Sub SetTextCallback(Message As String)
    Public Sub LogMessage(ByVal Message As String)
        Try
            
            
            
            If ListViewEvents.InvokeRequired Then
                Dim d As New SetTextCallback(AddressOf LogMessage)
                Me.Invoke(d, New Object() {Message})
            Else
                With ListViewEvents
                    .SuspendLayout()
                    With .Items.Add(Now.ToString("yyyy-MM-dd HH:mm:ss"), 0)
                        .SubItems.Add(Message)
                    End With
                    If .Items.Count > 5000 Then .Items.RemoveAt(0)
                    .EnsureVisible(ListViewEvents.Items.Count - 1)
                    .ResumeLayout()
                    
                End With
            End If

        Catch ex As Exception
            If ListViewEvents.InvokeRequired Then
                Dim d As New SetTextCallback(AddressOf LogMessage)
                Me.Invoke(d, New Object() {Message})
            Else
                ListViewEvents.Items.Clear()
            End If
        End Try
    End Sub

    Private Sub FormEvents_ResizeEnd(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.ResizeEnd
        Try
            ListViewEvents.Columns(1).Width = Me.Width - ListViewEvents.Columns(0).Width - 40
        Catch ex As ArgumentException
        End Try
    End Sub

    Private Sub ToolStripButtoncLEAR_Click(sender As Object, e As EventArgs) Handles ToolStripButtoncLEAR.Click
        Try
            ListViewEvents.Items.Clear()
        Catch ex As ArgumentException
        End Try
    End Sub
End Class