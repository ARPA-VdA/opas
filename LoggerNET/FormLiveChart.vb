
Imports System.Windows.Forms.DataVisualization.Charting

Public Class FormLiveChart
    
    
    
    
    Public Property LD As ClassLoggerDisplay
    
    
    
    
    Public Property LTModules As List(Of ClassModule)

    
    
    
    
    Private Property SpanTime As Double

    Private Sub FormLiveChart_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Try

            
            Call InitComponents()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub FormLiveChart_FormClosed(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles Me.FormClosed
        Try
            FormMDI.FLC = Nothing
            If FormMDI.FL IsNot Nothing Then
                If FormMDI.FL.FLC IsNot Nothing Then
                    FormMDI.FL.FLC = Nothing
                End If
            End If
        Catch ex As ArgumentException
        End Try
    End Sub

    Private Sub ToolStripMenuItemMinutes5_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItemMinutes5.Click,
            ToolStripMenuItemMinutes10.Click, ToolStripMenuItemMinutes15.Click, ToolStripMenuItemMinutes20.Click,
            ToolStripMenuItemMinutes30.Click, ToolStripMenuItemHours1.Click, ToolStripMenuItemHours2.Click, ToolStripMenuItemHours3.Click

        Try

            ToolStripMenuItemMinutes5.Checked = False
            ToolStripMenuItemMinutes10.Checked = False
            ToolStripMenuItemMinutes15.Checked = False
            ToolStripMenuItemMinutes20.Checked = False
            ToolStripMenuItemMinutes30.Checked = False
            ToolStripMenuItemHours1.Checked = False
            ToolStripMenuItemHours2.Checked = False
            ToolStripMenuItemHours3.Checked = False

            
            Dim Item As ToolStripMenuItem = CType(sender, ToolStripMenuItem)
            Item.Checked = True
            ToolStripSplitButtonSpans.Text = "Finestra temporale: " + Item.Text

            
            SpanTime = CDbl(Item.Tag)

        Catch ex As ArgumentException
        End Try
    End Sub

    Private Sub ToolStripButtonClearChart_Click(sender As Object, e As EventArgs) Handles ToolStripButtonClearChart.Click
        Try

            
            ToolStripButtonMultiArea.Checked = False
            ToolStripButtonAutoScale.Checked = False

            
            ResetAreas()

            
            ClearSeriesData()

        Catch ex As ArgumentException
        End Try
    End Sub

    Private Sub CheckedListBoxParameters_SelectedValueChanged(sender As Object, e As EventArgs) Handles CheckedListBoxParameters.SelectedValueChanged
        Try

            
            ToolStripButtonMultiArea.Checked = False
            ToolStripButtonAutoScale.Checked = False

            
            ResetAreas()

            
            ClearSeriesData()

            
            With Chart

                .Series.Clear()

                
                Dim i As Integer = 0
                For Each Item As ClassChannel In CheckedListBoxParameters.CheckedItems

                    

                    .Series.Add(Item.FullName)
                    .Series(i).Name = String.Format("{0} [{1}]", Item.FullName, Item.Unit)
                    .Series(i).ChartType = SeriesChartType.Line
                    .Series(i).XValueType = ChartValueType.DateTime
                    
                    

                    
                    .Series(i).YValueType = ChartValueType.Single

                    
                    
                    .Series(i).XValueMember = "Data & Ora"

                    
                    .Series(i).BorderWidth = 3

                    i += 1
                Next

            End With

        Catch ex As ArgumentException
            Debug.Print(ex.Message)
        End Try
    End Sub

    Private Sub ToolStripButtonAutoScale_Click(sender As Object, e As EventArgs) Handles ToolStripButtonAutoScale.Click
        Try

            If ToolStripButtonAutoScale.Checked Then

                For Each Ca As ChartArea In Chart.ChartAreas
                    Ca.AxisY.IsStartedFromZero = False
                Next

            Else

                For Each Ca As ChartArea In Chart.ChartAreas
                    Ca.AxisY.IsStartedFromZero = True
                Next

            End If

        Catch ex As ArgumentException
            Debug.Print(ex.Message)
        End Try
    End Sub

    Private Sub ToolStripButtonMultiArea_Click(sender As Object, e As EventArgs) Handles ToolStripButtonMultiArea.Click
        Try
            If ToolStripButtonMultiArea.Checked Then

                
                ResetAreas()

                
                For i As Integer = 0 To CheckedListBoxParameters.CheckedItems.Count - 2

                    
                    With Chart

                        
                        Dim ca As New ChartArea()
                        
                        ca.Name = "ChartArea" + (i + 2).ToString
                        SetAreaProperties(ca)
                        .ChartAreas.Add(ca)

                        .Series(i + 1).ChartArea = ca.Name

                    End With

                Next

            Else

                
                For Each s As Series In Chart.Series
                    s.ChartArea = Chart.ChartAreas(0).Name
                Next

                
                With Chart.ChartAreas
                    
                    While .Count > 1
                        .RemoveAt(.Count - 1)
                    End While
                End With

            End If

        Catch ex As ArgumentException
            Debug.Print(ex.Message)
        End Try
    End Sub

    Sub InitComponents()
        Try

            
            Me.Text = "Visualizzazione grafici"

            
            

            
            
            
            
            
            

            
            SpanTime = 5 * 60
            ToolStripSplitButtonSpans.Text = "Finestra temporale: 5 minuti"

            With Chart

                
                Dim LG As Legend = .Legends(0)
                
                
                
                LG.Title = ""
                LG.Docking = Docking.Bottom 
                
                LG.BorderDashStyle = ChartDashStyle.Solid
                LG.BorderColor = Color.LightGray
                LG.BorderWidth = 1


                
                
                
                
                
                
                
                
                

                
                
                
                
                
                
                
                
                

                
                SetAreaProperties(.ChartAreas(0))

                
                .Series.Clear()

            End With

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Sub ResetAreas()
        Try

            
            With Chart.ChartAreas
                
                While .Count > 1
                    .RemoveAt(.Count - 1)
                End While
            End With

        Catch ex As ArgumentException
        End Try
    End Sub

    Sub ClearSeriesData()
        Try

            
            For Each s As Series In Chart.Series
                s.Points.Clear()
            Next

        Catch ex As ArgumentException
        End Try
    End Sub

    Private Sub SetAreaProperties(chartArea As ChartArea)
        Try

            With chartArea
                .AxisX.IntervalType = DateTimeIntervalType.Seconds
                
                
                
                
                

                
                .AxisY.LabelStyle.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.0F, System.Drawing.FontStyle.Regular)
                .AxisX.LabelStyle.Font = New System.Drawing.Font("Microsoft Sans Serif", 10.0F, System.Drawing.FontStyle.Regular)
                .AxisX.LabelStyle.Format = "hh:mm:ss"

                .AxisY.LabelAutoFitStyle = LabelAutoFitStyles.LabelsAngleStep30 And LabelAutoFitStyles.LabelsAngleStep45 And LabelAutoFitStyles.LabelsAngleStep90
                .AxisX.LabelAutoFitStyle = LabelAutoFitStyles.LabelsAngleStep30 And LabelAutoFitStyles.LabelsAngleStep45 And LabelAutoFitStyles.LabelsAngleStep90
                

                
                .AxisX.MajorGrid.LineColor = Color.LightGray
                .AxisY.MajorGrid.LineColor = Color.LightGray
                .AxisX.MajorGrid.Enabled = False

                
                
                
                
                

                
                
                

                
                
                
                

                
                

                
                

                
                

                
                
                
                


                .CursorY.IsUserEnabled = True
                .CursorY.IsUserSelectionEnabled = True
                .CursorY.AutoScroll = True

                .AxisY.ScaleView.Zoomable = True
                .AxisY.ScrollBar.IsPositionedInside = True
                

                
                
                

                
                
                

                .CursorY.SelectionColor = Color.DarkGray

                .AxisY.ScrollBar.IsPositionedInside = True
                

            End With

        Catch ex As ArgumentException

        End Try
    End Sub

    Public Function SetParametersList() As Boolean
        Try

            With CheckedListBoxParameters

                For Each MyModule As ClassModule In LTModules

                    For Each MyChannel As ClassChannel In MyModule.Channels
                        If MyChannel.IsDiagnostic Then
                            
                        Else
                            
                            .Items.Add(MyChannel)
                            .DisplayMember = "FullName"
                        End If
                    Next

                Next

            End With

        Catch ex As ArgumentException
        End Try
    End Function

    Public Function AppendNewData(listMain As List(Of ClassLoggerDisplay)) As Boolean
        Try

            If ToolStripButtonRun.Checked = False Then Return False

            
            With Chart

                
                Dim row As List(Of Nullable(Of Single)) = New List(Of Nullable(Of Single))

                
                For Each Item As ClassChannel In CheckedListBoxParameters.CheckedItems

                    
                    For Each rec As ClassLoggerDisplay In listMain

                        If Item.ID = rec.ID Then

                            row.Add(rec.LastValue)
                            
                            Exit For

                        End If
                    Next

                Next

                
                
                Dim StartTime As DateTime
                Dim EndTime As DateTime
                Dim ElapsedTime As Double
                If .Series(0).Points.Count > 0 Then
                    StartTime = Date.FromOADate(.Series(0).Points(0).XValue)
                    EndTime = Now
                    ElapsedTime = (EndTime - StartTime).TotalSeconds
                End If

                If row.Count > 0 And row.Count = CheckedListBoxParameters.CheckedItems.Count Then
                    
                    Dim i As Integer = 0
                    For Each item As Single? In row

                        
                        .Series(i).Points.AddXY(Now, item)

                        If ElapsedTime > SpanTime Then
                            .Series(i).Points.RemoveAt(0)
                        End If
                        
                        
                        

                        
                        i += 1
                    Next
                End If

                
                
                If .ChartAreas(0).AxisY.ScaleView.IsZoomed Then
                    
                Else
                    .ResetAutoValues()
                End If

                
                


            End With

        Catch ex As ArgumentException
            Debug.Print(ex.Message)
        End Try
    End Function

    
    
    
    
    
    
    

    
    
    

    
    
    

End Class