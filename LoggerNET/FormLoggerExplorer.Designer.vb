<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormLoggerExplorer
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormLoggerExplorer))
        Me.ListViewModules = New System.Windows.Forms.ListView()
        Me.ImageListLarge = New System.Windows.Forms.ImageList(Me.components)
        Me.TreeViewLogger = New System.Windows.Forms.TreeView()
        Me.ImageListSmall = New System.Windows.Forms.ImageList(Me.components)
        Me.PropertyGridChannel = New System.Windows.Forms.PropertyGrid()
        Me.SplitContainerMain = New System.Windows.Forms.SplitContainer()
        Me.SplitContainerModules = New System.Windows.Forms.SplitContainer()
        Me.PropertyGridMain = New System.Windows.Forms.PropertyGrid()
        Me.SplitContainerChannels = New System.Windows.Forms.SplitContainer()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.FileToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ChiudiToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.StatusStrip1 = New System.Windows.Forms.StatusStrip()
        Me.ToolStripStatusLabelConfig = New System.Windows.Forms.ToolStripStatusLabel()
        CType(Me.SplitContainerMain, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainerMain.Panel1.SuspendLayout()
        Me.SplitContainerMain.Panel2.SuspendLayout()
        Me.SplitContainerMain.SuspendLayout()
        CType(Me.SplitContainerModules, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainerModules.Panel1.SuspendLayout()
        Me.SplitContainerModules.Panel2.SuspendLayout()
        Me.SplitContainerModules.SuspendLayout()
        CType(Me.SplitContainerChannels, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainerChannels.Panel1.SuspendLayout()
        Me.SplitContainerChannels.Panel2.SuspendLayout()
        Me.SplitContainerChannels.SuspendLayout()
        Me.MenuStrip1.SuspendLayout()
        Me.StatusStrip1.SuspendLayout()
        Me.SuspendLayout()
        
        
        
        Me.ListViewModules.GridLines = True
        Me.ListViewModules.LargeImageList = Me.ImageListLarge
        Me.ListViewModules.Location = New System.Drawing.Point(3, 3)
        Me.ListViewModules.MultiSelect = False
        Me.ListViewModules.Name = "ListViewModules"
        Me.ListViewModules.ShowItemToolTips = True
        Me.ListViewModules.Size = New System.Drawing.Size(284, 181)
        Me.ListViewModules.TabIndex = 0
        Me.ListViewModules.UseCompatibleStateImageBehavior = False
        
        
        
        Me.ImageListLarge.ImageStream = CType(resources.GetObject("ImageListLarge.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageListLarge.TransparentColor = System.Drawing.Color.Transparent
        Me.ImageListLarge.Images.SetKeyName(0, "Nav-Blue.png")
        
        
        
        Me.TreeViewLogger.ImageIndex = 0
        Me.TreeViewLogger.ImageList = Me.ImageListSmall
        Me.TreeViewLogger.Location = New System.Drawing.Point(10, 3)
        Me.TreeViewLogger.Name = "TreeViewLogger"
        Me.TreeViewLogger.SelectedImageIndex = 0
        Me.TreeViewLogger.ShowNodeToolTips = True
        Me.TreeViewLogger.Size = New System.Drawing.Size(199, 104)
        Me.TreeViewLogger.TabIndex = 1
        
        
        
        Me.ImageListSmall.ImageStream = CType(resources.GetObject("ImageListSmall.ImageStream"), System.Windows.Forms.ImageListStreamer)
        Me.ImageListSmall.TransparentColor = System.Drawing.Color.Transparent
        Me.ImageListSmall.Images.SetKeyName(0, "Arrow Blue Right-2.png")
        Me.ImageListSmall.Images.SetKeyName(1, "Arrow Green Right.png")
        Me.ImageListSmall.Images.SetKeyName(2, "Arrow Purple Right.png")
        Me.ImageListSmall.Images.SetKeyName(3, "Arrow Yellow Right.png")
        
        
        
        Me.PropertyGridChannel.CategoryForeColor = System.Drawing.SystemColors.InactiveCaptionText
        Me.PropertyGridChannel.Location = New System.Drawing.Point(15, 22)
        Me.PropertyGridChannel.Name = "PropertyGridChannel"
        Me.PropertyGridChannel.Size = New System.Drawing.Size(234, 185)
        Me.PropertyGridChannel.TabIndex = 2
        
        
        
        Me.SplitContainerMain.Location = New System.Drawing.Point(2, 27)
        Me.SplitContainerMain.Name = "SplitContainerMain"
        
        
        
        Me.SplitContainerMain.Panel1.Controls.Add(Me.SplitContainerModules)
        
        
        
        Me.SplitContainerMain.Panel2.Controls.Add(Me.SplitContainerChannels)
        Me.SplitContainerMain.Size = New System.Drawing.Size(671, 489)
        Me.SplitContainerMain.SplitterDistance = 223
        Me.SplitContainerMain.TabIndex = 3
        
        
        
        Me.SplitContainerModules.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainerModules.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainerModules.Name = "SplitContainerModules"
        Me.SplitContainerModules.Orientation = System.Windows.Forms.Orientation.Horizontal
        
        
        
        Me.SplitContainerModules.Panel1.Controls.Add(Me.TreeViewLogger)
        
        
        
        Me.SplitContainerModules.Panel2.Controls.Add(Me.PropertyGridMain)
        Me.SplitContainerModules.Size = New System.Drawing.Size(223, 489)
        Me.SplitContainerModules.SplitterDistance = 217
        Me.SplitContainerModules.TabIndex = 0
        
        
        
        Me.PropertyGridMain.CategoryForeColor = System.Drawing.SystemColors.InactiveCaptionText
        Me.PropertyGridMain.Location = New System.Drawing.Point(3, 3)
        Me.PropertyGridMain.Name = "PropertyGridMain"
        Me.PropertyGridMain.Size = New System.Drawing.Size(199, 185)
        Me.PropertyGridMain.TabIndex = 3
        
        
        
        Me.SplitContainerChannels.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainerChannels.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainerChannels.Name = "SplitContainerChannels"
        Me.SplitContainerChannels.Orientation = System.Windows.Forms.Orientation.Horizontal
        
        
        
        Me.SplitContainerChannels.Panel1.Controls.Add(Me.ListViewModules)
        
        
        
        Me.SplitContainerChannels.Panel2.Controls.Add(Me.PropertyGridChannel)
        Me.SplitContainerChannels.Size = New System.Drawing.Size(444, 489)
        Me.SplitContainerChannels.SplitterDistance = 217
        Me.SplitContainerChannels.TabIndex = 0
        
        
        
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.FileToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(834, 24)
        Me.MenuStrip1.TabIndex = 4
        Me.MenuStrip1.Text = "MenuStrip1"
        
        
        
        Me.FileToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ChiudiToolStripMenuItem})
        Me.FileToolStripMenuItem.Name = "FileToolStripMenuItem"
        Me.FileToolStripMenuItem.Size = New System.Drawing.Size(37, 20)
        Me.FileToolStripMenuItem.Text = "&File"
        
        
        
        Me.ChiudiToolStripMenuItem.Image = Global.Ecometer.My.Resources.Resources.door9
        Me.ChiudiToolStripMenuItem.Name = "ChiudiToolStripMenuItem"
        Me.ChiudiToolStripMenuItem.Size = New System.Drawing.Size(152, 22)
        Me.ChiudiToolStripMenuItem.Text = "&Esci"
        
        
        
        Me.StatusStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolStripStatusLabelConfig})
        Me.StatusStrip1.Location = New System.Drawing.Point(0, 546)
        Me.StatusStrip1.Name = "StatusStrip1"
        Me.StatusStrip1.Size = New System.Drawing.Size(834, 22)
        Me.StatusStrip1.TabIndex = 5
        Me.StatusStrip1.Text = "StatusStrip1"
        
        
        
        Me.ToolStripStatusLabelConfig.Image = Global.Ecometer.My.Resources.Resources.xml6
        Me.ToolStripStatusLabelConfig.Name = "ToolStripStatusLabelConfig"
        Me.ToolStripStatusLabelConfig.Size = New System.Drawing.Size(166, 17)
        Me.ToolStripStatusLabelConfig.Text = "ToolStripStatusLabelConfig"
        
        
        
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(834, 568)
        Me.Controls.Add(Me.StatusStrip1)
        Me.Controls.Add(Me.SplitContainerMain)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "FormLoggerExplorer"
        Me.Text = "FormLoggerExplorer"
        Me.SplitContainerMain.Panel1.ResumeLayout(False)
        Me.SplitContainerMain.Panel2.ResumeLayout(False)
        CType(Me.SplitContainerMain, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainerMain.ResumeLayout(False)
        Me.SplitContainerModules.Panel1.ResumeLayout(False)
        Me.SplitContainerModules.Panel2.ResumeLayout(False)
        CType(Me.SplitContainerModules, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainerModules.ResumeLayout(False)
        Me.SplitContainerChannels.Panel1.ResumeLayout(False)
        Me.SplitContainerChannels.Panel2.ResumeLayout(False)
        CType(Me.SplitContainerChannels, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainerChannels.ResumeLayout(False)
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.StatusStrip1.ResumeLayout(False)
        Me.StatusStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents ListViewModules As System.Windows.Forms.ListView
    Friend WithEvents TreeViewLogger As System.Windows.Forms.TreeView
    Friend WithEvents ImageListLarge As System.Windows.Forms.ImageList
    Friend WithEvents ImageListSmall As System.Windows.Forms.ImageList
    Friend WithEvents PropertyGridChannel As System.Windows.Forms.PropertyGrid
    Friend WithEvents SplitContainerMain As System.Windows.Forms.SplitContainer
    Friend WithEvents SplitContainerChannels As System.Windows.Forms.SplitContainer
    Friend WithEvents MenuStrip1 As MenuStrip
    Friend WithEvents FileToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents StatusStrip1 As StatusStrip
    Friend WithEvents ToolStripStatusLabelConfig As ToolStripStatusLabel
    Friend WithEvents PropertyGridMain As PropertyGrid
    Friend WithEvents SplitContainerModules As SplitContainer
    Friend WithEvents ChiudiToolStripMenuItem As ToolStripMenuItem
End Class
