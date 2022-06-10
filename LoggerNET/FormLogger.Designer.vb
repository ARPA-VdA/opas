<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormLogger
    Inherits System.Windows.Forms.Form

    
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    
    Private components As System.ComponentModel.IContainer

    
    
    
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormLogger))
        Me.DataGridViewLogger = New System.Windows.Forms.DataGridView()
        Me.StatusStripMain = New System.Windows.Forms.StatusStrip()
        Me.ToolStripStatusLabelInfo = New System.Windows.Forms.ToolStripStatusLabel()
        Me.ToolStripStatusLabelLatestPolling = New System.Windows.Forms.ToolStripStatusLabel()
        Me.SerialPort = New System.IO.Ports.SerialPort(Me.components)
        Me.TimerPolling = New System.Windows.Forms.Timer(Me.components)
        Me.TimerMean = New System.Windows.Forms.Timer(Me.components)
        Me.BackgroundWorker = New System.ComponentModel.BackgroundWorker()
        Me.TabControlLogger = New System.Windows.Forms.TabControl()
        Me.TabPageMainChannels = New System.Windows.Forms.TabPage()
        Me.TabPageDiagChannels = New System.Windows.Forms.TabPage()
        Me.DataGridViewLoggerDiags = New System.Windows.Forms.DataGridView()
        Me.TabPageCalibrations = New System.Windows.Forms.TabPage()
        Me.DataGridViewCommand = New System.Windows.Forms.DataGridView()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.AcquisizioneToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemStatus = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemStatusInfo = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemStateSave = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemStatusLoad = New System.Windows.Forms.ToolStripMenuItem()
        CType(Me.DataGridViewLogger, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.StatusStripMain.SuspendLayout()
        Me.TabControlLogger.SuspendLayout()
        Me.TabPageMainChannels.SuspendLayout()
        Me.TabPageDiagChannels.SuspendLayout()
        CType(Me.DataGridViewLoggerDiags, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TabPageCalibrations.SuspendLayout()
        CType(Me.DataGridViewCommand, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.MenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        
        
        
        Me.DataGridViewLogger.AllowUserToOrderColumns = True
        Me.DataGridViewLogger.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridViewLogger.Location = New System.Drawing.Point(6, 6)
        Me.DataGridViewLogger.Name = "DataGridViewLogger"
        Me.DataGridViewLogger.Size = New System.Drawing.Size(149, 90)
        Me.DataGridViewLogger.TabIndex = 0
        
        
        
        Me.StatusStripMain.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripStatusLabelLatestPolling, Me.ToolStripStatusLabelInfo})
        Me.StatusStripMain.Location = New System.Drawing.Point(0, 476)
        Me.StatusStripMain.Name = "StatusStripMain"
        Me.StatusStripMain.Size = New System.Drawing.Size(804, 22)
        Me.StatusStripMain.TabIndex = 1
        Me.StatusStripMain.Text = "StatusStrip1"
        
        
        
        Me.ToolStripStatusLabelInfo.Image = Global.Ecometer.My.Resources.Resources.info31
        Me.ToolStripStatusLabelInfo.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.ToolStripStatusLabelInfo.Name = "ToolStripStatusLabelInfo"
        Me.ToolStripStatusLabelInfo.Size = New System.Drawing.Size(560, 17)
        Me.ToolStripStatusLabelInfo.Spring = True
        Me.ToolStripStatusLabelInfo.Text = "ToolStripStatusLabelInfo"
        Me.ToolStripStatusLabelInfo.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        
        
        
        Me.ToolStripStatusLabelLatestPolling.Image = Global.Ecometer.My.Resources.Resources.synchronization3
        Me.ToolStripStatusLabelLatestPolling.Name = "ToolStripStatusLabelLatestPolling"
        Me.ToolStripStatusLabelLatestPolling.Size = New System.Drawing.Size(198, 17)
        Me.ToolStripStatusLabelLatestPolling.Text = "ToolStripStatusLabelLatestPolling"
        
        
        
        
        
        
        
        
        
        Me.BackgroundWorker.WorkerSupportsCancellation = True
        
        
        
        Me.TabControlLogger.Controls.Add(Me.TabPageMainChannels)
        Me.TabControlLogger.Controls.Add(Me.TabPageDiagChannels)
        Me.TabControlLogger.Controls.Add(Me.TabPageCalibrations)
        Me.TabControlLogger.Location = New System.Drawing.Point(12, 42)
        Me.TabControlLogger.Name = "TabControlLogger"
        Me.TabControlLogger.SelectedIndex = 0
        Me.TabControlLogger.Size = New System.Drawing.Size(601, 236)
        Me.TabControlLogger.TabIndex = 3
        
        
        
        Me.TabPageMainChannels.Controls.Add(Me.DataGridViewLogger)
        Me.TabPageMainChannels.Location = New System.Drawing.Point(4, 22)
        Me.TabPageMainChannels.Name = "TabPageMainChannels"
        Me.TabPageMainChannels.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPageMainChannels.Size = New System.Drawing.Size(593, 210)
        Me.TabPageMainChannels.TabIndex = 0
        Me.TabPageMainChannels.Text = "Principali"
        Me.TabPageMainChannels.UseVisualStyleBackColor = True
        
        
        
        Me.TabPageDiagChannels.Controls.Add(Me.DataGridViewLoggerDiags)
        Me.TabPageDiagChannels.Location = New System.Drawing.Point(4, 22)
        Me.TabPageDiagChannels.Name = "TabPageDiagChannels"
        Me.TabPageDiagChannels.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPageDiagChannels.Size = New System.Drawing.Size(593, 210)
        Me.TabPageDiagChannels.TabIndex = 2
        Me.TabPageDiagChannels.Text = "Diagnostici"
        Me.TabPageDiagChannels.UseVisualStyleBackColor = True
        
        
        
        Me.DataGridViewLoggerDiags.AllowUserToOrderColumns = True
        Me.DataGridViewLoggerDiags.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridViewLoggerDiags.Location = New System.Drawing.Point(6, 6)
        Me.DataGridViewLoggerDiags.Name = "DataGridViewLoggerDiags"
        Me.DataGridViewLoggerDiags.Size = New System.Drawing.Size(149, 90)
        Me.DataGridViewLoggerDiags.TabIndex = 2
        
        
        
        Me.TabPageCalibrations.Controls.Add(Me.DataGridViewCommand)
        Me.TabPageCalibrations.Location = New System.Drawing.Point(4, 22)
        Me.TabPageCalibrations.Name = "TabPageCalibrations"
        Me.TabPageCalibrations.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPageCalibrations.Size = New System.Drawing.Size(593, 210)
        Me.TabPageCalibrations.TabIndex = 1
        Me.TabPageCalibrations.Text = "Calibrazioni"
        Me.TabPageCalibrations.UseVisualStyleBackColor = True
        
        
        
        Me.DataGridViewCommand.AllowUserToOrderColumns = True
        Me.DataGridViewCommand.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridViewCommand.Location = New System.Drawing.Point(6, 6)
        Me.DataGridViewCommand.Name = "DataGridViewCommand"
        Me.DataGridViewCommand.Size = New System.Drawing.Size(149, 90)
        Me.DataGridViewCommand.TabIndex = 2
        
        
        
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.AcquisizioneToolStripMenuItem, Me.ToolStripMenuItemStatusInfo})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(804, 24)
        Me.MenuStrip1.TabIndex = 4
        Me.MenuStrip1.Text = "MenuStrip1"
        
        
        
        Me.AcquisizioneToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripMenuItemStatus})
        Me.AcquisizioneToolStripMenuItem.Name = "AcquisizioneToolStripMenuItem"
        Me.AcquisizioneToolStripMenuItem.Size = New System.Drawing.Size(86, 20)
        Me.AcquisizioneToolStripMenuItem.Text = "&Acquisizione"
        
        
        
        Me.ToolStripMenuItemStatus.Checked = True
        Me.ToolStripMenuItemStatus.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ToolStripMenuItemStatus.Image = Global.Ecometer.My.Resources.Resources.play133
        Me.ToolStripMenuItemStatus.Name = "ToolStripMenuItemStatus"
        Me.ToolStripMenuItemStatus.Size = New System.Drawing.Size(152, 22)
        Me.ToolStripMenuItemStatus.Text = "Polling attivo"
        Me.ToolStripMenuItemStatus.ToolTipText = "Attiva o disattiva il polling automatico e chiude le port seriali"
        
        
        
        Me.ToolStripMenuItemStatusInfo.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripMenuItemStateSave, Me.ToolStripMenuItemStatusLoad})
        Me.ToolStripMenuItemStatusInfo.Name = "ToolStripMenuItemStatusInfo"
        Me.ToolStripMenuItemStatusInfo.Size = New System.Drawing.Size(46, 20)
        Me.ToolStripMenuItemStatusInfo.Text = "&Stato"
        
        
        
        Me.ToolStripMenuItemStateSave.Name = "ToolStripMenuItemStateSave"
        Me.ToolStripMenuItemStateSave.Size = New System.Drawing.Size(152, 22)
        Me.ToolStripMenuItemStateSave.Text = "&Salva"
        
        
        
        Me.ToolStripMenuItemStatusLoad.Name = "ToolStripMenuItemStatusLoad"
        Me.ToolStripMenuItemStatusLoad.Size = New System.Drawing.Size(152, 22)
        Me.ToolStripMenuItemStatusLoad.Text = "&Carica"
        
        
        
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(804, 498)
        Me.Controls.Add(Me.TabControlLogger)
        Me.Controls.Add(Me.StatusStripMain)
        Me.Controls.Add(Me.MenuStrip1)
        Me.DoubleBuffered = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "FormLogger"
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "FormLogger"
        CType(Me.DataGridViewLogger, System.ComponentModel.ISupportInitialize).EndInit()
        Me.StatusStripMain.ResumeLayout(False)
        Me.StatusStripMain.PerformLayout()
        Me.TabControlLogger.ResumeLayout(False)
        Me.TabPageMainChannels.ResumeLayout(False)
        Me.TabPageDiagChannels.ResumeLayout(False)
        CType(Me.DataGridViewLoggerDiags, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TabPageCalibrations.ResumeLayout(False)
        CType(Me.DataGridViewCommand, System.ComponentModel.ISupportInitialize).EndInit()
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents DataGridViewLogger As System.Windows.Forms.DataGridView
    Friend WithEvents StatusStripMain As System.Windows.Forms.StatusStrip
    Friend WithEvents ToolStripStatusLabelInfo As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents SerialPort As System.IO.Ports.SerialPort
    Friend WithEvents TimerPolling As System.Windows.Forms.Timer
    Friend WithEvents TimerMean As System.Windows.Forms.Timer
    Friend WithEvents BackgroundWorker As System.ComponentModel.BackgroundWorker
    Friend WithEvents TabControlLogger As System.Windows.Forms.TabControl
    Friend WithEvents TabPageMainChannels As System.Windows.Forms.TabPage
    Friend WithEvents TabPageCalibrations As System.Windows.Forms.TabPage
    Friend WithEvents TabPageDiagChannels As System.Windows.Forms.TabPage
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents AcquisizioneToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemStatus As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripStatusLabelLatestPolling As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents DataGridViewLoggerDiags As DataGridView
    Friend WithEvents DataGridViewCommand As DataGridView
    Friend WithEvents ToolStripMenuItemStatusInfo As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemStateSave As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemStatusLoad As ToolStripMenuItem

    
    
    Protected Overrides ReadOnly Property CreateParams() As CreateParams
        Get
            Dim cp As CreateParams = MyBase.CreateParams
            Const CS_NOCLOSE As Integer = &H200
            cp.ClassStyle = cp.ClassStyle Or CS_NOCLOSE
            Return cp
        End Get
    End Property

End Class
