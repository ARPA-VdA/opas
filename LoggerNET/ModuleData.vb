Imports System.Threading.Thread
Imports System
Imports System.Globalization
Imports System.Text.RegularExpressions
Imports System.IO.Ports
Imports NCalc
Imports Ecometer.ClassUtils
Imports Ecometer

Module ModuleData

#Region "MODULES DATA"

    Dim r As New Random

    Public Function Eval(ByVal Expression As String) As Nullable(Of Single)
        Try
            Dim Ret As Double = Double.NaN

            

            Dim e As Expression = New Expression(Expression)
            Ret = CDbl(e.Evaluate())
            Return CType(Ret, Single?)

        Catch ex As Exception
            Debug.Print(ex.Message)
            Return Nothing
        End Try
    End Function

    Public Function RegExprGetValue(ByVal Str As String, Reg As String) As Nullable(Of Single)
        Try
            Dim Value As Nullable(Of Single)
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Str)
            If match.Success Then
                Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                If match.Groups.Count = 1 Then
                    Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                    If IsNumeric(key) Then
                        Value = CType(key, Single?)
                    Else
                        Value = Nothing
                    End If
                Else
                    Value = Nothing
                End If
            Else
                Value = Nothing
            End If
            Return Value

        Catch ex As ArgumentException
            Return Nothing
        End Try        
    End Function

    Private Function SerialPortGetData(ComPort As SerialPort, Command As String, WaitFor As String, Timeout As Double) As String
        Try

            
            ClassUtils.LogMessage(String.Format("SerialPortGetData cmd: {0}", Command), eMsgType.Info)

            
            ClearBuffer(ComPort)

            
            ComPort.Write(Command)

            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = TimeToUnix() + Timeout 

            
            Do While TimeToUnix() < BeginTime 

                
                If ComPort.BytesToRead > 0 Then
                    
                    Res += ComPort.ReadExisting
                End If

                
                If Res.EndsWith(WaitFor) Then Exit Do

                Application.DoEvents()

            Loop

            
            If TimeToUnix() >= BeginTime Then
                ClassUtils.LogMessage(String.Format("Timeout, uncompleted data: {0}", Res), eMsgType.Alert)
                Return Nothing
            End If

            
            Debug.Print(Res)
            ClassUtils.LogMessage(String.Format("Raw data: {0}", Res), eMsgType.Debug)

            Return Res

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function SerialPortGetValueRegExp(ComPort As SerialPort, Command As String, WaitFor As String, Reg As String, Timeout As Double, Optional ClearPortBuffer As Boolean = True) As Single?
        Try

            
            ClassUtils.LogMessage(String.Format("SerialPortGetValue: {0}", Command), eMsgType.Info)

            
            If ClearPortBuffer Then ClearBuffer(ComPort)

            
            ComPort.WriteLine(Command)

            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = TimeToUnix() + Timeout 

            
            Do While TimeToUnix() < BeginTime 

                
                If ComPort.BytesToRead > 0 Then
                    
                    Res += ComPort.ReadExisting
                End If

                
                If Res.EndsWith(WaitFor) Then Exit Do

                Application.DoEvents()

            Loop

            
            If TimeToUnix() >= BeginTime Then
                ClassUtils.LogMessage(String.Format("Timeout, uncompleted data: {0}", Res), eMsgType.Alert)
                Return Nothing
            End If

            
            Debug.Print(Res)
            ClassUtils.LogMessage(String.Format("Raw data: {0}", Res), eMsgType.Debug)
            

            
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Res)
            If match.Success Then
                Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Return CType(key, Single?)
                Else
                    ClassUtils.LogMessage("Value not numeric, no data", eMsgType.Alert)
                    Return Nothing
                End If
            Else
                ClassUtils.LogMessage("RegExpess no match, no data", eMsgType.Alert)
                Return Nothing
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function SerialPortGetDataRegExp(ComPort As SerialPort, Command As String, WaitFor As String, Reg As String, Timeout As Double, Optional ClearPortBuffer As Boolean = True) As String
        Try

            
            ClassUtils.LogMessage("SerialPortGetDataRegExp", eMsgType.Info)

            
            If ClearPortBuffer Then ClearBuffer(ComPort)

            
            ClassUtils.LogMessage("WriteLine -> " + Command, eMsgType.Info)
            ComPort.WriteLine(Command)

            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = TimeToUnix() + Timeout 

            
            Do While TimeToUnix() < BeginTime 

                
                If ComPort.BytesToRead > 0 Then
                    
                    Res += ComPort.ReadExisting
                End If

                
                If Res.EndsWith(WaitFor) Then Exit Do

                Application.DoEvents()

            Loop

            
            If TimeToUnix() >= BeginTime Then
                ClassUtils.LogMessage(String.Format("Timeout, uncompleted data: {0}", Res), eMsgType.Alert)
                Return Nothing
            End If

            
            Debug.Print(Res)
            ClassUtils.LogMessage(String.Format("Raw data: {0}", Res), eMsgType.Debug)

            
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Res)
            If match.Success Then
                Return match.Groups(1).Value.Trim
            Else
                Return Nothing
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function SerialPortGetDataRegExpContain(ComPort As SerialPort, Command As String, Contain As String, Reg As String, Timeout As Double, Optional ClearPortBuffer As Boolean = True) As String
        Try

            
            ClassUtils.LogMessage("SerialPortGetText", eMsgType.Info)

            
            If ClearPortBuffer Then ClearBuffer(ComPort)

            
            ComPort.WriteLine(Command)

            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = TimeToUnix() + Timeout 

            
            Do While TimeToUnix() < BeginTime 

                
                If ComPort.BytesToRead > 0 Then
                    
                    Res += ComPort.ReadExisting
                End If

                
                If Res.Contains(Contain) Then Exit Do

                Application.DoEvents()

            Loop

            
            If TimeToUnix() >= BeginTime Then
                ClassUtils.LogMessage(String.Format("Timeout, uncompleted data: {0}", Res), eMsgType.Alert)
                Return Nothing
            End If

            
            Debug.Print(Res)
            ClassUtils.LogMessage(String.Format("Raw data: {0}", Res), eMsgType.Debug)

            
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Res)
            If match.Success Then
                Return match.Groups(1).Value.Trim
            Else
                Return Nothing
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Private Function SerialPortSendData(ComPort As SerialPort, Command As String, Sleep As Double) As Boolean
        Try

            
            ClassUtils.LogMessage(String.Format("SerialPortSendData cmd: {0}", Command), eMsgType.Info)

            
            ClearBuffer(ComPort)

            
            ComPort.Write(Command)

            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = TimeToUnix() + Sleep

            
            Do While TimeToUnix() < BeginTime
                Application.DoEvents()
            Loop

            Return True

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Private Sub ClearBuffer(COMPort As IO.Ports.SerialPort)
        Try

            
            

            Dim buffer As String
            Dim watch = Stopwatch.StartNew
            Do
                
                If COMPort.BytesToRead > 0 Then
                    buffer = COMPort.ReadExisting()
                End If

            Loop Until watch.ElapsedMilliseconds >= 500 Or COMPort.BytesToRead = 0

            
            
            

            
            

            
            
            
            
            

            

            

            
            

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Function TimeToUnix() As Long
        Dim epoch As New DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)
        Dim ms As Long = CLng((DateTime.Now - epoch).TotalMilliseconds)
        Return ms
    End Function

#End Region

#Region "API100"
    Public Function GetAPI100Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetAPI100Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T SO2" + vbCrLf
            Reg = "^T.+SO2=(.+)PPB" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetAPI100Diags(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetAPI100Diags..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T SAMPPRESS" + vbCrLf
            Reg = "^T.+PRES=(.+)\sIN-HG-A" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SAMPFLOW" + vbCrLf
            Reg = "^T.+FL=(.+)\sCC/M" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PMTDET" + vbCrLf
            Reg = "^T.+PMT=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T UVDET" + vbCrLf
            Reg = "^T.+LAMP=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SLOPE" + vbCrLf
            Reg = "^T.+SLOPE=(.+)" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T OFFSET" + vbCrLf
            Reg = "^T.+OFFSET=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T DCPS" + vbCrLf
            Reg = "^T.+DCPS=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T RCELLTEMP" + vbCrLf
            Reg = "^T.+RCELL TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T BOXTEMP" + vbCrLf
            Reg = "^T.+BOX TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PMTTEMP" + vbCrLf
            Reg = "^T.+PMT TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "API200"
    Public Function GetApi200Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi200Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T NOX" + vbCrLf
            Reg = "^T.+NOX=(.+)PPB" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T NO" + vbCrLf
            Reg = "^T.+NO=(.+)PPB" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T NO2" + vbCrLf
            Reg = "^T.+NO2=(.+)PPB" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetApi200Diags(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi200Diags..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T SAMPFLOW" + vbCrLf
            Reg = "^T.+SAMP FLW=(.+)\sCC/M" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T OZONEFLOW" + vbCrLf
            Reg = "^T.+OZONE FL=(.+)\sCC/M" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T RCELLTEMP" + vbCrLf
            Reg = "^T.+RCELL TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T BOXTEMP" + vbCrLf
            Reg = "^T.+BOX TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PMTTEMP" + vbCrLf
            Reg = "^T.+PMT TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T CONVTEMP" + vbCrLf
            Reg = "^T.+MOLY TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T RCELLPRESS" + vbCrLf
            Reg = "^T.+RCEL=(.+)\sIN-HG-A" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SAMPPRESS" + vbCrLf
            Reg = "^T.+SAMP=(.+)\sIN-HG-A" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T NOXSLOPE" + vbCrLf
            Reg = "^T.+NOX SLOPE=(.+)" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T NOXOFFSET" + vbCrLf
            Reg = "^T.+NOX OFFS=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T NOSLOPE" + vbCrLf
            Reg = "^T.+NO SLOPE=(.+)" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T NOOFFSET" + vbCrLf
            Reg = "^T.+NO OFFS=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "API300"
    Public Function GetAPI300Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetAPI300Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T CO" + vbCrLf
            Reg = "^T.+CO=(.+)PPM" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetAPI300Diags(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetAPI300Diags..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T COMEAS" + vbCrLf
            Reg = "^T.+CO MEAS=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T COREF" + vbCrLf
            Reg = "^T.+CO REF=(.+)\sMV" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T BENCHTEMP" + vbCrLf
            Reg = "^T.+BENCH TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T WHEELTEMP" + vbCrLf
            Reg = "^T.+WHEEL TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T BOXTEMP" + vbCrLf
            Reg = "^T.+BOX TEMP=(.+)\sC" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T MRRATIO" + vbCrLf
            Reg = "^T.+MR RATIO=(.+)" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T COSLOPE" + vbCrLf
            Reg = "^T.+SLOPE=(.+)" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T COOFFSET" + vbCrLf
            Reg = "^T.+OFFSET=(.+)" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SAMPFLOW" + vbCrLf
            Reg = "^T.+SAMP FL=(.+)\sCC/M" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "API400"
    Public Function GetApi400Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi400Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            
            

            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            

            Dim Timeout As Double = 2500
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            Command = "T O3" + vbCrLf
            Reg = "^T.*O3=(.*)PPB" 
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            Return Values

            

            
            

            
            
            

            

            
            

            
            
            
            
            

            
            

            

            

            
            
            
            
            
            
            
            
            

            

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function
    Public Function GetApi400ADiags(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi400ADiags..."), eMsgType.Info)

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 2500
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T PHOTOMEAS" + vbCrLf
            Reg = "^T.+MEAS=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOREF" + vbCrLf
            Reg = "^T.+REF=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T O3GENREF" + vbCrLf
            Reg = "^T.+GEN=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T O3GENDRIVE" + vbCrLf
            Reg = "^T.+DRIVE=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOSPRESS" + vbCrLf
            Reg = "^T.+PRES=(.+)\sIN-HG-A\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOSFLOW" + vbCrLf
            Reg = "^T.+SAMP FL=(.+)\sCC/M\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOSTEMP" + vbCrLf
            Reg = "^T.+SAMPLE TEMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOLTEMP" + vbCrLf
            Reg = "^T.+PHOTO LAMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T O3GENTEMP" + vbCrLf
            Reg = "^T.+O3 GEN TMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T BOXTEMP" + vbCrLf
            Reg = "^T.+BOX TEMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOSLOPE" + vbCrLf
            Reg = "^T.+SLOPE=(.+)\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOOFFSET" + vbCrLf
            Reg = "^T.+OFFSET=(.+)\sPPB\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetApi400EDiags(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi400EDiags..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 2500
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = "T PHOTOMEAS" + vbCrLf
            Reg = "^T.+MEAS=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOREF" + vbCrLf
            Reg = "^T.+REF=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T O3GENREF" + vbCrLf
            Reg = "^T.+GEN=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T O3GENDRIVE" + vbCrLf
            Reg = "^T.+DRIVE=(.+)\sMV\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SAMPPRESS" + vbCrLf
            Reg = "^T.+PRES=(.+)\sIN-HG-A\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SAMPFLOW" + vbCrLf
            Reg = "^T.+SAMP FL=(.+)\sCC/M\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SAMPTEMP" + vbCrLf
            Reg = "^T.+SAMPLE TEMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T PHOTOLTEMP" + vbCrLf
            Reg = "^T.+PHOTO LAMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T O3GENTEMP" + vbCrLf
            Reg = "^T.+O3 GEN TMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T BOXTEMP" + vbCrLf
            Reg = "^T.+BOX TEMP=(.+)\sC\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T SLOPE" + vbCrLf
            Reg = "^T.+SLOPE=(.+)\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = "T OFFSET" + vbCrLf
            Reg = "^T.+OFFSET=(.+)\sPPB\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function SendApi401Command(Mo As ClassModule, ChC As ClassChannelCommand) As Boolean
        Try

            
            ClassUtils.LogMessage("SendApi401Command", eMsgType.Info)

            
            ClearBuffer(Mo.SerialPortObj)

            
            Mo.SerialPortObj.WriteLine(ChC.Command + vbCrLf)

            Dim WaitFor As String = vbCrLf
            Dim Timeout As Integer = 1000
            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = Microsoft.VisualBasic.DateAndTime.Timer + (Timeout / 1000)

            
            Do While Microsoft.VisualBasic.DateAndTime.Timer < BeginTime 

                
                If Mo.SerialPortObj.BytesToRead > 0 Then
                    Debug.Print("Bytes to read: {0}", Mo.SerialPortObj.BytesToRead)
                    Res += Mo.SerialPortObj.ReadExisting
                End If

                
                If Res.EndsWith(WaitFor) Then Exit Do

                Application.DoEvents()

            Loop

            
            If Microsoft.VisualBasic.DateAndTime.Timer >= BeginTime Then
                Debug.Print("TIMEOUT !")
                ClassUtils.LogMessage("TIMEOUT", eMsgType.Alert)
            End If

            Debug.Print(Res)
            Return Res.Length > 0

        Catch ex As ArgumentException
            Return Nothing
        End Try
    End Function
    Public Function SetApi401Value(Mo As ClassModule, Command As String) As Boolean
        Try

            
            ClassUtils.LogMessage("SetApi401Value", eMsgType.Info)

            
            ClearBuffer(Mo.SerialPortObj)

            
            Mo.SerialPortObj.WriteLine(Command + vbCrLf)

            Dim WaitFor As String = vbCrLf
            Dim Timeout As Integer = 1000
            Dim BeginTime As Double
            Dim Res As String = String.Empty
            BeginTime = Microsoft.VisualBasic.DateAndTime.Timer + (Timeout / 1000)

            
            Do While Microsoft.VisualBasic.DateAndTime.Timer < BeginTime 

                
                If Mo.SerialPortObj.BytesToRead > 0 Then
                    Debug.Print("Bytes to read: {0}", Mo.SerialPortObj.BytesToRead)
                    Res += Mo.SerialPortObj.ReadExisting
                End If

                
                If Res.EndsWith(WaitFor) Then Exit Do

                Application.DoEvents()

            Loop

            
            If Microsoft.VisualBasic.DateAndTime.Timer >= BeginTime Then
                Debug.Print("TIMEOUT !")
                ClassUtils.LogMessage("TIMEOUT", eMsgType.Alert)
            End If

            Debug.Print(Res)
            Return Res.Length > 0

        Catch ex As ArgumentException
            Return Nothing
        End Try
    End Function
#End Region

#Region "API700"
    Friend Function GetApi700Values(mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi700Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If mo.SerialPortObj Is Nothing Then Return Values
            If Not mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Res As String
            Dim Value As Nullable(Of Single)

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            Command = "T TARGCONC" + vbCrLf
            
            

            
            

            
            

            Reg = "^T.+TARG=(.+)"
            
            
            
            
            
            
            

            Res = SerialPortGetDataRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            Select Case Res
                Case "STANDBY"
                    Values.Add(Nothing) 
                    Values.Add(Nothing) 

                Case "GENERATE ZERO"
                    Values.Add(0) 
                    Values.Add(0) 

                Case Else

                    Dim FoundData As Boolean = False

                    
                    Reg = "^GENERATE\s(.+)\sPPB\sO3"
                    Dim regex As Regex = New Regex(Reg)
                    Dim match As Match = regex.Match(Res)
                    If match.Success Then
                        
                        FoundData = True
                        Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                        Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Value = CType(key, Single?)
                        Else
                            Value = Nothing
                        End If
                    End If
                    
                    If FoundData = True Then
                        Values.Add(Value) 
                        Values.Add(Nothing) 
                        Exit Select
                    Else
                        Values.Add(Nothing) 
                        Values.Add(Nothing) 
                    End If

                    
                    Reg = "^GENERATE\s(.+)\sPPB\sNO"
                    regex = New Regex(Reg)
                    match = regex.Match(Res)
                    If match.Success Then
                        
                        FoundData = True
                        Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                        Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Value = CType(key, Single?)
                        Else
                            Value = Nothing
                        End If
                    End If
                    
                    If FoundData = True Then
                        Values.Add(Nothing) 
                        Values.Add(Value) 
                        Exit Select
                    Else
                        Values.Add(Nothing) 
                        Values.Add(Nothing) 
                    End If

                    
                    
                    Reg = "^GPT\s(.+)\sPPB\sNO,(.+)\sPPB\sO3"
                    regex = New Regex(Reg)
                    match = regex.Match(Res)
                    If match.Success Then
                        
                        FoundData = True
                        Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                        Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Values.Add(CType(key, Single?)) 
                        Else
                            Values.Add(Nothing) 
                        End If

                        key = match.Groups(2).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Values.Add(CType(key, Single?)) 
                        Else
                            Values.Add(Nothing) 
                        End If

                    End If
                    
                    If FoundData = True Then
                        Exit Select
                    Else
                        Values.Add(Nothing) 
                        Values.Add(Nothing) 
                    End If

            End Select

            
            Command = "T ACTCONC" + vbCrLf
            Reg = "^T.+ACT=(.+)"
            
            
            
            
            
            
            Res = SerialPortGetDataRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            Select Case Res
                Case "STANDBY"
                    Values.Add(Nothing) 
                    Values.Add(Nothing) 

                Case "GENERATE ZERO"
                    Values.Add(0) 
                    Values.Add(0) 

                Case Else

                    Dim FoundData As Boolean = False

                    
                    Reg = "^GENERATE\s(.+)\sPPB\sO3"
                    Dim regex As Regex = New Regex(Reg)
                    Dim match As Match = regex.Match(Res)
                    If match.Success Then
                        
                        FoundData = True
                        Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                        Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Value = CType(key, Single?)
                        Else
                            Value = Nothing
                        End If
                    End If
                    
                    If FoundData = True Then
                        Values.Add(Value) 
                        Values.Add(Nothing) 
                        Exit Select
                    Else
                        Values.Add(Nothing) 
                        Values.Add(Nothing) 
                    End If

                    
                    Reg = "^GENERATE\s(.+)\sPPB\sNO"
                    regex = New Regex(Reg)
                    match = regex.Match(Res)
                    If match.Success Then
                        
                        FoundData = True
                        Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                        Dim key As String = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Value = CType(key, Single?)
                        Else
                            Value = Nothing
                        End If
                    End If
                    
                    If FoundData = True Then
                        Values.Add(Nothing) 
                        Values.Add(Value) 
                        Exit Select
                    Else
                        Values.Add(Nothing) 
                        Values.Add(Nothing) 
                    End If

                    
                    
                    
                    
                    Reg = "^GPT\s(.+)\sPPB\sNO,(.+)\sPPB\sO3"
                    regex = New Regex(Reg)
                    match = regex.Match(Res)
                    If match.Success Then
                        
                        FoundData = True
                        Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat

                        Dim key = match.Groups(2).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Values.Add(CType(key, Single?)) 
                        ElseIf key = "XXXX" Then
                            Values.Add(Nothing) 
                        Else
                            Values.Add(Nothing) 
                        End If

                        key = match.Groups(1).Value.Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                        If IsNumeric(key) Then
                            Values.Add(CType(key, Single?)) 
                        Else
                            Values.Add(Nothing) 
                        End If

                    End If
                    
                    If FoundData = True Then
                        Exit Select
                    Else
                        Values.Add(Nothing) 
                        Values.Add(Nothing) 
                    End If
            End Select





            
            
            Command = "T TARGCALFLOW" + vbCrLf
            Reg = "^T.+ACT=(.+)" 
            Res = SerialPortGetDataRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            If IsNumeric(Res) Then
                Value = CType(Res, Single?)
            Else
                Select Case Res
                    Case "STANDBY"
                        Value = Nothing
                    Case Else
                        Value = 10000
                End Select

            End If
            Values.Add(Value)

            
            
            Command = "T ACTCALFLOW" + vbCrLf
            Reg = "^T.+ACT=(.+)" 
            Res = SerialPortGetDataRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            If IsNumeric(Res) Then
                Value = CType(Res, Single?)
            Else
                Select Case Res
                    Case "STANDBY"
                        Value = Nothing
                    Case Else
                        Value = 10000
                End Select

            End If
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region


#Region "SM200"
    Friend Function GetSM200Values(mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetSM200Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If mo.SerialPortObj Is Nothing Then Return Values
            If Not mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCr
            Dim Reg As String
            Dim Res As String
            

            
            Dim pos As Nullable(Of Single)
            Command = "#206" + vbCr
            Reg = "^#206,(.+),.+,.+,.+,.+" 
            pos = SerialPortGetValueRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            If pos Is Nothing Then
                Return Nothing
            End If

            
            Command = "#207" + String.Format("{0:00000}", pos) + vbCr
            Reg = "^#207(.+)"
            Res = SerialPortGetDataRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            If Res Is Nothing Then
                Return Nothing
            End If
            Dim ValueArr As String()
            ValueArr = Res.Split(CType(",", Char()))
            If ValueArr.Length = 30 Then

                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                

                
                For index As Integer = 3 To 3

                    Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                    Dim key As String = ValueArr(index).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                    If IsNumeric(key) Then
                        Values.Add(CType(key, Single?))
                    Else
                        Values.Add(Nothing)
                    End If
                Next

                
                For index As Integer = 7 To 28

                    Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
                    Dim key As String = ValueArr(index).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                    If IsNumeric(key) Then
                        Values.Add(CType(key, Single?))
                    Else
                        Values.Add(Nothing)
                    End If
                Next

            Else
                
                
                
                
                Return Nothing

            End If

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Friend Function GetSM200BHPValues(mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetSM200BHPValues..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If mo.SerialPortObj Is Nothing Then Return Values
            If Not mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 2000
            Dim Command As String
            Dim WaitFor As String = ChrW(3)
            Dim Reg As String
            Dim Res As String
            

            
            
            
            Command = ChrW(2) + "DA" + ChrW(3) + "04"
            Reg = "M\w16\s(.*)"
            Res = SerialPortGetDataRegExpContain(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            Debug.Print(Res)

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            Reg = "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}.*"

            
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Res)
            If match.Success Then
                Debug.Print(match.Groups(1).Value.Trim)

                Values.Add(CSng(match.Groups(2).Value.Trim))
                Values.Add(CSng(match.Groups(5).Value.Trim))
                Values.Add(CSng(match.Groups(8).Value.Trim))
                Values.Add(CSng(match.Groups(11).Value.Trim))
                Values.Add(CSng(match.Groups(14).Value.Trim))
                Values.Add(CSng(match.Groups(17).Value.Trim))
                Values.Add(CSng(match.Groups(20).Value.Trim))
                Values.Add(CSng(match.Groups(23).Value.Trim))
                Values.Add(CSng(match.Groups(26).Value.Trim))
                Values.Add(CSng(match.Groups(29).Value.Trim))
                Values.Add(CSng(match.Groups(32).Value.Trim))
                Values.Add(CSng(match.Groups(35).Value.Trim))
                Values.Add(CSng(match.Groups(38).Value.Trim))
                Values.Add(CSng(match.Groups(41).Value.Trim))
                Values.Add(CSng(match.Groups(44).Value.Trim))
                Values.Add(CSng(match.Groups(47).Value.Trim))

            Else
                Return Nothing
            End If

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "TEOM1400a"
    Public Function GetTEOM1400aValues(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetTEOM1400aValues..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            
            

            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 500
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            
            
            
            
            
            
            
            

            
            
            Command = ChrW(2) + "4AREG K0 8" + ChrW(3) + vbCrLf
            

            
            Reg = "^\x024AREG . 8 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetTEOM1400aDiags(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetTEOM1400aDiags..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            
            

            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 500
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = ChrW(2) + "4AREG K0 35" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 35 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 39" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 39 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 40" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 40 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 12" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 12 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 13" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 13 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 25" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 25 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 26" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 26 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 27" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 27 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            
            Command = ChrW(2) + "4AREG K0 41" + ChrW(3) + vbCrLf
            Reg = "^\x024AREG \d 41 (.+)\x03\r\n"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            Values.Add(Value)

            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "CG955"

    Friend Function GetGC955Values(mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetGC955Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If mo.SerialPortObj Is Nothing Then Return Values
            If Not mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 1800
            Dim Command As String
            Dim WaitFor As String = ChrW(15)
            Dim Res As String

            Dim GC955_NODATA As String = "No data"

            
            Command = "LL" + vbCr
            Res = SerialPortGetData(mo.SerialPortObj, Command, WaitFor, Timeout)
            
            If Res Is Nothing Then
                ClassUtils.LogMessage(String.Format("No data"), eMsgType.Errors)
                Return Nothing
            End If
            
            
            
            
            
            
            
            If Res.Contains(GC955_NODATA) Then
                ClassUtils.LogMessage(String.Format("Response contain no data"), eMsgType.Errors)
                Return Nothing
            End If

            
            Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat
            Dim key As String

            Dim ValueArr As String()
            ValueArr = Res.Split(CType(vbTab, Char()))
            ClassUtils.LogMessage(String.Format("Checking data array: {0}", ValueArr.Length), eMsgType.Errors)

            
            If ValueArr.Length = 12 Then
                
                

                
                key = ValueArr(3).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(4).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(5).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                
                key = ValueArr(7).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(8).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(9).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(10).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

            ElseIf ValueArr.Length = 18 Then
                
                

                
                key = ValueArr(3).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(6).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(9).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                
                key = ValueArr(13).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(14).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(15).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

                
                key = ValueArr(16).Trim.Replace(".", nfi.NumberDecimalSeparator.ToString)
                If IsNumeric(key) Then
                    Values.Add(CType(key, Single?))
                Else
                    Values.Add(Nothing)
                End If

            End If

            
            

            
            
            
            
            
            
            
            
            
            

            

            
            
            
            
            
            
            
            
            
            
            
            
            

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function


#End Region

#Region "MCZ"
    Friend Function GetMCZValues(mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetMCZValues..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If mo.SerialPortObj Is Nothing Then Return Values
            If Not mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 2000
            Dim Command As String
            Dim WaitFor As String = vbCr
            Dim Reg As String
            Dim Res As String
            Dim Value As Nullable(Of Single)

            
            
            
            Command = "DA" + vbCr
            Reg = "MD10(.*)"
            Res = SerialPortGetDataRegExp(mo.SerialPortObj, Command, WaitFor, Reg, Timeout)
            
            Debug.Print(Res)

            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
            
            

            Reg = "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}\s"
            Reg += "(\d{3})\s(\-?\+?\d{4})(\+\-?\+?\d{2})\s\d{2}\s\d{2}\s\d{3}\s\d{6}.*"

            
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Res)
            If match.Success Then
                Debug.Print(match.Groups(1).Value.Trim)

                Value = CType(match.Groups(2).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 100
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(5).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 100
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(8).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 10
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(11).Value.Trim, Single?) 
                If Value.HasValue Then
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(14).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 10
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(17).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 100
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(20).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 1000
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(23).Value.Trim, Single?) 
                If Value.HasValue Then
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(26).Value.Trim, Single?) 
                If Value.HasValue Then
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

                Value = CType(match.Groups(29).Value.Trim, Single?) 
                If Value.HasValue Then
                    Value = Value / 1000
                    Values.Add(Value)
                Else
                    Values.Add(Nothing)
                End If

            Else
                Return Nothing
            End If

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "HORIBA370"

    Public Function GetHoriba370Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetHoriba370Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1000
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Reg As String
            Dim Res As String
            Dim Value As Nullable(Of Single)

            

            
            Command = ChrW(2) + "DA" + ChrW(13)
            Reg = "(.*)" 
            Res = SerialPortGetDataRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout)

            
            Reg = ".+MD\d\d\s"
            Reg += "011\s([-+]?\d\d\d\d)([-+]?\d\d)\s(\d\d)\s(\d\d)\s\d\d\d\s000000\s"
            Reg += "012\s([-+]?\d\d\d\d)([-+]?\d\d)\s(\d\d)\s(\d\d)\s\d\d\d\s000000\s"
            Reg += "013\s([-+]?\d\d\d\d)([-+]?\d\d)\s(\d\d)\s(\d\d)\s\d\d\d\s000000"

            
            
            
            

            
            
            
            

            
            
            
            

            
            Dim regex As Regex = New Regex(Reg)
            Dim match As Match = regex.Match(Res)
            If match.Success Then
                Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat

                
                Dim key As String = match.Groups(1).Value.Trim
                Dim exp As String = match.Groups(2).Value.Trim
                If IsNumeric(key) And IsNumeric(exp) Then
                    Value = CType(CDbl(key) * 10 ^ CInt(exp), Single?)
                Else
                    Value = Nothing
                End If
                Values.Add(Value)

                
                key = match.Groups(5).Value.Trim
                exp = match.Groups(6).Value.Trim
                If IsNumeric(key) And IsNumeric(exp) Then
                    Value = CType(CDbl(key) * 10 ^ CInt(exp), Single?)
                Else
                    Value = Nothing
                End If
                Values.Add(Value)

                
                key = match.Groups(9).Value.Trim
                exp = match.Groups(10).Value.Trim
                If IsNumeric(key) And IsNumeric(exp) Then
                    Value = CType(CDbl(key) * 10 ^ CInt(exp), Single?)
                Else
                    Value = Nothing
                End If
                Values.Add(Value)

            Else
                Value = Nothing
                Values.Add(Value)
                Values.Add(Value)
                Values.Add(Value)
            End If

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "PAS2000"

    Public Function GetPAS2000Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi200Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            
            
            
            
            

            Dim Timeout As Double = 1500
            Dim Command As String
            Dim WaitFor As String
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            Command = Nothing
            WaitFor = "*"
            
            Reg = "\s?(-?\d{1,4})\*$"
            Value = SerialPortGetValueRegExp(Mo.SerialPortObj, Command, WaitFor, Reg, Timeout, False)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

#End Region

#Region "VaisalaWXT510"
    Public Function GetVaisalaWXT510Values(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetApi200Values..."), eMsgType.Info)

            Dim Values = New List(Of Single?)

            
            
            If Debugger.IsAttached Then
                Values.Add(CType(r.Next(0, 10) / 10, Single?))
                Values.Add(CType(r.Next(0, 100) / 10, Single?))
                Values.Add(CType(r.Next(0, 100) / 10, Single?))
                Values.Add(CType(r.Next(0, 1000) / 10, Single?))
                Values.Add(CType(r.Next(0, 100) / 10, Single?))
                Values.Add(CType(r.Next(0, 100) / 10, Single?))
                Values.Add(CType(r.Next(0, 200) / 10, Single?))
                Values.Add(CType(r.Next(0, 100) / 10, Single?))
                Return Values
            End If

            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values


            Dim Timeout As Double = 1500
            Dim Command As String
            Dim WaitFor As String = vbCrLf
            Dim Res As String
            Dim Reg As String
            Dim Value As Nullable(Of Single)

            
            
            
            
            

            
            Command = Mo.Address + "R1!" + vbCrLf
            Res = SerialPortGetData(Mo.SerialPortObj, Command, WaitFor, Timeout)
            
            ClassUtils.LogMessage(String.Format("Res [R1!]: {0}", Res), eMsgType.User)
            
            Reg = ".+,Sn=(-?\d+\.*\d*)[A-Z]"
            Value = RegExprGetValue(Res, Reg)
            Values.Add(Value)
            
            Reg = ".+,Sm=(-?\d+\.*\d*)[A-Z]"
            Value = RegExprGetValue(Res, Reg)
            Values.Add(Value)
            
            Reg = ".+,Sx=(-?\d+\.*\d*)[A-Z]"
            Value = RegExprGetValue(Res, Reg)
            Values.Add(Value)
            
            Reg = ".+,Dn=(-?\d+\.*\d*)[A-Z]"
            Value = RegExprGetValue(Res, Reg)
            Values.Add(Value)
            
            Reg = ".+,Dm=(-?\d+\.*\d*)[A-Z]"
            Value = RegExprGetValue(Res, Reg)
            Values.Add(Value)
            
            Reg = ".+,Dx=(-?\d+\.*\d*)[A-Z]"
            Value = RegExprGetValue(Res, Reg)
            Values.Add(Value)

            
            

            
            
            

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function
#End Region

#Region "Silena"

    Public Function GetSilena600CEValues(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetSilena600CEValues..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            
            

            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 2500
            Dim Command As String
            Dim WaitFor As String = ChrW(3)
            Dim Value As Nullable(Of Single)
            Dim sValue As String

            
            Dim sMsg(3) As String
            
            sMsg(0) = ChrW(2) + "7001A@30" + ChrW(3)
            sMsg(1) = ChrW(2) + "7001CI3B" + ChrW(3)
            sMsg(2) = ChrW(2) + "7001F" + ChrW(6) + "71" + ChrW(3)
            sMsg(3) = ChrW(2) + "7001H" + ChrW(6) + "7F" + ChrW(3)
            

            
            
            
            For i As Integer = 0 To 1
                
                
                Command = sMsg(i) + ChrW(13) + ChrW(10)
                

                
                
                sValue = SerialPortGetData(Mo.SerialPortObj, Command, WaitFor, Timeout)
                ClassUtils.LogMessage(String.Format("sValue: {0}", sValue), eMsgType.Debug)

                
                If Len(sValue) < 10 Or Mid(sValue, 7, 1) <> ChrW(6) Then
                    
                    
                    Command = sMsg(3) + ChrW(13) + ChrW(10)
                    SerialPortSendData(Mo.SerialPortObj, Command, 100)
                    Return Values
                End If
            Next i

            
            
            
            
            
            Command = sMsg(2) + ChrW(13) + ChrW(10)
            

            
            
            sValue = SerialPortGetData(Mo.SerialPortObj, Command, WaitFor, Timeout)
            ClassUtils.LogMessage(String.Format("sValue: {0}", sValue), eMsgType.Debug)

            
            If Mid$(sValue, 7, 1) <> "I" Or Mid$(sValue, 19, 1) <> "M" Then
                
                
                Command = sMsg(3) + ChrW(13) + ChrW(10)
                SerialPortSendData(Mo.SerialPortObj, Command, 100)
                Return Values
            End If

            
            
            
            Command = sMsg(3) + ChrW(13) + ChrW(10)
            SerialPortSendData(Mo.SerialPortObj, Command, 100)
            

            
            
            Value = CType(Val(Mid(sValue, 9, 8)), Single?)
            Values.Add(Value)

            
            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Public Function GetSilenaValues(Mo As ClassModule) As List(Of Single?)
        Try

            ClassUtils.LogMessage(String.Format("GetSilenaValues..."), eMsgType.Info)

            Dim Values = New List(Of Single?)
            
            

            If Mo.SerialPortObj Is Nothing Then Return Values
            If Not Mo.SerialPortObj.IsOpen Then Return Values

            Dim Timeout As Double = 2500
            Dim Command As String
            Dim WaitFor As String = ChrW(3)
            Dim Reg As String
            Dim Value As Nullable(Of Single)
            Dim sValue As String
            Dim sOut As String
            Dim sCrc As String

            
            sOut = "001MI"
            sCrc = Checksum(sOut)

            
            Command = ChrW(2 + 128) + ChrW(48 + 128) + ChrW(49 + 128) + sOut + sCrc + ChrW(3) + ChrW(13)
            
            

            
            sValue = SerialPortGetData(Mo.SerialPortObj, Command, WaitFor, Timeout)
            ClassUtils.LogMessage(String.Format("sValue: {0}", sValue), eMsgType.Debug)

            
            
            

            

            
            If sValue.Length > 0 Then
                
                
                Reg = ".+MIK(.+)(..)"

                
                Dim regex As Regex = New Regex(Reg)
                Dim match As Match = regex.Match(sValue)
                If match.Success Then
                    Dim nfi As NumberFormatInfo = New CultureInfo("it-IT", False).NumberFormat

                    
                    Dim key As String = match.Groups(1).Value.Trim
                    If IsNumeric(key) Then
                        value = CType(CDbl(key), Single?)
                    Else
                        value = Nothing
                    End If
                    Values.Add(value)
                Else
                    Return Values
                End If

            Else
                Return Values
            End If

            Return Values

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function Checksum(buffer As String) As String
        Dim i As Integer
        Dim CRC As Integer

        On Error Resume Next

        CRC = 0

        For i = 1 To Len(buffer)
            CRC = CRC Xor Asc(Mid(buffer, i, 1))
        Next i

        Checksum = Hex(CRC)
    End Function

    
    
    

    
    
    
    
    
    

#End Region

#Region "Enums"

    Friend Enum EnumChannelCode As Integer
        VALID = 0
        MIN_READING_PERC = 32
        
        
        
        
        
        
        
        
        
        
    End Enum

    Friend Enum EnumStationAlarm As Integer
        VALID = 0
        
        
        
        
        
        
        
    End Enum

#End Region

End Module
