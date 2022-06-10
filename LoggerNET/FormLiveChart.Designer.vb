<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormLiveChart
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
        Dim ChartArea1 As System.Windows.Forms.DataVisualization.Charting.ChartArea = New System.Windows.Forms.DataVisualization.Charting.ChartArea()
        Dim Legend1 As System.Windows.Forms.DataVisualization.Charting.Legend = New System.Windows.Forms.DataVisualization.Charting.Legend()
        Dim Series1 As System.Windows.Forms.DataVisualization.Charting.Series = New System.Windows.Forms.DataVisualization.Charting.Series()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormLiveChart))
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.CheckedListBoxParameters = New System.Windows.Forms.CheckedListBox()
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip()
        Me.ToolStripButtonRun = New System.Windows.Forms.ToolStripButton()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripButtonClearChart = New System.Windows.Forms.ToolStripButton()
        Me.ToolStripSeparator3 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripButtonAutoScale = New System.Windows.Forms.ToolStripButton()
        Me.ToolStripButtonMultiArea = New System.Windows.Forms.ToolStripButton()
        Me.ToolStripSeparator2 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripSplitButtonSpans = New System.Windows.Forms.ToolStripSplitButton()
        Me.ToolStripMenuItemMinutes5 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemMinutes10 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemMinutes15 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemMinutes20 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemMinutes30 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemHours1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemHours2 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItemHours3 = New System.Windows.Forms.ToolStripMenuItem()
        Me.Chart = New System.Windows.Forms.DataVisualization.Charting.Chart()
        Me.GroupBox1.SuspendLayout()
        Me.ToolStrip1.SuspendLayout()
        CType(Me.Chart, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        
        
        
        Me.GroupBox1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.GroupBox1.Controls.Add(Me.CheckedListBoxParameters)
        Me.GroupBox1.Location = New System.Drawing.Point(12, 27)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(712, 131)
        Me.GroupBox1.TabIndex = 4
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Parametri disponibili"
        
        
        
        Me.CheckedListBoxParameters.CheckOnClick = True
        Me.CheckedListBoxParameters.Dock = System.Windows.Forms.DockStyle.Fill
        Me.CheckedListBoxParameters.FormattingEnabled = True
        Me.CheckedListBoxParameters.Location = New System.Drawing.Point(3, 16)
        Me.CheckedListBoxParameters.Name = "CheckedListBoxParameters"
        Me.CheckedListBoxParameters.Size = New System.Drawing.Size(706, 112)
        Me.CheckedListBoxParameters.TabIndex = 0
        
        
        
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripButtonRun, Me.ToolStripSeparator1, Me.ToolStripButtonClearChart, Me.ToolStripSeparator3, Me.ToolStripButtonAutoScale, Me.ToolStripButtonMultiArea, Me.ToolStripSeparator2, Me.ToolStripSplitButtonSpans})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(736, 25)
        Me.ToolStrip1.TabIndex = 5
        Me.ToolStrip1.Text = "ToolStrip1"
        
        
        
        Me.ToolStripButtonRun.Checked = True
        Me.ToolStripButtonRun.CheckOnClick = True
        Me.ToolStripButtonRun.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ToolStripButtonRun.Image = Global.Ecometer.My.Resources.Resources.runer
        Me.ToolStripButtonRun.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonRun.Name = "ToolStripButtonRun"
        Me.ToolStripButtonRun.Size = New System.Drawing.Size(59, 22)
        Me.ToolStripButtonRun.Text = "Attivo"
        Me.ToolStripButtonRun.ToolTipText = "Attiva disattiva aggiornamento"
        
        
        
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(6, 25)
        
        
        
        Me.ToolStripButtonClearChart.Image = Global.Ecometer.My.Resources.Resources.clean11
        Me.ToolStripButtonClearChart.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonClearChart.Name = "ToolStripButtonClearChart"
        Me.ToolStripButtonClearChart.Size = New System.Drawing.Size(103, 22)
        Me.ToolStripButtonClearChart.Text = "Svuota grafico"
        Me.ToolStripButtonClearChart.ToolTipText = "Pulisce grafico"
        
        
        
        Me.ToolStripSeparator3.Name = "ToolStripSeparator3"
        Me.ToolStripSeparator3.Size = New System.Drawing.Size(6, 25)
        
        
        
        Me.ToolStripButtonAutoScale.CheckOnClick = True
        Me.ToolStripButtonAutoScale.Image = Global.Ecometer.My.Resources.Resources.arrow84
        Me.ToolStripButtonAutoScale.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonAutoScale.Name = "ToolStripButtonAutoScale"
        Me.ToolStripButtonAutoScale.Size = New System.Drawing.Size(81, 22)
        Me.ToolStripButtonAutoScale.Text = "Scala auto"
        Me.ToolStripButtonAutoScale.ToolTipText = "Imposta scala automatica asse Y"
        
        
        
        Me.ToolStripButtonMultiArea.CheckOnClick = True
        Me.ToolStripButtonMultiArea.Image = Global.Ecometer.My.Resources.Resources.educational15
        Me.ToolStripButtonMultiArea.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonMultiArea.Name = "ToolStripButtonMultiArea"
        Me.ToolStripButtonMultiArea.Size = New System.Drawing.Size(80, 22)
        Me.ToolStripButtonMultiArea.Text = "Multi area"
        Me.ToolStripButtonMultiArea.ToolTipText = "Crea i grafici su più aree"
        
        
        
        Me.ToolStripSeparator2.Name = "ToolStripSeparator2"
        Me.ToolStripSeparator2.Size = New System.Drawing.Size(6, 25)
        
        
        
        Me.ToolStripSplitButtonSpans.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripMenuItemMinutes5, Me.ToolStripMenuItemMinutes10, Me.ToolStripMenuItemMinutes15, Me.ToolStripMenuItemMinutes20, Me.ToolStripMenuItemMinutes30, Me.ToolStripMenuItemHours1, Me.ToolStripMenuItemHours2, Me.ToolStripMenuItemHours3})
        Me.ToolStripSplitButtonSpans.Image = Global.Ecometer.My.Resources.Resources.clock104
        Me.ToolStripSplitButtonSpans.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripSplitButtonSpans.Name = "ToolStripSplitButtonSpans"
        Me.ToolStripSplitButtonSpans.Size = New System.Drawing.Size(137, 22)
        Me.ToolStripSplitButtonSpans.Text = "Finestra temporale"
        
        
        
        Me.ToolStripMenuItemMinutes5.Checked = True
        Me.ToolStripMenuItemMinutes5.CheckOnClick = True
        Me.ToolStripMenuItemMinutes5.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ToolStripMenuItemMinutes5.Name = "ToolStripMenuItemMinutes5"
        Me.ToolStripMenuItemMinutes5.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemMinutes5.Tag = "300"
        Me.ToolStripMenuItemMinutes5.Text = "5 Minuti"
        
        
        
        Me.ToolStripMenuItemMinutes10.CheckOnClick = True
        Me.ToolStripMenuItemMinutes10.Name = "ToolStripMenuItemMinutes10"
        Me.ToolStripMenuItemMinutes10.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemMinutes10.Tag = "600"
        Me.ToolStripMenuItemMinutes10.Text = "10 Minuti"
        
        
        
        Me.ToolStripMenuItemMinutes15.CheckOnClick = True
        Me.ToolStripMenuItemMinutes15.Name = "ToolStripMenuItemMinutes15"
        Me.ToolStripMenuItemMinutes15.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemMinutes15.Tag = "900"
        Me.ToolStripMenuItemMinutes15.Text = "15 Minuti"
        
        
        
        Me.ToolStripMenuItemMinutes20.CheckOnClick = True
        Me.ToolStripMenuItemMinutes20.Name = "ToolStripMenuItemMinutes20"
        Me.ToolStripMenuItemMinutes20.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemMinutes20.Tag = "1200"
        Me.ToolStripMenuItemMinutes20.Text = "20 Minuti"
        
        
        
        Me.ToolStripMenuItemMinutes30.CheckOnClick = True
        Me.ToolStripMenuItemMinutes30.Name = "ToolStripMenuItemMinutes30"
        Me.ToolStripMenuItemMinutes30.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemMinutes30.Tag = "1800"
        Me.ToolStripMenuItemMinutes30.Text = "30 Minuti"
        
        
        
        Me.ToolStripMenuItemHours1.CheckOnClick = True
        Me.ToolStripMenuItemHours1.Name = "ToolStripMenuItemHours1"
        Me.ToolStripMenuItemHours1.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemHours1.Tag = "3600"
        Me.ToolStripMenuItemHours1.Text = "1 Ora"
        
        
        
        Me.ToolStripMenuItemHours2.CheckOnClick = True
        Me.ToolStripMenuItemHours2.Name = "ToolStripMenuItemHours2"
        Me.ToolStripMenuItemHours2.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemHours2.Tag = "7200"
        Me.ToolStripMenuItemHours2.Text = "2 Ore"
        
        
        
        Me.ToolStripMenuItemHours3.CheckOnClick = True
        Me.ToolStripMenuItemHours3.Name = "ToolStripMenuItemHours3"
        Me.ToolStripMenuItemHours3.Size = New System.Drawing.Size(124, 22)
        Me.ToolStripMenuItemHours3.Tag = "10800"
        Me.ToolStripMenuItemHours3.Text = "3 Ore"
        
        
        
        Me.Chart.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        ChartArea1.Name = "ChartArea1"
        Me.Chart.ChartAreas.Add(ChartArea1)
        Legend1.Name = "Legend1"
        Me.Chart.Legends.Add(Legend1)
        Me.Chart.Location = New System.Drawing.Point(15, 161)
        Me.Chart.Name = "Chart"
        Series1.ChartArea = "ChartArea1"
        Series1.Legend = "Legend1"
        Series1.Name = "Series1"
        Me.Chart.Series.Add(Series1)
        Me.Chart.Size = New System.Drawing.Size(706, 286)
        Me.Chart.TabIndex = 6
        Me.Chart.Text = "Chart"
        
        
        
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(736, 447)
        Me.Controls.Add(Me.Chart)
        Me.Controls.Add(Me.ToolStrip1)
        Me.Controls.Add(Me.GroupBox1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "FormLiveChart"
        Me.Text = "FormLiveChart"
        Me.GroupBox1.ResumeLayout(False)
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        CType(Me.Chart, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents GroupBox1 As GroupBox
    Friend WithEvents CheckedListBoxParameters As CheckedListBox
    Friend WithEvents ToolStrip1 As ToolStrip
    Friend WithEvents ToolStripButtonRun As ToolStripButton
    Friend WithEvents Chart As DataVisualization.Charting.Chart
    Friend WithEvents ToolStripButtonMultiArea As ToolStripButton
    Friend WithEvents ToolStripSeparator1 As ToolStripSeparator
    Friend WithEvents ToolStripSeparator2 As ToolStripSeparator
    Friend WithEvents ToolStripSplitButtonSpans As ToolStripSplitButton
    Friend WithEvents ToolStripMenuItemMinutes5 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemMinutes10 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemMinutes15 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemMinutes20 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemMinutes30 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemHours1 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemHours2 As ToolStripMenuItem
    Friend WithEvents ToolStripMenuItemHours3 As ToolStripMenuItem
    Friend WithEvents ToolStripButtonClearChart As ToolStripButton
    Friend WithEvents ToolStripSeparator3 As ToolStripSeparator
    Friend WithEvents ToolStripButtonAutoScale As ToolStripButton
End Class
