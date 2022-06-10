<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormMDI
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormMDI))
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.FileToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemShowEvents = New System.Windows.Forms.ToolStripMenuItem()
        Me.VisualizzaDatiToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.VisualizzaGraficiToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripMenuItemShowLoggerExplorer = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator4 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripMenuItemExit = New System.Windows.Forms.ToolStripMenuItem()
        Me.WindowsMenu = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemWindowsDefault = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator3 = New System.Windows.Forms.ToolStripSeparator()
        Me.CascadeToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TileVerticalToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TileHorizontalToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemAbout = New System.Windows.Forms.ToolStripMenuItem()
        Me.StatusStripMain = New System.Windows.Forms.StatusStrip()
        Me.ToolStripStatusLabelInfo = New System.Windows.Forms.ToolStripStatusLabel()
        Me.ToolStripStatusLabelConfig = New System.Windows.Forms.ToolStripStatusLabel()
        Me.ToolStripStatusLabelTimer = New System.Windows.Forms.ToolStripStatusLabel()
        Me.TimerTime = New System.Windows.Forms.Timer(Me.components)
        Me.ToolStripMain = New System.Windows.Forms.ToolStrip()
        Me.ToolStripButtonWindowsDefault = New System.Windows.Forms.ToolStripButton()
        Me.ToolStripSeparator2 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripButtonShowCharts = New System.Windows.Forms.ToolStripButton()
        Me.MenuStrip1.SuspendLayout()
        Me.StatusStripMain.SuspendLayout()
        Me.ToolStripMain.SuspendLayout()
        Me.SuspendLayout()
        
        
        
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.FileToolStripMenuItem, Me.WindowsMenu, Me.ToolStripMenuItem1})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(681, 24)
        Me.MenuStrip1.TabIndex = 9
        Me.MenuStrip1.Text = "MenuStrip1"
        
        
        
        Me.FileToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripMenuItemShowEvents, Me.VisualizzaDatiToolStripMenuItem, Me.VisualizzaGraficiToolStripMenuItem, Me.ToolStripSeparator1, Me.ToolStripMenuItemShowLoggerExplorer, Me.ToolStripSeparator4, Me.ToolStripMenuItemExit})
        Me.FileToolStripMenuItem.Name = "FileToolStripMenuItem"
        Me.FileToolStripMenuItem.Size = New System.Drawing.Size(37, 20)
        Me.FileToolStripMenuItem.Text = "&File"
        
        
        
        Me.ToolStripMenuItemShowEvents.Image = Global.Ecometer.My.Resources.Resources.log1
        Me.ToolStripMenuItemShowEvents.Name = "ToolStripMenuItemShowEvents"
        Me.ToolStripMenuItemShowEvents.Size = New System.Drawing.Size(169, 22)
        Me.ToolStripMenuItemShowEvents.Text = "Visualizza eventi"
        
        
        
        Me.VisualizzaDatiToolStripMenuItem.Image = Global.Ecometer.My.Resources.Resources.spreadsheet7
        Me.VisualizzaDatiToolStripMenuItem.Name = "VisualizzaDatiToolStripMenuItem"
        Me.VisualizzaDatiToolStripMenuItem.Size = New System.Drawing.Size(169, 22)
        Me.VisualizzaDatiToolStripMenuItem.Text = "Visualizza dati"
        
        
        
        Me.VisualizzaGraficiToolStripMenuItem.Image = Global.Ecometer.My.Resources.Resources.education20
        Me.VisualizzaGraficiToolStripMenuItem.Name = "VisualizzaGraficiToolStripMenuItem"
        Me.VisualizzaGraficiToolStripMenuItem.Size = New System.Drawing.Size(169, 22)
        Me.VisualizzaGraficiToolStripMenuItem.Text = "Visualizza grafici"
        
        
        
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(166, 6)
        
        
        
        Me.ToolStripMenuItemShowLoggerExplorer.Image = Global.Ecometer.My.Resources.Resources.internet6
        Me.ToolStripMenuItemShowLoggerExplorer.Name = "ToolStripMenuItemShowLoggerExplorer"
        Me.ToolStripMenuItemShowLoggerExplorer.Size = New System.Drawing.Size(169, 22)
        Me.ToolStripMenuItemShowLoggerExplorer.Text = "Visualizza explorer"
        
        
        
        Me.ToolStripSeparator4.Name = "ToolStripSeparator4"
        Me.ToolStripSeparator4.Size = New System.Drawing.Size(166, 6)
        
        
        
        Me.ToolStripMenuItemExit.Image = Global.Ecometer.My.Resources.Resources.door9
        Me.ToolStripMenuItemExit.Name = "ToolStripMenuItemExit"
        Me.ToolStripMenuItemExit.Size = New System.Drawing.Size(169, 22)
        Me.ToolStripMenuItemExit.Text = "&Esci"
        
        
        
        Me.WindowsMenu.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripMenuItemWindowsDefault, Me.ToolStripSeparator3, Me.CascadeToolStripMenuItem, Me.TileVerticalToolStripMenuItem, Me.TileHorizontalToolStripMenuItem})
        Me.WindowsMenu.Name = "WindowsMenu"
        Me.WindowsMenu.Size = New System.Drawing.Size(60, 20)
        Me.WindowsMenu.Text = "&Finestre"
        
        
        
        Me.ToolStripMenuItemWindowsDefault.Image = Global.Ecometer.My.Resources.Resources.arrange1
        Me.ToolStripMenuItemWindowsDefault.Name = "ToolStripMenuItemWindowsDefault"
        Me.ToolStripMenuItemWindowsDefault.Size = New System.Drawing.Size(206, 22)
        Me.ToolStripMenuItemWindowsDefault.Text = "&Disponi finestre"
        Me.ToolStripMenuItemWindowsDefault.ToolTipText = "Dispone le finestre in modo automatico"
        
        
        
        Me.ToolStripSeparator3.Name = "ToolStripSeparator3"
        Me.ToolStripSeparator3.Size = New System.Drawing.Size(203, 6)
        
        
        
        Me.CascadeToolStripMenuItem.Name = "CascadeToolStripMenuItem"
        Me.CascadeToolStripMenuItem.Size = New System.Drawing.Size(206, 22)
        Me.CascadeToolStripMenuItem.Text = "&Sovrapponi"
        
        
        
        Me.TileVerticalToolStripMenuItem.Name = "TileVerticalToolStripMenuItem"
        Me.TileVerticalToolStripMenuItem.Size = New System.Drawing.Size(206, 22)
        Me.TileVerticalToolStripMenuItem.Text = "Affianca &verticalmente"
        
        
        
        Me.TileHorizontalToolStripMenuItem.Name = "TileHorizontalToolStripMenuItem"
        Me.TileHorizontalToolStripMenuItem.Size = New System.Drawing.Size(206, 22)
        Me.TileHorizontalToolStripMenuItem.Text = "Affianca &orizzontalmente"
        
        
        
        Me.ToolStripMenuItem1.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripMenuItemAbout})
        Me.ToolStripMenuItem1.Name = "ToolStripMenuItem1"
        Me.ToolStripMenuItem1.Size = New System.Drawing.Size(24, 20)
        Me.ToolStripMenuItem1.Text = "&?"
        
        
        
        Me.ToolStripMenuItemAbout.Name = "ToolStripMenuItemAbout"
        Me.ToolStripMenuItemAbout.Size = New System.Drawing.Size(153, 22)
        Me.ToolStripMenuItemAbout.Text = "&Informazioni ..."
        
        
        
        Me.StatusStripMain.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripStatusLabelInfo, Me.ToolStripStatusLabelConfig, Me.ToolStripStatusLabelTimer})
        Me.StatusStripMain.Location = New System.Drawing.Point(0, 412)
        Me.StatusStripMain.Name = "StatusStripMain"
        Me.StatusStripMain.Size = New System.Drawing.Size(681, 22)
        Me.StatusStripMain.TabIndex = 10
        Me.StatusStripMain.Text = "StatusStripMain"
        
        
        
        Me.ToolStripStatusLabelInfo.Image = Global.Ecometer.My.Resources.Resources.info31
        Me.ToolStripStatusLabelInfo.Name = "ToolStripStatusLabelInfo"
        Me.ToolStripStatusLabelInfo.Size = New System.Drawing.Size(151, 17)
        Me.ToolStripStatusLabelInfo.Text = "ToolStripStatusLabelInfo"
        Me.ToolStripStatusLabelInfo.ToolTipText = "Informazione Logger"
        
        
        
        Me.ToolStripStatusLabelConfig.Image = Global.Ecometer.My.Resources.Resources.document114
        Me.ToolStripStatusLabelConfig.Name = "ToolStripStatusLabelConfig"
        Me.ToolStripStatusLabelConfig.Size = New System.Drawing.Size(166, 17)
        Me.ToolStripStatusLabelConfig.Text = "ToolStripStatusLabelConfig"
        Me.ToolStripStatusLabelConfig.ToolTipText = "File di configurazione in uso"
        
        
        
        Me.ToolStripStatusLabelTimer.Image = CType(resources.GetObject("ToolStripStatusLabelTimer.Image"), System.Drawing.Image)
        Me.ToolStripStatusLabelTimer.ImageAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.ToolStripStatusLabelTimer.Name = "ToolStripStatusLabelTimer"
        Me.ToolStripStatusLabelTimer.Size = New System.Drawing.Size(349, 17)
        Me.ToolStripStatusLabelTimer.Spring = True
        Me.ToolStripStatusLabelTimer.Text = "ToolStripStatusLabelTimer"
        Me.ToolStripStatusLabelTimer.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.ToolStripStatusLabelTimer.ToolTipText = "Data & ora"
        
        
        
        Me.TimerTime.Interval = 1000
        
        
        
        Me.ToolStripMain.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripButtonWindowsDefault, Me.ToolStripSeparator2, Me.ToolStripButtonShowCharts})
        Me.ToolStripMain.Location = New System.Drawing.Point(0, 24)
        Me.ToolStripMain.Name = "ToolStripMain"
        Me.ToolStripMain.Size = New System.Drawing.Size(681, 25)
        Me.ToolStripMain.TabIndex = 12
        Me.ToolStripMain.Text = "ToolStrip1"
        
        
        
        Me.ToolStripButtonWindowsDefault.Image = Global.Ecometer.My.Resources.Resources.arrange1
        Me.ToolStripButtonWindowsDefault.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonWindowsDefault.Name = "ToolStripButtonWindowsDefault"
        Me.ToolStripButtonWindowsDefault.Size = New System.Drawing.Size(104, 22)
        Me.ToolStripButtonWindowsDefault.Text = "Diponi finestre"
        Me.ToolStripButtonWindowsDefault.ToolTipText = "Dispone le finestre in modo automatico"
        
        
        
        Me.ToolStripSeparator2.Name = "ToolStripSeparator2"
        Me.ToolStripSeparator2.Size = New System.Drawing.Size(6, 25)
        
        
        
        Me.ToolStripButtonShowCharts.Image = Global.Ecometer.My.Resources.Resources.education20
        Me.ToolStripButtonShowCharts.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonShowCharts.Name = "ToolStripButtonShowCharts"
        Me.ToolStripButtonShowCharts.Size = New System.Drawing.Size(113, 22)
        Me.ToolStripButtonShowCharts.Text = "Visualizza grafici"
        
        
        
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(681, 434)
        Me.Controls.Add(Me.ToolStripMain)
        Me.Controls.Add(Me.StatusStripMain)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.IsMdiContainer = True
        Me.Name = "FormMDI"
        Me.Text = "FormMDI"
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.StatusStripMain.ResumeLayout(False)
        Me.StatusStripMain.PerformLayout()
        Me.ToolStripMain.ResumeLayout(False)
        Me.ToolStripMain.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents FileToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemExit As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents WindowsMenu As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents CascadeToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TileVerticalToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TileHorizontalToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemAbout As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents StatusStripMain As System.Windows.Forms.StatusStrip
    Friend WithEvents ToolStripStatusLabelTimer As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents TimerTime As System.Windows.Forms.Timer
    Friend WithEvents ToolStripStatusLabelInfo As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents ToolStripMenuItemShowEvents As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents ToolStripMenuItemShowLoggerExplorer As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripStatusLabelConfig As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents VisualizzaDatiToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents VisualizzaGraficiToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemWindowsDefault As ToolStripMenuItem
    Friend WithEvents ToolStripSeparator3 As ToolStripSeparator
    Friend WithEvents ToolStripSeparator4 As ToolStripSeparator
    Friend WithEvents ToolStripMain As ToolStrip
    Friend WithEvents ToolStripButtonWindowsDefault As ToolStripButton
    Friend WithEvents ToolStripSeparator2 As ToolStripSeparator
    Friend WithEvents ToolStripButtonShowCharts As ToolStripButton
End Class
