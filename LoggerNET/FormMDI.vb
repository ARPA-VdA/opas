Imports System.IO
Imports Ecometer.ClassUtils
Imports System.Threading
Imports System.Net.Sockets

Public Class FormMDI

    Public CM As ClassMain
    Public FL As FormLogger
    Public FE As FormEvents
    Public FLT As FormLiveTable
    Public FLC As FormLiveChart

    Dim Server As ClassTcpServer

#Region "FORM"

    Private Sub FormMain_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            
            
            
            ClassUtils.LogMessage("Avvio programma...", eMsgType.Info)

            
            
            
            CM = New ClassMain
            CM.StartUp()

            
            
            
            Call IniComponents()

            
            
            
            TimerTime_Tick(sender, e)

            
            
            
            LogMessage2List("Programma avviato")
            ClassUtils.LogMessage("Programma avviato", eMsgType.Info)

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub FormMain_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Try

            If MessageBox.Show("Chiudere l
                    MessageBoxButtons.YesNo, MessageBoxIcon.Warning, _
                    MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.No Then
                
                e.Cancel = True
                Exit Sub
            End If

            
            Dim FM As New FormMessage
            FM.MdiParent = Me
            FM.TextBoxMessage.Text = "Attendere chiusura in corso..."
            FM.Show()
            Application.DoEvents()

            
            FL.TimerMean.Enabled = False
            FL.TimerPolling.Enabled = False

            
            FL.BackgroundWorker.CancelAsync()

            
            Dim BeginTime As Double = Microsoft.VisualBasic.DateAndTime.Timer + 5
            Do While Microsoft.VisualBasic.DateAndTime.Timer < BeginTime
                If Not FL.BackgroundWorker.IsBusy Then Exit Do
                FL.BackgroundWorker.CancelAsync()
                Application.DoEvents()
            Loop

            
            CM = Nothing
            FL = Nothing
            FE = Nothing
            
            FM.Dispose()
            FM = Nothing

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub TimerTime_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerTime.Tick
        ToolStripStatusLabelTimer.Text = "Data: " +
            DateTime.Now.ToLongDateString() + " " +
            DateTime.Now.ToLongTimeString()
    End Sub

    Private Sub ToolStripMenuItemAbout_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItemAbout.Click
        Dim About As New FormAbout
        About.ShowDialog()
    End Sub

    Private Sub ToolStripMenuItemExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItemExit.Click
        Me.Close()
    End Sub

    Private Sub ToolStripMenuItemShowEvents_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItemShowEvents.Click
        Try

            If FE IsNot Nothing Then Exit Sub

            
            FE = New FormEvents
            FE.MdiParent = Me
            
            
            FE.Size = New Size(Me.ClientSize.Width - 5, 200)
            FE.Location = New Point(0, Me.ClientSize.Height - 250)
            FE.Show()

            
            FL.FE = FE

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub VisualizzaDatiToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles VisualizzaDatiToolStripMenuItem.Click
        Try

            If FLT IsNot Nothing Then Exit Sub

            
            FLT = New FormLiveTable
            FLT.MdiParent = Me
            FLT.FilesInstCsvPath = Me.CM.FilesInstCsvPath
            FLT.Location = New Point(0, 0)
            
            FLT.LTModules = CM.LG.Modules
            FLT.SetParametersList()
            FLT.Show()

            
            FL.FLT = FLT

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub VisualizzaGraficiToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles VisualizzaGraficiToolStripMenuItem.Click, ToolStripButtonShowCharts.Click
        Try

            If FLC IsNot Nothing Then Exit Sub

            
            FLC = New FormLiveChart
            FLC.MdiParent = Me
            FLC.Location = New Point(0, 0)
            
            FLC.LTModules = CM.LG.Modules
            FLC.SetParametersList()
            FLC.Show()

            
            FL.FLC = FLC

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub ToolStripMenuItemShowLoggerExplorer_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItemShowLoggerExplorer.Click
        Try

            
            Dim F As New FormLoggerExplorer
            F.MdiParent = Me
            F.Show()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub ToolStripButtonWindowsDefault_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItemWindowsDefault.Click, ToolStripButtonWindowsDefault.Click
        SetDefaultWindowsPosition()
    End Sub

    Private Sub CascadeToolStripMenuItem_Click(ByVal sender As Object, ByVal e As EventArgs) Handles CascadeToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.Cascade)
    End Sub

    Private Sub TileVerticalToolStripMenuItem_Click(ByVal sender As Object, ByVal e As EventArgs) Handles TileVerticalToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.TileVertical)
    End Sub

    Private Sub TileHorizontalToolStripMenuItem_Click(ByVal sender As Object, ByVal e As EventArgs) Handles TileHorizontalToolStripMenuItem.Click
        Me.LayoutMdi(MdiLayout.TileHorizontal)
    End Sub

#End Region

#Region "FUNCTIONS"
    Sub IniComponents()
        Try

            
            ClassUtils.LogMessage("Inizio fase gui...", eMsgType.Info)

            
            
            
            Me.SuspendLayout()

            
            
            
            
            If Debugger.IsAttached Then
                Me.WindowState = FormWindowState.Normal
                Me.Size = New Size(1024, 860)
                Me.StartPosition = FormStartPosition.CenterScreen

            ElseIf CM.AppFullScreen = False Then
                Me.WindowState = FormWindowState.Normal
                Dim screenWidth As Integer = Screen.PrimaryScreen.Bounds.Width
                Dim screenHeight As Integer = Screen.PrimaryScreen.Bounds.Height
                Me.Size = New Size(CInt(screenWidth * 0.8), CInt(screenHeight * 0.8))
                Me.StartPosition = FormStartPosition.CenterScreen

            Else
                Me.WindowState = FormWindowState.Maximized
            End If

            
            
            
            Dim vt As String = Application.ProductName + "  Versione {0}.{1}.{2}.{3}"
            Me.Text = System.String.Format(vt, My.Application.Info.Version.Major,
                My.Application.Info.Version.Minor, My.Application.Info.Version.Build,
                My.Application.Info.Version.Revision) + " * " + CM.Title

            
            
            
            ToolStripStatusLabelInfo.Text = String.Format("Stazione : {0}, {1}", CM.LG.ID, CM.LG.DataFileHeader)
            ToolStripStatusLabelConfig.Text = String.Format("Configurazione : {0}", CM.ConfigFileName)
            ToolStripStatusLabelTimer.Text = "Data: " +
                DateTime.Now.ToLongDateString() + " " +
                DateTime.Now.ToLongTimeString()

            
            
            
            If CM.LogWindowsVisible Then

                
                FE = New FormEvents
                FE.MdiParent = Me
                
                
                
                FE.Show()

                
                FL = New FormLogger
                
                FL.LG = CM.LG
                FL.FE = FE
                FL.MdiParent = Me
                FL.FilesDataDatPath = Me.CM.FilesDataDatPath
                FL.FilesDataCsvPath = Me.CM.FilesDataCsvPath
                FL.FilesInstCsvPath = Me.CM.FilesInstCsvPath
                
                FL.Show()
                FL.Location = New Point(0, 0)

            Else

                
                FL = New FormLogger
                
                FL.LG = CM.LG
                FL.FE = Nothing
                FL.MdiParent = Me
                FL.FilesDataDatPath = Me.CM.FilesDataDatPath
                FL.FilesDataCsvPath = Me.CM.FilesDataCsvPath
                FL.FilesInstCsvPath = Me.CM.FilesInstCsvPath
                
                FL.Show()
                FL.Location = New Point(0, 0)

            End If

            
            
            
            SetDefaultWindowsPosition()

            
            
            
            ClassUtils.LogMessage("Avvio timer orologio...", eMsgType.Info)
            TimerTime.Enabled = True

            
            
            
            ClassUtils.LogMessage("Avvio timer principali...", eMsgType.Info)
            Me.FL.StartMainTimers()

            
            ClassUtils.LogMessage("Fine fase gui...", eMsgType.Info)

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        Finally
            Me.ResumeLayout()
        End Try
    End Sub

    Sub SetDefaultWindowsPosition()
        Try

            
            If FE IsNot Nothing Then
                

                
                FE.Size = New Size(Me.ClientSize.Width - 5, 200)
                FE.Location = New Point(0, Me.ClientSize.Height - 275)

                
                If FL IsNot Nothing Then
                    FL.Size = New Size(Me.ClientSize.Width - 5, Me.ClientSize.Height - 275)
                    FL.Location = New Point(0, 0)
                End If

            Else
                

                
                If FL IsNot Nothing Then
                    FL.Size = New Size(Me.ClientSize.Width - 5, Me.ClientSize.Height - 75)
                    FL.Location = New Point(0, 0)
                End If

            End If

        Catch ex As ArgumentException
        End Try
    End Sub

#End Region

#Region "Common"
    Public Sub LogMessage2List(ByVal Message As String)
        If FE IsNot Nothing Then FE.LogMessage(Message)
    End Sub
#End Region

End Class
