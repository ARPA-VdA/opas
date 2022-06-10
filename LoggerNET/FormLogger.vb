Imports System.IO
Imports System.Text
Imports Ecometer.ClassModule
Imports Ecometer.ClassUtils

Public Class FormLogger

    
    Public Property LG As ClassLogger
    Public Property FE As FormEvents
    Public Property FLT As FormLiveTable
    Public Property FLC As FormLiveChart

    Public FilesDataDatPath As String
    Public FilesDataCsvPath As String
    Public FilesInstCsvPath As String

    
    Private FlagPollingGotData As Boolean
    Private FlagMeanDone As Boolean
    Private FlagRefreshCommands As Boolean

#Region "Form events"

    Private Sub FormLogger_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try

            
            Call InitComponents()

            
            Call RefreshGridDataAndDiag()
            Call RefreshGridCommands()

            
            Call LoggerOpenSerialPorts()

            
            
            

            
            
            

            
            FlagMeanDone = True 
            FlagRefreshCommands = False

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    
    Private Sub TabControlLogger_Selecting(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TabControlCancelEventArgs) Handles TabControlLogger.Selecting
        If e.TabPageIndex = 2 Then e.Cancel = True
    End Sub

    Private Sub FormLogger_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        

        
        
        
        
        
        
        
    End Sub

    Private Sub FormLogger_FormClosed(sender As Object, e As FormClosedEventArgs) Handles Me.FormClosed
        Try

            
            Call LoggerCloseSerialPorts()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub TimerPolling_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerPolling.Tick
        Try
            
            

            
            Dim RefSeconds As Integer = Now.Second

            
            Dim FlagPollingGotModuleData = False

            
            For Each Mo As ClassModule In LG.Modules
                If Not Mo.Active Then Continue For

                
                If Not RefSeconds Mod Mo.PollingInterval = 0 Then Continue For

                
                FlagPollingGotModuleData = True
                Exit For
            Next
            If Not FlagPollingGotModuleData Then Exit Sub
            

            
            If Not BackgroundWorker.IsBusy Then

                BackgroundWorker.RunWorkerAsync()

            Else
                ClassUtils.LogMessage("BackgroundWorker is busy...", eMsgType.Debug)
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub TimerMean_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerMean.Tick
        Try

            
            If Now.Second = 0 And FlagMeanDone = False Then Call LoggerSaveMeans()

            
            If Now.Second > 55 And FlagMeanDone = True Then Call ResetMeanDoneFlags()

            
            

        Catch ex As ArgumentException
        End Try
    End Sub

    Private Sub ToolStripMenuItemStatus_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItemStatus.Click
        Try

            If ToolStripMenuItemStatus.Checked = True Then

                If MessageBox.Show("Disattivare il polling automatico ?", Application.ProductName,
                        MessageBoxButtons.YesNo, MessageBoxIcon.Warning,
                        MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.No Then
                    Exit Sub
                End If

                
                TimerPolling.Enabled = False

                
                Me.BackgroundWorker.CancelAsync()

                
                Dim BeginTime As Double = Microsoft.VisualBasic.DateAndTime.Timer + 5
                Do While Microsoft.VisualBasic.DateAndTime.Timer < BeginTime
                    If Not Me.BackgroundWorker.IsBusy Then Exit Do
                    Me.BackgroundWorker.CancelAsync()
                    Application.DoEvents()
                Loop

                System.Threading.Thread.Sleep(100)

                
                LoggerSuspendSerialPorts()

                ToolStripMenuItemStatus.Checked = False
                ToolStripMenuItemStatus.Text = String.Format("Polling sospeso - riattiva")
                ToolStripStatusLabelInfo.Text = String.Format("Polling sospeso")

            Else
                
                TimerPolling.Enabled = True

                
                LoggerOpenSerialPorts()

                ToolStripMenuItemStatus.Checked = True
                ToolStripMenuItemStatus.Text = String.Format("Polling attivo")
                ToolStripStatusLabelInfo.Text = String.Format("Polling attivo")

            End If


        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub


    Private Sub ToolStripMenuItemStateSave_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItemStateSave.Click
        Try

            Dim DataFilePath As String = "app.json"

            
            If FormMDI.CM.LoggerSerializeJson(LG, DataFilePath) Then
                MessageBox.Show("Serializzazione della configurazione eseguita.",
                    Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Information)
            Else
                MessageBox.Show("Errore durante la serializzazione della configurazione !",
                    Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub ToolStripMenuItemStatusLoad_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItemStatusLoad.Click
        Try

            Dim DataFilePath As String = "app.json"

            
            Dim Ser As ClassSerializer
            Ser = New ClassSerializer
            LG = Ser.DeSerializeLoggerJson(DataFilePath)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub


    Private Sub DataGridViewLogger_SelectionChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DataGridViewLogger.SelectionChanged
        
        If Me.DataGridViewLogger.SelectedCells.Count > 0 Then
            
        End If
    End Sub

    
    
    
    
    
    
    
    

    Private Sub DataGridViewLogger_RowEnter(sender As Object, e As DataGridViewCellEventArgs) Handles DataGridViewLogger.RowEnter

        Dim row As DataGridViewRow = DataGridViewLogger.Rows(e.RowIndex)
        If row IsNot Nothing Then
            
        End If
    End Sub

#Region "BackGround Worker"
    Private Sub BackgroundWorker_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorker.DoWork
        Try
            Call LoggerPolling()
        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub BackgroundWorker_RunWorkerCompleted(ByVal sender As Object, ByVal e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles BackgroundWorker.RunWorkerCompleted
        Try
            
            If FlagPollingGotData Then
                Call RefreshGridDataAndDiag()
                If FlagRefreshCommands Then Call RefreshGridCommands()
            End If
        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub
#End Region

#End Region

#Region "Main routines"

    Sub InitComponents()
        Try

            
            Me.Text = "Acquisizione dati"

            
            
            
            ToolStripStatusLabelInfo.Text = String.Format("Attesa primo ciclo acquisizione...")
            LogMessage2List("Attesa primo ciclo acquisizione...")
            ClassUtils.LogMessage("Attesa primo ciclo acquisizione...", eMsgType.Info)

            
            ToolStripMenuItemStatus.Text = String.Format("Polling attivo")
            LogMessage2List("Polling attivo")
            ClassUtils.LogMessage("Polling attivo", eMsgType.Info)

            
            ToolStripStatusLabelLatestPolling.AutoSize = True
            ToolStripStatusLabelLatestPolling.Text = "Ultimo polling..."

            
            ToolStripMenuItemStatusInfo.Enabled = False

            
            TabControlLogger.Dock = DockStyle.Fill

            
            With DataGridViewLogger

                
                .Dock = DockStyle.Fill

                
                .BackgroundColor = Color.WhiteSmoke

                
                .AutoGenerateColumns = True
                .MultiSelect = False

                
                .RowHeadersVisible = False
                
                

                
                .BorderStyle = BorderStyle.None

                
                .EditMode = DataGridViewEditMode.EditProgrammatically
                .AllowUserToAddRows = False
                .AllowUserToDeleteRows = False
                .AllowUserToResizeRows = False
                .AllowUserToOrderColumns = False

                
                

                
                
                

                .AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells
                
                
                

                
                
                

                
                .ReadOnly = True

                
                .SelectionMode = DataGridViewSelectionMode.FullRowSelect

                
                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                
                Dim list = New List(Of ClassLoggerDisplay)
                .DataSource = list

                .Columns(0).HeaderText = "No"
                .Columns(1).HeaderText = "Modulo"
                .Columns(2).HeaderText = "Seriale"
                .Columns(3).HeaderText = "Canale"
                .Columns(4).HeaderText = "Unità"
                .Columns(5).HeaderText = "Grezzo"
                .Columns(6).HeaderText = "Istantaneo"
                .Columns(7).HeaderText = "Media/Somma"
                .Columns(8).HeaderText = "Massimo"
                .Columns(9).HeaderText = "Minimo"
                .Columns(10).HeaderText = "Letture"
                .Columns(11).HeaderText = "Errate"

                .Columns(0).Frozen = True

                
                
                
                Dim defStyle As New DataGridViewCellStyle
                defStyle.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
                defStyle.WrapMode = DataGridViewTriState.True
                
                Dim defStyle2 As New DataGridViewCellStyle
                defStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
                defStyle2.WrapMode = DataGridViewTriState.True
                
                Dim codeStyle As New DataGridViewCellStyle
                codeStyle.BackColor = Color.Aqua
                codeStyle.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleRight
                
                Dim lastStyle As New DataGridViewCellStyle
                lastStyle.BackColor = Color.Aquamarine
                

                
                
                
                .ColumnHeadersDefaultCellStyle = defStyle
                .ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize
                
                
                
                .Columns("Code").DefaultCellStyle = codeStyle
                .Columns("ChannelName").DefaultCellStyle = defStyle2
                .Columns("ChannelUnit").DefaultCellStyle = defStyle2
                .Columns("LastRawValue").DefaultCellStyle = lastStyle

                
                
                
                .ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText

                
                
                
                

            End With

            With DataGridViewLoggerDiags

                
                .Dock = DockStyle.Fill

                
                .BackgroundColor = Color.WhiteSmoke

                
                .AutoGenerateColumns = True
                .MultiSelect = False

                
                .RowHeadersVisible = False
                
                

                
                .BorderStyle = BorderStyle.None

                
                .EditMode = DataGridViewEditMode.EditProgrammatically
                .AllowUserToAddRows = False
                .AllowUserToDeleteRows = False
                .AllowUserToResizeRows = False
                .AllowUserToOrderColumns = False
                .AllowUserToResizeColumns = True
                .ReadOnly = True

                
                .SelectionMode = DataGridViewSelectionMode.FullRowSelect

                
                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                
                Dim list = New List(Of ClassLoggerDisplay)
                .DataSource = list

                .Columns(0).HeaderText = "No"
                .Columns(1).HeaderText = "Modulo"
                .Columns(2).HeaderText = "Seriale"
                .Columns(3).HeaderText = "Canale"
                .Columns(4).HeaderText = "Unità"
                .Columns(5).HeaderText = "Grezzo"
                .Columns(6).HeaderText = "Istantaneo"
                .Columns(7).HeaderText = "Media/Somma"
                .Columns(8).HeaderText = "Massimo"
                .Columns(9).HeaderText = "Minimo"
                .Columns(10).HeaderText = "Letture"
                .Columns(11).HeaderText = "Errate"

                .Columns(0).Frozen = True

                .AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells
                .AllowUserToResizeColumns = True

                
                
                
                Dim defStyle As New DataGridViewCellStyle
                defStyle.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
                defStyle.WrapMode = DataGridViewTriState.True
                
                Dim defStyle2 As New DataGridViewCellStyle
                defStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
                defStyle2.WrapMode = DataGridViewTriState.True
                
                Dim codeStyle As New DataGridViewCellStyle
                codeStyle.BackColor = Color.Aqua
                codeStyle.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleRight
                
                Dim lastStyle As New DataGridViewCellStyle
                lastStyle.BackColor = Color.Aquamarine
                

                
                
                
                .ColumnHeadersDefaultCellStyle = defStyle
                .ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize
                
                
                
                .Columns("Code").DefaultCellStyle = codeStyle
                .Columns("ChannelName").DefaultCellStyle = defStyle2
                .Columns("ChannelUnit").DefaultCellStyle = defStyle2
                .Columns("LastRawValue").DefaultCellStyle = lastStyle

                
                
                
                .ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText

                
                
                
                

            End With

            With DataGridViewCommand

                
                .Dock = DockStyle.Fill

                
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

                
                .DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                
                Dim list = New List(Of ClassLoggerDisplayCommand)
                .DataSource = list

                .Columns(0).HeaderText = "No"
                .Columns(1).HeaderText = "ID Modulo"
                .Columns(2).HeaderText = "Nome Modulo"
                .Columns(3).HeaderText = "ID Canale"
                .Columns(4).HeaderText = "Nome Canale"
                .Columns(5).HeaderText = "Comando"
                .Columns(6).HeaderText = "Valore"
                .Columns(7).HeaderText = "Data ora"
                .Columns(8).HeaderText = "Ripeti"
                .Columns(9).HeaderText = "Eseguito"

                .Columns(0).Frozen = True

                .AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells
                .AllowUserToResizeColumns = True

                
                
                
                .ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText

                
                
                
                Dim styleCells As DataGridViewCellStyle
                styleCells = New DataGridViewCellStyle()
                styleCells.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleRight

                
                
                
                Dim style As DataGridViewCellStyle
                style = New DataGridViewCellStyle()
                style.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
                style.WrapMode = DataGridViewTriState.True

                
                
                
                .ColumnHeadersDefaultCellStyle = style
                .ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize

                
                
                
                Call ColumnHeaderSetFormat(DataGridViewCommand)

            End With

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Sub StartMainTimers()
        Try

            
            TimerPolling.Interval = 1000
            TimerPolling.Enabled = True

            
            TimerMean.Interval = 1000
            TimerMean.Enabled = True

        Catch ex As ArgumentException

        End Try
    End Sub

    Private Sub LoggerOpenSerialPorts()
        Try

            
            Me.ToolStripStatusLabelInfo.Text = String.Format("Apertura porte seriali...")
            LogMessage2List("Apertura porte seriali...")
            ClassUtils.LogMessage("Apertura porte seriali...", eMsgType.Info)

            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                
                For Each Mo2 As ClassModule In LG.Modules

                    If Not Mo2.Active Then Continue For

                    If Mo.ComPortName = Mo2.ComPortName Then
                        Mo.SerialPortObj = Mo2.SerialPortObj
                        Exit For
                    End If

                Next

                Me.ToolStripStatusLabelInfo.Text = String.Format("Apertura apertura porta modulo[{0}...", Mo.Name)
                LogMessage2List(String.Format("Apertura apertura porta modulo: {0}, seriale: {1}", Mo.Name, Mo.ComPortName))
                ClassUtils.LogMessage(String.Format("Apertura apertura porta modulo: {0}, seriale: {1}", Mo.Name, Mo.ComPortName), eMsgType.Info)

                If Not Mo.OpenPort() Then
                    Me.ToolStripStatusLabelInfo.Text = String.Format("Errore apertura porta")
                    LogMessage2List(String.Format("Errore apertura porta."))
                    ClassUtils.LogMessage(String.Format("Errore apertura porta."), eMsgType.Errors)
                End If

                
                Application.DoEvents()
            Next

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        Finally
            
            Me.ToolStripStatusLabelInfo.Text = String.Format("Eseguito.")
            LogMessage2List("Eseguito.")
            ClassUtils.LogMessage(String.Format("Eseguito."), eMsgType.Info)
        End Try
    End Sub

    Private Sub LoggerCloseSerialPorts()
        Try
            
            Me.ToolStripStatusLabelInfo.Text = String.Format("Chiusura porte seriali...")
            LogMessage2List(String.Format("Chiusura porte seriali..."))
            ClassUtils.LogMessage(String.Format("Chiusura porte seriali..."), eMsgType.Info)

            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                Mo.ClosePort()

            Next
        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        Finally
            
            Me.ToolStripStatusLabelInfo.Text = String.Format("Eseguito")
            LogMessage2List(String.Format("Eseguito."))
            ClassUtils.LogMessage(String.Format("Eseguito."), eMsgType.Info)
        End Try
    End Sub
    
    
    
    Private Sub LoggerSuspendSerialPorts()
        Try
            
            Me.ToolStripStatusLabelInfo.Text = String.Format("Sospensione porte seriali...")
            LogMessage2List(String.Format("Sospensione porte seriali..."))
            ClassUtils.LogMessage(String.Format("Sospensione porte seriali..."), eMsgType.Info)

            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                Mo.SuspendPort()

            Next
        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        Finally
            
            Me.ToolStripStatusLabelInfo.Text = String.Format("Eseguito")
            LogMessage2List(String.Format("Eseguito."))
            ClassUtils.LogMessage(String.Format("Eseguito."), eMsgType.Info)
        End Try
    End Sub
    Private Sub LoggerPolling()
        Try
            

            
            FlagPollingGotData = False

            
            Dim RefSeconds As Integer = Now.Second

            
            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                
                If Not RefSeconds Mod Mo.PollingInterval = 0 Then Continue For

                
                Mo.ArrayValues = Nothing

                
                Me.Invoke(
                    Sub()
                        
                        ToolStripStatusLabelInfo.Text = String.Format("Polling modulo {0}...", Mo.Name)
                        LogMessage2List(String.Format("Polling modulo: {0}, seriale: {1}", Mo.Name, Mo.SerialPortObj.PortName))
                        ClassUtils.LogMessage(String.Format("Polling modulo: {0}, seriale: {1}", Mo.Name, Mo.SerialPortObj.PortName), eMsgType.Info)
                    End Sub
                )

                
                Select Case Mo.ModuleTypeID

                    Case EnumModuleType.API100
                        Mo.ArrayValues = ModuleData.GetAPI100Values(Mo)

                    Case EnumModuleType.API100_DIAGS
                        Mo.ArrayValues = ModuleData.GetAPI100Diags(Mo)

                    Case EnumModuleType.API200, EnumModuleType.API200E
                        Mo.ArrayValues = ModuleData.GetApi200Values(Mo)

                    Case EnumModuleType.API200_DIAGS
                        Mo.ArrayValues = ModuleData.GetApi200Diags(Mo)

                    Case EnumModuleType.API300
                        Mo.ArrayValues = ModuleData.GetAPI300Values(Mo)

                    Case EnumModuleType.API300_DIAGS
                        Mo.ArrayValues = ModuleData.GetAPI300Diags(Mo)

                    Case EnumModuleType.API400, EnumModuleType.API401
                        Mo.ArrayValues = ModuleData.GetApi400Values(Mo)

                    Case EnumModuleType.API400A_DIAGS
                        Mo.ArrayValues = ModuleData.GetApi400ADiags(Mo)

                    Case EnumModuleType.API400E_DIAGS
                        Mo.ArrayValues = ModuleData.GetApi400EDiags(Mo)

                    Case EnumModuleType.API700
                        Mo.ArrayValues = ModuleData.GetApi700Values(Mo)

                    Case EnumModuleType.SM200
                        Mo.ArrayValues = ModuleData.GetSM200Values(Mo)

                    Case EnumModuleType.SM200_RPTM
                        Mo.ArrayValues = ModuleData.GetSM200BHPValues(Mo)

                    Case EnumModuleType.MCZ
                        Mo.ArrayValues = ModuleData.GetMCZValues(Mo)

                    Case EnumModuleType.TEOM_1400A
                        Mo.ArrayValues = ModuleData.GetTEOM1400aValues(Mo)

                    Case EnumModuleType.TEOM_1400A_DIAGS
                        Mo.ArrayValues = ModuleData.GetTEOM1400aDiags(Mo)

                    Case EnumModuleType.HORIBA370
                        Mo.ArrayValues = ModuleData.GetHoriba370Values(Mo)

                    Case EnumModuleType.PAS2000
                        Mo.ArrayValues = ModuleData.GetPAS2000Values(Mo)

                    Case EnumModuleType.GC955
                        Mo.ArrayValues = ModuleData.GetGC955Values(Mo)

                    Case EnumModuleType.VAISALA_WXT510
                        Mo.ArrayValues = ModuleData.GetVaisalaWXT510Values(Mo)

                    Case EnumModuleType.Silena600CE
                        Mo.ArrayValues = ModuleData.GetSilena600CEValues(Mo)

                    Case EnumModuleType.Silena
                        Mo.ArrayValues = ModuleData.GetSilenaValues(Mo)

                End Select

                
                Me.Invoke(
                    Sub()
                        ToolStripStatusLabelLatestPolling.Text = String.Format("Ultimo polling: {0}", Date.Now.ToString)
                    End Sub
                )

                
                If Mo.ArrayValues Is Nothing OrElse Mo.ArrayValues.Count = 0 Then

                    
                    Me.Invoke(
                        Sub()
                            LogMessage2List(String.Format("NESSUN DATO"))
                            ClassUtils.LogMessage(String.Format("NESSUN DATO"), eMsgType.Errors)
                        End Sub
                   )

                    
                    For Each Ch As ClassChannel In Mo.Channels
                        If Not Ch.Active Then Continue For
                        Ch.ReadingsWrong += 1 
                    Next

                    
                    FlagPollingGotData = True

                    
                    Continue For

                End If

                
                LogMessage2List(String.Format("Analisi dati..."))
                ClassUtils.LogMessage(String.Format("Analisi dati..."), eMsgType.Info)

                
                For Each Ch As ClassChannel In Mo.Channels

                    
                    

                    
                    If Not Ch.Active Then Continue For

                    
                    FlagPollingGotData = True

                    
                    If Mo.ArrayValues.Count >= Ch.DataArrayIdx + 1 Then
                        Ch.LastRawValue = Mo.ArrayValues(Ch.DataArrayIdx)
                    Else
                        
                        LogMessage2List(String.Format("Modulo {0} data array non contiene l
                        ClassUtils.LogMessage(String.Format("Modulo {0} data array non contiene l

                        
                        Ch.LastRawValue = Nothing
                        Ch.LastValue = Nothing
                        Ch.ReadingsWrong += 1 
                    End If

                    
                    If Ch.LastRawValue.HasValue Then

                        Dim Eval As String = Ch.Formule.Replace("x", Ch.LastRawValue.Value.ToString).ToLower
                        Eval = Eval.Replace("y=", "")
                        Eval = Eval.Replace(",", ".")

                        
                        
                        Ch.LastValue = ModuleData.Eval(Eval)
                        
                        
                        
                        

                        
                        If Ch.MaxValue Is Nothing Then
                            Ch.MaxValue = Ch.LastValue
                            Ch.MaxTime = Now
                            LogMessage2List(String.Format("Canale {0} prima impostazione valore massimo {1}.", Ch.Name, Ch.MaxValue))
                        End If
                        If Ch.MinValue Is Nothing Then
                            Ch.MinValue = Ch.LastValue
                            Ch.MinTime = Now
                            LogMessage2List(String.Format("Canale {0} prima impostazione valore minimo {1}.", Ch.Name, Ch.MinValue))
                        End If

                        
                        If Ch.LastValue > Ch.MaxValue Then
                            Ch.MaxValue = Ch.LastValue
                            Ch.MaxTime = Now
                            
                        End If
                        If Ch.LastValue < Ch.MinValue Then
                            Ch.MinValue = Ch.LastValue
                            Ch.MinTime = Now
                            
                        End If

                        
                        Ch.Readings += 1

                        
                        Ch.Values.Add(Ch.LastValue)

                        
                        Ch.TotalValue += Ch.LastValue.Value

                        
                        If Ch.Readings > 0 Then
                            Ch.MeanValue = CType(Math.Round(Ch.TotalValue / Ch.Readings, Ch.Decimals), Single?)
                            Ch.StdDev = getStandardDeviation(Ch.Values)
                        End If

                        

                        
                        If Ch.AllowedMaxValue IsNot Nothing AndAlso Ch.MeanValue > Ch.AllowedMaxValue Then
                            Ch.Code = Ch.Code Or 1 
                        End If
                        If Ch.AllowedMinValue IsNot Nothing AndAlso Ch.MeanValue < Ch.AllowedMinValue Then
                            Ch.Code = Ch.Code Or 1 
                        End If

                        
                        If Ch.StoreCsv Then
                            Call SaveChannelInstCsv(Mo, Ch)
                        End If

                    Else
                        
                        Ch.LastRawValue = Nothing
                        Ch.LastValue = Nothing
                        Ch.ReadingsWrong += 1 
                        
                        LogMessage2List(String.Format("Canale {0} nessun valore.", Ch.Name))
                        ClassUtils.LogMessage(String.Format("Canale {0} nessun valore.", Ch.Name))
                    End If

                    
                    Application.DoEvents()

                Next 

            Next 

            
            If FlagPollingGotData Then

                
                LG.StationAlarm = LG.StationAlarm Or ModuleData.EnumStationAlarm.VALID

            End If

            
            Me.Invoke(
                Sub()
                    ToolStripStatusLabelInfo.Text = String.Format("Attesa nuovo polling...")
                End Sub
            )

            
            

            

            
            

            

            
            

            
            

            
            
            
            
            
            
            

            
            
            
            
            
            
            

            
            
            
            
            

            
            
            

            
            

            

            

            

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub LoggerSaveMeans()
        Try

            Dim TNow As DateTime = Now

            
            Dim NewMeanFile As Boolean = False
            Dim ET As Long = GetEpochTime()

            For Each Mo As ClassModule In LG.Modules
                If Not Mo.Active Then Continue For
                For Each Ch As ClassChannel In Mo.Channels
                    If Not Ch.Active Then Continue For
                    
                    If ET Mod Ch.MeanInterval = 0 And Ch.MeanDone = False Then
                        
                        NewMeanFile = True
                        
                        Exit For
                    End If
                Next
            Next

            
            If Not NewMeanFile Then Return

            
            ToolStripStatusLabelInfo.Text = String.Format("Salva nuova media...")
            LogMessage2List("Salva nuova media...")
            ClassUtils.LogMessage(String.Format("Salva nuova media..."), eMsgType.Info)

            
            Dim DataFileNameTemp As String = Path.Combine(FilesDataDatPath, LG.DataFileHeader + "-" + Now.ToString("yyyy-MM-dd-HH-mm-00") + ".dat")

            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                For Each Ch As ClassChannel In Mo.Channels

                    If Not Ch.Active Then Continue For

                    
                    Debug.Print(String.Format("ET: {0}, Interval: {1}", ET, Ch.MeanInterval))
                    If ET Mod Ch.MeanInterval = 0 And Ch.MeanDone = False Then

                        
                        Call SaveChannelData(Mo, Ch, DataFileNameTemp)

                        
                        Call SaveChannelDataCsv(Mo, Ch)

                        
                        Call LG.ResetChannel(Ch)

                    End If

                Next

            Next

            
            

            
            Dim Zip As New ClassZip
            
            Zip.ZipFileName = Path.Combine(FilesDataDatPath, LG.DataFileHeader + ".zip")
            If Zip.AddFile(DataFileNameTemp) Then
                
                My.Computer.FileSystem.DeleteFile(DataFileNameTemp)
            Else
                
                ClassUtils.LogMessage("Errore durante la creazione del file Zip !", eMsgType.Errors)
            End If

            
            Call LG.ResetAlarms()

            
            FlagMeanDone = True

            
            FlagPollingGotData = False

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub SaveChannelData(ByVal Mo As ClassModule, ByVal Ch As ClassChannel, ByVal DataFileNameTemp As String)
        Try

            
            
            
            ToolStripStatusLabelInfo.Text = String.Format(String.Format("Nuova media: {0}, Letture {1}, Media {2}", Ch.Name, Ch.Readings, Ch.MeanValue))
            LogMessage2List(String.Format("Nuova media: {0}, Letture {1}, Media {2}", Ch.Name, Ch.Readings, Ch.MeanValue))
            ClassUtils.LogMessage(String.Format("Nuova media: {0}, Letture {1}, Media {2}", Ch.Name, Ch.Readings, Ch.MeanValue), eMsgType.Info)

            Debug.Print(String.Format("Nuova media: {0}, Letture {1}, Media {2}", Ch.Name, Ch.Readings, Ch.MeanValue))

            
            
            
            
            
            
            
            
            
            

            
            
            
            
            
            
            

            
            
            
            
            

            
            

            
            
            
            
            
            
            
            
            
            
            

            
            Dim ExpectedNoReadings As Integer
            Dim CalculatedPercentage As Integer

            ExpectedNoReadings = CInt(Ch.MeanInterval / Mo.PollingInterval)
            CalculatedPercentage = CInt((100 / ExpectedNoReadings) * Ch.Readings)
            Debug.Print(String.Format("VALIDATION 1 - Readings: {0}, ExpectedNoReadings: {1}, CalculatedPercentage: {2}", Ch.Readings, ExpectedNoReadings, CalculatedPercentage))
            If CalculatedPercentage < Ch.ReadingsMinPercentage Then
                Ch.Code = Ch.Code Xor ModuleData.EnumChannelCode.MIN_READING_PERC
            End If

            
            
            
            

            Dim Record As String
            Record = "
            Record += Ch.DatabaseId.ToString + vbTab
            Record += Ch.MeanValue.ToString + vbTab
            Record += Ch.Code.ToString + vbTab
            Record += LG.StationAlarm.ToString + vbTab
            Record += CalculatedPercentage.ToString + vbTab 
            Record += Ch.MinValue.ToString + vbTab

            If Ch.MinTime.HasValue Then
                Record += "
            Else
                Record += "
            End If
            Record += Ch.MaxValue.ToString + vbTab

            If Ch.MaxTime.HasValue Then
                Record += "
            Else
                Record += "
            End If

            If Ch.StdDev.HasValue Then
                If Double.IsNaN(CDbl(Ch.StdDev)) Then
                    Record += "0" + vbCrLf
                Else
                    Record += Ch.StdDev.ToString + vbCrLf
                End If
            Else
                Record += "0" + vbCrLf
            End If

            
            Record = Record.Replace(",", ".")

            
            Record = Record.Replace(vbTab, ",")

            

            
            Dim DataFileName As String = Path.Combine(FilesDataDatPath,
                LG.DataFileHeader + "-" + Now.ToString("yyyy-MM-dd-HH") + ".dat")

            
            My.Computer.FileSystem.WriteAllText(DataFileName, Record, True, System.Text.Encoding.ASCII)
            
            My.Computer.FileSystem.WriteAllText(DataFileNameTemp, Record, True, System.Text.Encoding.ASCII)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub SaveChannelDataCsv(ByVal Mo As ClassModule, ByVal Ch As ClassChannel)
        Try

            
            

            Dim FilePath As String = Path.Combine(FilesDataCsvPath, Now.ToString("yyyyMM"))
            If Not My.Computer.FileSystem.DirectoryExists(FilePath) Then
                My.Computer.FileSystem.CreateDirectory(FilePath)
            End If

            Dim DataFileName As String = Path.Combine(FilePath,
                Mo.Name.Replace(" ", "_") + "-" + Ch.Name.Replace(" ", "_") + "-" + Now.ToString("yyyy-MM-dd") + ".csv")

            Dim CsvLine As New StringBuilder
            CsvLine.Append(Now.AddHours(-1).ToString("dd/MM/yyyy HH:mm:ss") + ";")
            CsvLine.Append(Ch.MeanValue.ToString.Replace(".", ",") + ";")
            CsvLine.Append(Ch.Code.ToString.Replace(".", ","))

            My.Computer.FileSystem.WriteAllText(DataFileName, CsvLine.ToString + vbCrLf, True, System.Text.Encoding.ASCII)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub SaveChannelDataCsv(ByVal Modules As List(Of ClassModule))
        Try

            
            Dim Headers As String() = {"Data & ora"}

            
            Dim Data As String() = {Now.ToString("dd/MM/yyyy HH:mm:ss")}

            For Each M As ClassModule In Modules

                For Each C As ClassChannel In M.Channels

                    
                    ReDim Preserve Headers(Headers.Length)
                    Headers(Headers.Length - 1) = C.FullName

                    
                    ReDim Preserve Data(Data.Length)
                    Data(Data.Length - 1) = C.MeanValue.ToString

                Next

            Next

            
            Dim Csvheader As String
            Csvheader = String.Join(";", Headers).Replace(".", ",")

            
            Dim Csvline As String
            Csvline = String.Join(";", Data).Replace(".", ",")

            
            Dim DataFileName As String = Path.Combine(FilesDataCsvPath,
                LG.DataFileHeader + "-" + Now.ToString("yyyy-MM-dd") + ".csv")

            
            If Not My.Computer.FileSystem.FileExists(DataFileName) Then
                
                My.Computer.FileSystem.WriteAllText(DataFileName, Csvheader.ToString + vbCrLf, True, System.Text.Encoding.ASCII)
            End If
            
            My.Computer.FileSystem.WriteAllText(DataFileName, Csvline.ToString + vbCrLf, True, System.Text.Encoding.ASCII)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub SaveChannelInstCsv(Mo As ClassModule, Ch As ClassChannel)
        Try

            Dim FilePath As String = Path.Combine(FilesInstCsvPath, Now.ToString("yyyyMM"))
            If Not My.Computer.FileSystem.DirectoryExists(FilePath) Then
                My.Computer.FileSystem.CreateDirectory(FilePath)
            End If

            Dim FileName As String = Path.Combine(FilePath,
                Mo.Name.Replace(" ", "_") + "-" + Ch.Name.Replace(" ", "_") + "-" + Now.ToString("yyyy-MM-dd") + ".csv")

            Dim CsvLine As New StringBuilder
            CsvLine.Append(Now.ToString("dd/MM/yyyy HH:mm:ss") + ";")
            CsvLine.Append(Ch.LastValue.ToString.Replace(".", ","))

            My.Computer.FileSystem.WriteAllText(FileName, CsvLine.ToString + vbCrLf, True, System.Text.Encoding.ASCII)

        Catch ex As ArgumentException

            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    
    

    
    

    

    

    

    
    

    
    

    
    
    
    

    Private Sub ResetMeanDoneFlags()
        Try

            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                For Each Ch As ClassChannel In Mo.Channels

                    If Not Ch.Active Then Continue For

                    Ch.MeanDone = False

                Next
            Next

            
            FlagMeanDone = False

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub RefreshGridDataAndDiag()
        Try

            
            
            
            Dim listMain = New List(Of ClassLoggerDisplay)
            Dim listDiag = New List(Of ClassLoggerDisplay)
            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                For Each Ch As ClassChannel In Mo.Channels

                    If Not Ch.Active Then Continue For

                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    

                    If Ch.IsDiagnostic Then
                        listDiag.Add(New ClassLoggerDisplay(
                                     Ch.ID, Mo.Name, String.Format("{0} [{1}]", Mo.ComPortName, Mo.ComPortBauds),
                                     Ch.Name, Ch.Unit, Ch.LastRawValue, Ch.LastValue,
                                     Ch.MeanValue, Ch.MaxValue, Ch.MinValue, Ch.Readings,
                                     Ch.ReadingsWrong, Ch.Code))
                    Else
                        listMain.Add(New ClassLoggerDisplay(
                                     Ch.ID, Mo.Name, String.Format("{0} [{1}]", Mo.ComPortName, Mo.ComPortBauds),
                                     Ch.Name, Ch.Unit, Ch.LastRawValue, Ch.LastValue,
                                     Ch.MeanValue, Ch.MaxValue, Ch.MinValue, Ch.Readings,
                                     Ch.ReadingsWrong, Ch.Code))
                    End If

                Next

            Next

            
            RefreshDataSource(DataGridViewLogger, listMain)

            
            RefreshDataSource(DataGridViewLoggerDiags, listDiag)

            
            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            If FLT IsNot Nothing Then
                FLT.AppendNewData(listMain)
            End If
            If FLC IsNot Nothing Then
                FLC.AppendNewData(listMain)
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub RefreshDataSource(MyDataGridView As DataGridView, MyDataList As List(Of ClassLoggerDisplay))
        Try

            With MyDataGridView

                
                Dim idxRow As Integer = -1
                Dim idxSel As Integer = -1
                If .SelectedRows.Count = 1 Then
                    idxRow = .FirstDisplayedCell.RowIndex
                    idxSel = .SelectedRows(0).Index
                End If

                
                .SuspendLayout()
                .DataSource = MyDataList
                .ResumeLayout()

                
                If idxRow >= 0 Then .FirstDisplayedScrollingRowIndex = idxRow
                If idxSel >= 0 Then .Rows(idxSel).Selected = True

                
                For i As Integer = 0 To .Rows.Count - 1
                    If Not .Rows(i).Cells("ReadingsWrong").Value Is DBNull.Value AndAlso CSng(.Rows(i).Cells("ReadingsWrong").Value) > 0 Then
                        .Rows(i).Cells("ReadingsWrong").Style.BackColor = Color.LemonChiffon
                    Else
                        .Rows(i).Cells("ReadingsWrong").Style.BackColor = Color.White
                    End If
                Next

            End With

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub RefreshGridCommands()
        Try

            FlagRefreshCommands = False

            
            
            
            Dim listC = New List(Of ClassLoggerDisplayCommand)
            Dim i As Integer = 1
            For Each Mo As ClassModule In LG.Modules

                If Not Mo.Active Then Continue For

                For Each ChC As ClassChannelCommand In Mo.ChannelsCommand

                    If Not ChC.Active Then Continue For

                    listC.Add(New ClassLoggerDisplayCommand(i,
                        Mo.ID, Mo.Name, ChC.ID, ChC.Name, ChC.Command, ChC.Value,
                        ChC.DateTime, ChC.Repeat, ChC.CommandSent))
                    
                    
                    
                    i += 1

                Next

            Next

            
            With DataGridViewCommand
                .SuspendLayout()
                .DataSource = listC
                .ResumeLayout()
            End With

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Function GetEpochTime() As Long
        Dim dtCurTime As DateTime = DateTime.Now
        Dim dtEpochStartTime As DateTime = Convert.ToDateTime("1/1/1970 00:00:00 AM")
        Dim ts As TimeSpan = dtCurTime.Subtract(dtEpochStartTime)

        Dim epochtime As Long
        epochtime = ((((((ts.Days * 24) + ts.Hours) * 60) + ts.Minutes) * 60) + ts.Seconds)
        Return epochtime
    End Function

    Private Function getStandardDeviation(doubleList As List(Of Nullable(Of Single))) As Nullable(Of Single)
        Try
            If doubleList.Count = 0 Then Return Nothing

            Dim sumOfValue As Single = 0
            For Each value As Single In doubleList
                sumOfValue += value
            Next
            Dim average As Single = sumOfValue / (doubleList.Count)

            Dim sumOfDerivation As Single = 0
            For Each value As Single In doubleList
                sumOfDerivation += (value) * (value)
            Next
            Dim sumOfDerivationAverage As Single = sumOfDerivation / (doubleList.Count)
            Dim StdDev As Single = CSng(Math.Sqrt(sumOfDerivationAverage - (average * average)))
            Dim Res As Nullable(Of Single) = CType(StdDev, Single?)

            If Res.HasValue Then
                Return Res
            Else
                Return 0
            End If
        Catch ex As ArgumentException
            Return Nothing
        End Try
    End Function
    
    
    
    
    
    

    
    

    
    
    
    
    

    Private Sub DumpLogger()
        Try

            For Each Mo As ClassModule In LG.Modules

                For Each Ch As ClassChannel In Mo.Channels
                    Debug.Print(String.Format("Module : {0}, Channel : {1}", Mo.Name, Ch.Name))
                Next

                For Each ChC As ClassChannelCommand In Mo.ChannelsCommand
                    Debug.Print(String.Format("Module : {0}, Channel : {1}", Mo.Name, ChC.Name))
                Next

            Next

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Sub LogMessage2List(ByVal Message As String)
        If FE IsNot Nothing Then FE.LogMessage(Message)
    End Sub

#End Region

#Region "Grid format"
    
    
    
    
    Private Sub ColumnHeaderSetFormat(ByVal dgw As DataGridView)
        Try

            
            
            
            For Each col As DataGridViewColumn In dgw.Columns

                col.HeaderText = col.HeaderText.Replace(" ", vbCrLf)
                col.DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter

                
                
                
                
                

            Next

            
            

            
            

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

#End Region

End Class
