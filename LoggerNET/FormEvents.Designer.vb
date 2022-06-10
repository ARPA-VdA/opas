<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormEvents
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormEvents))
        Me.ListViewEvents = New System.Windows.Forms.ListView()
        Me.ImageList1 = New System.Windows.Forms.ImageList(Me.components)
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip()
        Me.ToolStripButtoncLEAR = New System.Windows.Forms.ToolStripButton()
        Me.ToolStrip1.SuspendLayout()
        Me.SuspendLayout()
        
        
        
        Me.ListViewEvents.FullRowSelect = True
        Me.ListViewEvents.Location = New System.Drawing.Point(12, 50)
        Me.ListViewEvents.MultiSelect = False
        Me.ListViewEvents.Name = "ListViewEvents"
        Me.ListViewEvents.Size = New System.Drawing.Size(270, 128)
        Me.ListViewEvents.SmallImageList = Me.ImageList1
        Me.ListViewEvents.TabIndex = 0
        Me.ListViewEvents.UseCompatibleStateImageBehavior = False
        Me.ListViewEvents.View = System.Windows.Forms.View.Details
        
        
        
        Me.ImageList1.ImageStream = CType(resources.GetObject("ImageList1.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageList1.TransparentColor = System.Drawing.Color.Transparent
        Me.ImageList1.Images.SetKeyName(0, "info31.png")
        Me.ImageList1.Images.SetKeyName(1, "warning45.png")
        Me.ImageList1.Images.SetKeyName(2, "log7.png")
        
        
        
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripButtoncLEAR})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(616, 25)
        Me.ToolStrip1.TabIndex = 1
        Me.ToolStrip1.Text = "ToolStrip1"
        
        
        
        Me.ToolStripButtoncLEAR.Image = Global.Ecometer.My.Resources.Resources.clean11
        Me.ToolStripButtoncLEAR.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.ToolStripButtoncLEAR.Name = "ToolStripButtoncLEAR"
        Me.ToolStripButtoncLEAR.Size = New System.Drawing.Size(85, 22)
        Me.ToolStripButtoncLEAR.Text = "Pulisci lista"
        
        
        
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(616, 350)
        Me.Controls.Add(Me.ListViewEvents)
        Me.Controls.Add(Me.ToolStrip1)
        Me.DoubleBuffered = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "FormEvents"
        Me.Text = "FormEvents"
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents ListViewEvents As System.Windows.Forms.ListView
    Friend WithEvents ImageList1 As System.Windows.Forms.ImageList
    Friend WithEvents ToolStrip1 As ToolStrip
    Friend WithEvents ToolStripButtoncLEAR As ToolStripButton
End Class
