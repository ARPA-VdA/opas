Imports System.IO





Public Class ClassUtils

    
    
    
    
    
    
    Public Shared Sub LogMessage(ByVal msg As String, ByVal type As eMsgType)
        Try
            
            Dim Filename As String = GetLogFileName()
            Dim sType As String = ""
            Select Case type
                Case eMsgType.Info : sType = "INFO"
                Case eMsgType.Alert : sType = "ALERT"
                Case eMsgType.Errors : sType = "ERROR"
                Case eMsgType.Command : sType = "COMMAND"
                Case eMsgType.User : sType = "USER"
                Case eMsgType.Debug : sType = "DEBUG"
            End Select
            
            msg = String.Format("{0}: [{1}] {2}{3}", Now, sType, msg, ControlChars.CrLf)
            My.Computer.FileSystem.WriteAllText(Filename, msg, True, System.Text.Encoding.ASCII)
        Catch
        End Try
    End Sub

    
    
    
    
    
    Public Shared Sub LogExeption(ByVal ex As Exception)
        LogMessage(ex.Message, eMsgType.Errors)
        Debug.Print("ERROR")
    End Sub

    
    
    
    
    
    Public Shared Sub LogMessage(ByVal msg As String)
        LogMessage(msg, eMsgType.Info)
    End Sub

    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    

    Private Shared Function GetLogFileName() As String
        Try

            Dim FilePath As String = Path.Combine(Application.StartupPath, "log\" + Now.ToString("yyyyMM"))
            If Not My.Computer.FileSystem.DirectoryExists(FilePath) Then
                My.Computer.FileSystem.CreateDirectory(FilePath)
            End If

            Dim FileName As String = Path.Combine(FilePath, "Application-" + Now.ToString("yyyy-MM-dd") + ".log")
            Return FileName

        Catch ex As ArgumentException
            Return String.Empty
        End Try
    End Function

    
    
    
    
    Public Enum eMsgType As Integer
        Info = 0   
        Alert = 1  
        Errors = 2  
        User = 3   
        Command = 4 
        Debug = 5   
    End Enum

End Class
