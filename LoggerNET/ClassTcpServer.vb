Imports System.Net
Imports System.Threading
Imports System.Text
Imports System.Text.RegularExpressions
Imports System.Net.Sockets

Public Class ClassTcpServer

    Dim listenThread As Thread
    Dim serverSocket As System.Net.Sockets.TcpListener
    Dim ipLocalEndPoint As System.Net.IPEndPoint

    Public Sub ServerStart()
        Try

            ClassUtils.LogMessage("TCP socket server starting...")


            Dim hostName As String = System.Net.Dns.GetHostName()
            Dim host As IPHostEntry = Dns.GetHostEntry(hostName)
            
            Dim ipAddress As System.Net.IPAddress = host.AddressList(0)
            ClassUtils.LogMessage("TCP listen on address: " + ipAddress.ToString)

            ipLocalEndPoint = New System.Net.IPEndPoint(ipAddress, 11000)
            listenThread = New Thread(New ThreadStart(AddressOf ListenForClients))
            listenThread.Start()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Private Sub ListenForClients()
        Try

            ClassUtils.LogMessage("TCP socket listen for clients...")

            serverSocket = New TcpListener(ipLocalEndPoint)
            serverSocket.Start()
            While True 
                Dim client As TcpClient = Me.serverSocket.AcceptTcpClient()
                Dim clientThread As New Thread(New ParameterizedThreadStart(AddressOf HandleClientComm))
                clientThread.Start(client)
            End While

        Catch ex As Exception
        End Try
    End Sub

    Private Sub HandleClientComm(ByVal client As Object)
        Try

            Dim tcpClient As TcpClient = DirectCast(client, TcpClient)
            Dim clientStream As NetworkStream = tcpClient.GetStream()

            Dim message As Byte() = New Byte(4095) {}
            Dim bytesRead As Integer

            While True
                bytesRead = 0
                bytesRead = clientStream.Read(message, 0, 4096) 

                If bytesRead = 0 Then
                    Exit While 
                End If

                Dim StringMessage As String = Encoding.ASCII.GetString(message)
                

                Dim m As Match = Regex.Match(StringMessage,
                     "<SOT>(.*)\|(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)\|(\d\d)<EOT>",
                     RegexOptions.IgnoreCase)

                If (m.Success) Then
                    Dim Command As String = m.Groups(1).Value
                    Select Case Command
                        Case "SET-TIME"

                            Dim dd As DateTime
                            dd = TimeSerial(CInt(m.Groups(5).Value), CInt(m.Groups(6).Value), CInt(m.Groups(7).Value))

                            
                            If IsDate(dd) Then
                                ClassUtils.LogMessage("TCP setting system date to: " + dd.ToLongTimeString)
                                Microsoft.VisualBasic.TimeOfDay = dd
                                
                                SendResponse(clientStream, "ACK")
                            Else
                                ClassUtils.LogMessage("TCP date time not valid!")
                                
                                SendResponse(clientStream, "NAK")
                            End If

                    End Select

                Else
                    ClassUtils.LogMessage("TCP received data not valid!")
                    
                    SendResponse(clientStream, "NAK")
                End If

            End While

            
            ClassUtils.LogExeption(New Exception("TCP client close"))
            tcpClient.Close()
            tcpClient = Nothing

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Public Sub ServerStop()
        Try

            ClassUtils.LogMessage("TCP listen thread stopping...")
            If Me.listenThread IsNot Nothing Then
                If listenThread.ThreadState = Threading.ThreadState.Running Then
                    Me.listenThread.Abort()
                End If
                Me.listenThread = Nothing
            End If


            ClassUtils.LogMessage("TCP socket server stopping...")
            If Me.serverSocket IsNot Nothing Then
                Me.serverSocket.Server.Close()
                Me.serverSocket.Stop()
                
                Me.serverSocket = Nothing
            End If

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        Finally
            ClassUtils.LogMessage("TCP socket server stopped")
        End Try
    End Sub

    Private Sub SendResponse(ClientStream As NetworkStream, Message As String)
        Try

            
            Dim encoder As New ASCIIEncoding()
            Dim serverResponse As String = Message
            Dim sendBytes As [Byte]() = Encoding.ASCII.GetBytes(serverResponse)
            ClientStream.Write(sendBytes, 0, sendBytes.Length)

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

End Class
