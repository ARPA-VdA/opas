Imports System.IO.Ports
Imports System.IO
Imports System.Xml.Serialization
Imports System.ComponentModel
Imports Newtonsoft.Json

<System.Serializable()> Public Class ClassModule
    Implements IComparable

    
    
    
    Private Const StatusPropReadOnly As Boolean = True

    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Private Shared _NextId As Integer

    
    <Description("ID del modulo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property ID() As Integer

    <Description("Tipo di modulo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property ModuleTypeID() As EnumModuleType
    

    <Description("Nome modulo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Name() As String

    <Description("Informazioni modulo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    <XmlIgnore>
    <JsonIgnore>
    Public Property Info() As String

    <Description("Modulo attivo si/no"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Active() As Boolean

    <Description("Tempo di scansione dei moduli in secondi"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property PollingInterval() As Integer 

    <Description("Indirizzo del modulo se impostato"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Address() As String

    
    
    
    
    <Description("Porta seriale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Sistema")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property SerialPortObj() As SerialPort

    <Description("Nome porta seriale (COM1, COM2...)"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property ComPortName() As EnumSerialPortName

    <Description("Bauds porta seriale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property ComPortBauds() As Integer

    <Description("Parità porta seriale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property ComPortParity() As Parity

    <Description("Data bits porta seriale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property ComPortDataBits() As Integer

    <Description("Stop bits porta seriale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property ComPortStopBits() As StopBits

    <Description("Posizione del modulo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Position() As Integer


    <Description("Insieme dei canali di acquisizione"),
    [ReadOnly](StatusPropReadOnly),
     Category("Collezioni")>
    <Browsable(False)>
    Public Property Channels() As List(Of ClassChannel)

    <Description("Insieme dei canali di comando"),
    [ReadOnly](StatusPropReadOnly),
     Category("Collezioni")>
    <Browsable(False)>
    Public Property ChannelsCommand() As List(Of ClassChannelCommand)

    
    
    
    
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property ArrayValues() As List(Of Nullable(Of Single))

    Public Function CompareTo(ByVal obj As Object) As Integer _
       Implements System.IComparable.CompareTo
        If Not TypeOf obj Is ClassModule Then
            Throw New Exception("Object is not MyObject")
        End If
        Dim Compare As ClassModule = CType(obj, ClassModule)
        Dim result As Integer = Me.Position.CompareTo(Compare.Position)

        If result = 0 Then
            result = Me.Position.CompareTo(Compare.Position)
        End If
        Return result
    End Function

    
    
    
    
    Public Sub New()
        Try
            _NextId += 1
            Me.ID = _NextId
            Me.ModuleTypeID = Nothing
            Me.Name = String.Empty
            Me.Info = String.Empty
            Me.Active = True
            Me.PollingInterval = -1
            Me.Address = String.Empty

            
            Me.SerialPortObj = New SerialPort
            

            Me.ComPortName = EnumSerialPortName.COM1
            Me.ComPortBauds = 9600
            Me.ComPortParity = Parity.None
            Me.ComPortDataBits = 8
            Me.ComPortStopBits = StopBits.One

            Me.Channels = New List(Of ClassChannel)
            Me.ChannelsCommand = New List(Of ClassChannelCommand)
            Me.ArrayValues = New List(Of Nullable(Of Single))

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Overrides Function ToString() As String
        Return Me.Name
    End Function

    Public Function OpenPort() As Boolean
        Try
            If SerialPortObj IsNot Nothing AndAlso Me.SerialPortObj.IsOpen Then
                Return True
            End If

            
            With Me.SerialPortObj
                .PortName = Me.ComPortName.ToString
                .BaudRate = Me.ComPortBauds
                .Parity = Me.ComPortParity
                .DataBits = Me.ComPortDataBits
                .StopBits = Me.ComPortStopBits

                
                

                
                .Encoding = System.Text.Encoding.GetEncoding(28591)

                
                
                

                .Handshake = Handshake.None
                .DtrEnable = False
                .RtsEnable = False

                
                
            End With

            
            SerialPortObj.Open()
            Return True

        Catch ex As UnauthorizedAccessException
            ClassUtils.LogExeption(ex)
            Return False
        Catch ex As ArgumentOutOfRangeException
            ClassUtils.LogExeption(ex)
            Return False
        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
            Return False
        Catch ex As IOException
            ClassUtils.LogExeption(ex)
            Return False
        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function ClosePort() As Boolean
        Try
            If SerialPortObj IsNot Nothing AndAlso Me.SerialPortObj.IsOpen Then
                SerialPortObj.RtsEnable = False
                SerialPortObj.DtrEnable = False
                Me.SerialPortObj.Close()
            End If
        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        Finally
            SerialPortObj.Dispose()
            SerialPortObj = Nothing
        End Try
    End Function

    Public Function SuspendPort() As Boolean
        Try
            If SerialPortObj IsNot Nothing AndAlso Me.SerialPortObj.IsOpen Then
                Me.SerialPortObj.Close()
            End If
        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        Finally
        End Try
    End Function

    Public Enum EnumSerialPortName As Integer
        COM1 = 1
        COM2 = 2
        COM3 = 3
        COM4 = 4
        COM5 = 5
        COM6 = 6
        COM7 = 7
        COM8 = 8
        COM9 = 9
        COM10 = 10
        COM11 = 11
        COM12 = 12
        COM13 = 13
        COM14 = 14
        COM15 = 15
        COM16 = 16
        COM17 = 17
        COM18 = 18
        COM19 = 19
        COM20 = 20
        COM21 = 21
        COM22 = 22
        COM23 = 23
        COM24 = 24
        COM25 = 25
        COM26 = 26
        COM27 = 27
        COM28 = 28
        COM29 = 29
        COM30 = 30
        COM31 = 31
        COM32 = 32
        COM33 = 33
        COM34 = 34
        COM35 = 35
        COM36 = 36
        COM37 = 37
        COM38 = 38
        COM39 = 39
        COM40 = 40
    End Enum

    Public Enum EnumModuleType As Integer
        API100 = 100
        API100_DIAGS = 101

        API200 = 200
        API200E = 201
        API200_DIAGS = 202

        API300 = 300
        API300_DIAGS = 301

        API400 = 400
        API400A_DIAGS = 401
        API400E_DIAGS = 402
        API401 = 403

        API700 = 500
        API701 = 501
        API702 = 502

        SM200 = 600
        SM200_RPTM = 601 

        TEOM_1400A = 700
        TEOM_1400A_DIAGS = 701

        MCZ = 750

        GC955 = 800

        HORIBA370 = 850

        PAS2000 = 900 

        Silena600CE = 950
        Silena = 951 

        VAISALA_WXT510 = 1000

        VEREWA = 1100

    End Enum

End Class

