Imports System.Xml
Imports System.IO
Imports System.ComponentModel
Imports Newtonsoft.Json

<System.Serializable()> Public Class ClassLogger

    
    
    
    Private Const StatusPropReadOnly As Boolean = True

    <Description("ID del datalogger"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property ID As Integer

    <Description("Nome del datalogger"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property Name As String

    <Description("Header del file dati"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property DataFileHeader As String

    <Description("Insieme dei moduli"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    <Browsable(False)>
    Public Property Modules() As List(Of ClassModule)

    <Description("Allarme di stazione"),
    [ReadOnly](StatusPropReadOnly),
    Category("Proprietà")>
    <JsonIgnore>
    <Browsable(False)>
    Public Property StationAlarm() As Integer

    Public Sub New()
        Try

            Me.ID = -1
            Me.Name = String.Empty
            Me.DataFileHeader = String.Empty
            Me.Modules = New List(Of ClassModule)
            Me.StationAlarm = 0

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Overrides Function ToString() As String
        Return Me.Name
    End Function

    Friend Sub ResetChannels()
        Try
            

            
            For Each M As ClassModule In Modules
                
                For Each C As ClassChannel In M.Channels
                    
                    ResetChannel(C)
                Next
            Next
        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Friend Sub ResetAlarms()
        Try
            
            Me.StationAlarm = 0

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Friend Sub ResetChannel(ByVal Ch As ClassChannel)
        Try

            
            Ch.Readings = 0
            Ch.ReadingsWrong = 0
            Ch.LastRawValue = Nothing
            Ch.LastValue = Nothing
            Ch.TotalValue = Nothing
            Ch.MeanValue = Nothing
            Ch.MinValue = Nothing
            Ch.MinTime = Nothing
            Ch.MaxValue = Nothing
            Ch.MaxTime = Nothing
            Ch.StdDev = Nothing
            Ch.Code = 0
            Ch.Values = New List(Of Nullable(Of Single))

            
            Ch.MeanDone = True

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Friend Sub SetFullNames()
        Try

            For Each M As ClassModule In Modules

                For Each C As ClassChannel In M.Channels
                    C.FullName = M.Name + " " + C.Name
                Next

            Next

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

End Class
