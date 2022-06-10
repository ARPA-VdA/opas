Imports System.ComponentModel
Imports System.IO
Imports System.Xml.Serialization
Imports Newtonsoft.Json

<System.Serializable()>
Public Class ClassChannelBase
    Implements IComparable

    
    
    
    Public Const StatusPropReadOnly As Boolean = True

    <Description("ID del canale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property ID() As Integer

    <Description("Nome del canale"),
    [ReadOnly](StatusPropReadOnly),
    Category("Proprietà")>
    Public Property Name() As String

    <Description("Nome del modulo e del canale"),
    [ReadOnly](StatusPropReadOnly),
    Category("Proprietà")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property FullName() As String

    <Description("Canale attivo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property Active() As Boolean

    <Description("Posizione del canale"),
    [ReadOnly](StatusPropReadOnly),
    Category("Proprietà")>
    Public Property Position() As Integer

    
    Public Function CompareTo(ByVal obj As Object) As Integer Implements System.IComparable.CompareTo

        If Not TypeOf obj Is ClassChannel Then
            Throw New Exception("Object is not MyObject")
        End If
        Dim Compare As ClassChannel = CType(obj, ClassChannel)
        Dim result As Integer = Me.Position.CompareTo(Compare.Position)

        If result = 0 Then
            result = Me.Position.CompareTo(Compare.Position)
        End If
        Return result

    End Function

    Sub New()
        Me.ID = -1
        Me.Name = String.Empty
        Me.Active = False
        Me.Position = -1
    End Sub

    Public Enum ChannelAlgorithm As Integer
        Average = 0
        Total = 1
        Sample = 2
    End Enum

End Class





<System.Serializable()>
Public Class ClassChannel
    Inherits ClassChannelBase
    Implements IComparable

    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Private Shared _NextId As Integer

    <Description("ID del canale salvato nelle tabelle dati"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property DatabaseId() As Integer

    <Description("Posizione nell
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property DataArrayIdx() As Integer

    <Description("Intervallo della media in secondi"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property MeanInterval() As Integer

    <Description("é un parametro diagnostico"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property IsDiagnostic() As Boolean

    <Description("Salva come csv"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property StoreCsv() As Boolean

    
    <Description("Unità di misura del canale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Unit() As String

    <Description("Decimali del canale"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Decimals() As Integer

    <Description("Algoritmo di misura del canale (media, somma)"),
    [ReadOnly](StatusPropReadOnly),
     Category("Proprietà")>
    Public Property Algorithm() As ChannelAlgorithm

    <Description("Formula correttiva da applicare al valore grezzo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Punti e formule")>
    Public Property Formule() As String


    
    
    
    
    

    
    
    
    

    
    
    
    


    

    <Description("Percentuale minimo numero di misure valide (75%)"),
    [ReadOnly](StatusPropReadOnly),
     Category("Filtri")>
    Public Property ReadingsMinPercentage() As Integer

    <Description("Minimo valore accettato"),
    [ReadOnly](StatusPropReadOnly),
     Category("Filtri")>
    Public Property AllowedMinValue() As Nullable(Of Single)

    <Description("Massimo valore accettato"),
    [ReadOnly](StatusPropReadOnly),
     Category("Filtri")>
    Public Property AllowedMaxValue() As Nullable(Of Single)

    <Description("Minima variazione accettata"),
    [ReadOnly](StatusPropReadOnly),
     Category("Filtri")>
    Public Property AllowedMinVariance() As Nullable(Of Single)

    <Description("Massima variazione accettata"),
    [ReadOnly](StatusPropReadOnly),
     Category("Filtri")>
    Public Property AllowedMaxVariance() As Nullable(Of Single)


    
    <Description("Numero di letture"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property Readings() As Integer

    <Description("Numero di letture errate"),
    [ReadOnly](StatusPropReadOnly),
    Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property ReadingsWrong() As Integer

    <Description("Ultimo valore letto"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property LastRawValue() As Nullable(Of Single)

    <Description("Ultimo valore letto"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property LastValue() As Nullable(Of Single)

    <Description("Sommatoria valori"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property TotalValue() As Single

    <Description("Valore medio"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property MeanValue() As Nullable(Of Single)

    <Description("Valore minimo"),
    [ReadOnly](StatusPropReadOnly),
    Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property MinValue() As Nullable(Of Single)

    <Description("Data del valore minimo"),
    [ReadOnly](StatusPropReadOnly),
    Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property MinTime() As Nullable(Of DateTime)

    <Description("Valore massimo"),
    [ReadOnly](StatusPropReadOnly),
    Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property MaxValue() As Nullable(Of Single)

    <Description("Data del valore massimo"),
    [ReadOnly](StatusPropReadOnly),
    Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property MaxTime() As Nullable(Of DateTime)

    <Description("Deviazione standars"),
    [ReadOnly](StatusPropReadOnly),
    Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property StdDev() As Nullable(Of Single)

    <Description("Codice di validità"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property Code() As Integer

    <Description("Media già eseguita"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property MeanDone() As Boolean

    
    
    
    
    <Description("Array valori acquisiti"),
    [ReadOnly](StatusPropReadOnly),
     Category("Calcolati")>
    <XmlIgnore>
    <JsonIgnore>
    <Browsable(False)>
    Public Property Values As List(Of Nullable(Of Single))

    
    
    
    Sub New()

        
        _NextId += 1
        Me.ID = _NextId
        Me.DatabaseId = -1
        Me.Name = String.Empty
        Me.Active = True
        Me.Position = -1

        
        Me.IsDiagnostic = False
        Me.StoreCsv = False
        Me.DataArrayIdx = -1
        Me.MeanInterval = 3600
        Me.Unit = String.Empty
        Me.Decimals = 1
        Me.Algorithm = ChannelAlgorithm.Average

        Me.Formule = "y=x"
        Me.ReadingsMinPercentage = 75

        Me.AllowedMinValue = Nothing
        Me.AllowedMaxValue = Nothing
        Me.AllowedMinVariance = Nothing
        Me.AllowedMaxVariance = Nothing

        
        Me.Readings = 0
        Me.ReadingsWrong = 0
        Me.LastRawValue = Nothing
        Me.LastValue = Nothing
        Me.TotalValue = Nothing
        Me.MeanValue = Nothing
        Me.MinValue = Nothing
        Me.MinTime = Nothing
        Me.MaxValue = Nothing
        Me.MaxTime = Nothing
        Me.StdDev = Nothing
        Me.Code = Nothing

        
        Me.MeanDone = False

        Me.Values = New List(Of Nullable(Of Single))

    End Sub

    Public Overrides Function ToString() As String
        Return Me.Name
    End Function

End Class






<System.Serializable()>
Public Class ClassChannelCommand
    Inherits ClassChannelBase
    Implements IComparable

    <Description("Comando da inviare al modulo"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property Command() As String

    <Description("Comando da inviare al modulo"),
    [ReadOnly](StatusPropReadOnly),
    Category("Principali")>
    Public Property Value() As Integer

    <Description("Data e ora invio comando"),
    [ReadOnly](StatusPropReadOnly),
     Category("Principali")>
    Public Property DateTime() As Date

    <Description("Ripeti il comando"),
    [ReadOnly](StatusPropReadOnly),
    Category("Principali")>
    Public Property Repeat() As Boolean

    <Description("Comando inviato"),
    [ReadOnly](StatusPropReadOnly),
     Category("Altri")>
    Public Property CommandSent() As Boolean

    Sub New()
        
        Me.ID = -1
        Me.Name = String.Empty
        Me.Active = False
        Me.Position = -1

        
        Me.Command = String.Empty
        Me.Value = Nothing
        Me.DateTime = Nothing
        Me.Repeat = False
        Me.CommandSent = False

    End Sub

    Public Overrides Function ToString() As String
        Return Me.Name
    End Function

End Class
