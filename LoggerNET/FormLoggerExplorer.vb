Imports System.IO
Imports Newtonsoft.Json

Public Class FormLoggerExplorer

    Private Property LG As ClassLogger
    Private Property SelectedLogger As ClassLogger
    Private Property SelectedModule As ClassModule

    Private Sub FormLoggerExplorer_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try

            Call IniComponents()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Sub IniComponents()
        Try

            Me.Text = "Logger explorer"

            
            SplitContainerMain.Dock = DockStyle.Fill
            SplitContainerModules.Dock = DockStyle.Fill
            SplitContainerChannels.Dock = DockStyle.Fill

            SplitContainerMain.SplitterDistance = 200
            SplitContainerModules.SplitterDistance = 150
            SplitContainerChannels.SplitterDistance = 150

            TreeViewLogger.Dock = DockStyle.Fill
            ListViewModules.Dock = DockStyle.Fill
            PropertyGridMain.Dock = DockStyle.Fill
            PropertyGridChannel.Dock = DockStyle.Fill

            
            
            ClearAll()

            
            LG = FormMDI.CM.LG

            
            SetTreeLogger()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub TreeViewLogger_AfterSelect(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TreeViewEventArgs) Handles TreeViewLogger.AfterSelect
        Try

            ListViewModules.Items.Clear()
            If TreeViewLogger.SelectedNode Is Nothing Then Exit Sub

            
            RefreshListAndGrid()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub ListViewModules_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ListViewModules.SelectedIndexChanged
        Try
            PropertyGridChannel.SelectedObject = Nothing
            If ListViewModules.SelectedItems.Count <> 1 Then Exit Sub

            Dim Obj As Object = ListViewModules.SelectedItems(0).Tag

            Select Case Obj.GetType.Name
                Case GetType(ClassChannel).Name
                    Dim Ch As ClassChannel
                    Ch = CType(Obj, ClassChannel)
                    If Ch Is Nothing Then Exit Sub

                    With PropertyGridChannel
                        
                        .CommandsVisibleIfAvailable = True
                        .Text = "Canale explorer"
                        .SelectedObject = Ch
                        
                    End With


                Case GetType(ClassChannelCommand).Name
                    Dim ChC As ClassChannelCommand
                    ChC = CType(Obj, ClassChannelCommand)
                    If ChC Is Nothing Then Exit Sub

                    With PropertyGridChannel
                        
                        .CommandsVisibleIfAvailable = True
                        .Text = "Canale explorer"
                        .SelectedObject = ChC
                        
                    End With

                Case Else

            End Select

        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try
    End Sub


    Sub RefreshListAndGrid()
        Try

            
            ListViewModules.Items.Clear()
            PropertyGridMain.SelectedObject = Nothing
            PropertyGridChannel.SelectedObject = Nothing

            
            SelectedLogger = TryCast(TreeViewLogger.SelectedNode.Tag, ClassLogger)
            If SelectedLogger IsNot Nothing Then
                With PropertyGridMain
                    
                    .CommandsVisibleIfAvailable = True
                    .Text = "Logger explorer"
                    .SelectedObject = SelectedLogger
                    
                End With
            End If

            
            SelectedModule = TryCast(TreeViewLogger.SelectedNode.Tag, ClassModule)
            If SelectedModule Is Nothing Then Exit Sub

            With PropertyGridMain
                
                .CommandsVisibleIfAvailable = True
                .Text = "Modulo explorer"
                .SelectedObject = SelectedModule
                

                
                .PropertySort = PropertySort.CategorizedAlphabetical
            End With

            With ListViewModules
                .Items.Clear()

                
                
                
                
                
                
                
                
                
                
                
                
                
                


                For Each Ch As ClassChannel In SelectedModule.Channels
                    Dim Item As New ListViewItem
                    Item.Text = Ch.Name
                    Item.ImageIndex = 0
                    Item.Tag = Ch

                    .Items.Add(Item)

                Next

                For Each ChC As ClassChannelCommand In SelectedModule.ChannelsCommand
                    Dim Item As New ListViewItem
                    Item.Text = ChC.Name
                    Item.ImageIndex = 0
                    Item.Tag = ChC

                    .Items.Add(Item)

                Next

            End With

        Catch ex As ArgumentException
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Sub SetTreeLogger()
        Try

            
            ClearAll()

            Dim MainNode As TreeNode
            Dim Node As TreeNode

            With TreeViewLogger

                MainNode = New TreeNode(LG.Name, 1, 1)
                MainNode.Tag = LG
                .Nodes.Add(MainNode)

                For Each Mo As ClassModule In LG.Modules
                    Node = New TreeNode(Mo.Name, 1, 1)
                    Node.Tag = Mo
                    MainNode.Nodes.Add(Node)
                    Application.DoEvents()
                Next

            End With

        Catch ex As ArgumentException
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Sub ClearAll()
        Try

            
            TreeViewLogger.Nodes.Clear()
            ListViewModules.Items.Clear()
            PropertyGridMain.SelectedObject = Nothing
            PropertyGridChannel.SelectedObject = Nothing

        Catch ex As ArgumentException
            MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub ChiudiToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ChiudiToolStripMenuItem.Click
        Try
            Me.Close()
        Catch ex As ArgumentException
        End Try
    End Sub
End Class