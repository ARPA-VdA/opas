Public Class ClassLoggerDisplay

    Public Property ID() As Integer
    Public Property ModuleName() As String
    Public Property SerialPort() As String
    Public Property ChannelName() As String
    Public Property ChannelUnit() As String
    Public Property LastRawValue() As Nullable(Of Single)
    Public Property LastValue() As Nullable(Of Single)
    Public Property MeanValue() As Nullable(Of Single)
    Public Property MaxValue() As Nullable(Of Single)
    Public Property MinValue() As Nullable(Of Single)
    Public Property Readings() As Integer
    Public Property ReadingsWrong() As Integer
    Public Property Code() As Integer

    Public Sub New()
    End Sub

    Public Sub New(ByVal ID As Integer,
                   ByVal ModuleName As String,
                   ByVal SerialPort As String,
                   ByVal ChannelName As String,
                   ByVal ChannelUnit As String,
                   ByVal LastRawValue As Nullable(Of Single),
                   ByVal LastValue As Nullable(Of Single),
                   ByVal MeanValue As Nullable(Of Single),
                   ByVal MaxValue As Nullable(Of Single),
                   ByVal MinValue As Nullable(Of Single),
                   ByVal Readings As Integer,
                   ByVal ReadingsWrong As Integer,
                   ByVal Code As Integer)

        
        Me.ID = ID
        Me.ModuleName = ModuleName
        Me.SerialPort = SerialPort
        Me.ChannelName = ChannelName
        Me.ChannelUnit = ChannelUnit
        
        Me.LastRawValue = LastRawValue
        Me.LastValue = LastValue
        Me.MeanValue = MeanValue
        Me.MaxValue = MaxValue
        Me.MinValue = MinValue
        Me.Readings = Readings
        Me.ReadingsWrong = ReadingsWrong
        Me.Code = Code
    End Sub

End Class

Public Class ClassLoggerDisplayCommand

    Public Property ID() As Integer
    Public Property ModuleName() As String
    Public Property ChannelName() As String
    Public Property ChannelUnit() As String
    Public Property LastRawValue() As Nullable(Of Single)
    Public Property LastValue() As Nullable(Of Single)
    Public Property MeanValue() As Nullable(Of Single)
    Public Property MaxValue() As Nullable(Of Single)
    Public Property MinValue() As Nullable(Of Single)
    Public Property Readings() As Integer
    Public Property ReadingsWrong() As Integer
    Public Property Code() As Integer

    Public Sub New()
        Me.ID = -1
        Me.ModuleName = String.Empty
        Me.ChannelName = String.Empty
        Me.ChannelUnit = String.Empty
        Me.LastRawValue = Nothing
        Me.LastValue = Nothing
        Me.MeanValue = Nothing
        Me.MaxValue = Nothing
        Me.MinValue = Nothing
        Me.Readings = 0
        Me.ReadingsWrong = 0
        Me.Code = 0
    End Sub

    Public Sub New(ByVal ID As Integer,
                   ByVal ModuleID As Integer,
                   ByVal ModuleName As String,
                   ByVal ChannelID As Integer,
                   ByVal ChannelName As String,
                   ByVal Command As String,
                   ByVal Value As Integer,
                   ByVal DateTime As Date,
                   ByVal Repeat As Boolean,
                   ByVal CommandSent As Boolean)

        
        Me.ID = ID
        Me.ModuleName = ModuleName
        Me.ChannelName = ChannelName
        
        Me.LastRawValue = LastRawValue
        Me.LastValue = LastValue
        Me.MeanValue = MeanValue
        Me.MaxValue = MaxValue
        Me.MinValue = MinValue
        Me.Readings = Readings
        Me.ReadingsWrong = ReadingsWrong
        Me.Code = Code
    End Sub

End Class
