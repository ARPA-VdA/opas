<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FormLiveTable
    Inherits System.Windows.Forms.Form

    
    <System.Diagnostics.DebuggerNonUserCode()>
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

    
    
    
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormLiveTable))
        Me.DataGridViewLogger = New System.Windows.Forms.DataGridView()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.CheckedListBoxParameters = New System.Windows.Forms.CheckedListBox()
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip()
        Me.ToolStripButtonRun = New System.Windows.Forms.ToolStripButton()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.ToolStripButtonSelectAll = New System.Windows.Forms.ToolStripButton()
        CType(Me.DataGridViewLogger, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.ToolStrip1.SuspendLayout()
        Me.SuspendLayout()
        
        
        
        Me.DataGridViewLogger.AllowUserToOrderColumns = True
        Me.DataGridViewLogger.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.DataGridViewLogger.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridViewLogger.Location = New System.Drawing.Point(12, 164)
        Me.DataGridViewLogger.Name = "DataGridViewLogger"
        Me.DataGridViewLogger.Size = New System.Drawing.Size(651, 242)
        Me.DataGridViewLogger.TabIndex = 1
        
        
        
        Me.GroupBox1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.GroupBox1.Controls.Add(Me.CheckedListBoxParameters)
        Me.GroupBox1.Location = New System.Drawing.Point(12, 28)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(651, 131)
        Me.GroupBox1.TabIndex = 3
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Parametri disponibili"
        
        
        
        Me.CheckedListBoxParameters.CheckOnClick = True
        Me.CheckedListBoxParameters.Dock = System.Windows.Forms.DockStyle.Fill
        Me.CheckedListBoxParameters.FormattingEnabled = True
        Me.CheckedListBoxParameters.Location = New System.Drawing.Point(3, 16)
        Me.CheckedListBoxParameters.Name = "CheckedListBoxParameters"
        Me.CheckedListBoxParameters.Size = New System.Drawing.Size(645, 112)
        Me.CheckedListBoxParameters.TabIndex = 0
        
        
        
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripButtonRun, Me.ToolStripSeparator1, Me.ToolStripButtonSelectAll})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(675, 25)
        Me.ToolStrip1.TabIndex = 4
        Me.ToolStrip1.Text = "ToolStrip1"
        
        
        
        Me.ToolStripButtonRun.CheckOnClick = True
        Me.ToolStripButtonRun.Image = Global.Ecometer.My.Resources.Resources.runer
        Me.ToolStripButtonRun.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonRun.Name = "ToolStripButtonRun"
        Me.ToolStripButtonRun.Size = New System.Drawing.Size(59, 22)
        Me.ToolStripButtonRun.Text = "Attivo"
        Me.ToolStripButtonRun.ToolTipText = "Attiva disattiva aggiornamento"
        
        
        
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(6, 25)
        
        
        
        Me.ToolStripButtonSelectAll.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
        Me.ToolStripButtonSelectAll.Image = CType(resources.GetObject("ToolStripButtonSelectAll.Image"), System.Drawing.Image)
        Me.ToolStripButtonSelectAll.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtonSelectAll.Name = "ToolStripButtonSelectAll"
        Me.ToolStripButtonSelectAll.Size = New System.Drawing.Size(145, 22)
        Me.ToolStripButtonSelectAll.Text = "Seleziona tutti i parametri"
        Me.ToolStripButtonSelectAll.ToolTipText = "Seleziona tutti i parametri"
        
        
        
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(675, 418)
        Me.Controls.Add(Me.ToolStrip1)
        Me.Controls.Add(Me.DataGridViewLogger)
        Me.Controls.Add(Me.GroupBox1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "FormLiveTable"
        Me.Text = "FormLiveTable"
        CType(Me.DataGridViewLogger, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents DataGridViewLogger As DataGridView
    Friend WithEvents GroupBox1 As GroupBox
    Friend WithEvents CheckedListBoxParameters As CheckedListBox
    Friend WithEvents ToolStrip1 As ToolStrip
    Friend WithEvents ToolStripButtonRun As ToolStripButton
    Friend WithEvents ToolStripSeparator1 As ToolStripSeparator
    Friend WithEvents ToolStripButtonSelectAll As ToolStripButton
End Class
