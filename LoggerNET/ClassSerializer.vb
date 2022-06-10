Imports System.Xml
Imports System.IO
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Converters

Public Class ClassSerializer

    Public Function SerializeLoggerXml(ByVal MyObject As ClassLogger, ByVal myXmlFile As String) As Boolean
        Try

            
            If My.Computer.FileSystem.FileExists(myXmlFile) Then
                My.Computer.FileSystem.DeleteFile(myXmlFile,
                FileIO.UIOption.OnlyErrorDialogs, FileIO.RecycleOption.DeletePermanently)
            End If

            
            Dim Serializer As New Serialization.XmlSerializer(GetType(ClassLogger))
            Dim DataFile As New FileStream(myXmlFile, FileMode.Create, FileAccess.Write, FileShare.None)

            Serializer.Serialize(DataFile, MyObject)
            DataFile.Close()
            MyObject = Nothing
            Return True

        Catch ex As Exception
            
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function DeSerializeLoggerXml(ByVal fileName As String) As ClassLogger
        Try

            
            If Not My.Computer.FileSystem.FileExists(fileName) Then Return Nothing

            Dim Log As New ClassLogger

            
            Dim Deserializer As New Serialization.XmlSerializer(GetType(ClassLogger))
            Dim DataFile As New FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.None)

            Log = CType(Deserializer.Deserialize(DataFile), ClassLogger)
            DataFile.Close()
            DataFile = Nothing

            Return Log

        Catch ex As Exception
            
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function


    Public Function SerializeLoggerJson(ByVal LG As ClassLogger, ByVal JsonFilePath As String) As Boolean
        Try

            
            If My.Computer.FileSystem.FileExists(JsonFilePath) Then
                My.Computer.FileSystem.DeleteFile(JsonFilePath,
                FileIO.UIOption.OnlyErrorDialogs, FileIO.RecycleOption.DeletePermanently)
            End If

            
            
            
            

            Dim serialized = JsonConvert.SerializeObject(LG, Newtonsoft.Json.Formatting.Indented)
            My.Computer.FileSystem.WriteAllText(JsonFilePath, serialized, True)

            LG = Nothing
            Return True

        Catch ex As Exception
            
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function DeSerializeLoggerJson(ByVal JsonFilePath As String) As ClassLogger
        Try

            
            If Not My.Computer.FileSystem.FileExists(JsonFilePath) Then Return Nothing

            
            
            
            

            
            Dim LG As New ClassLogger
            Using file__1 As StreamReader = File.OpenText(JsonFilePath)
                Dim serializer As New JsonSerializer()
                LG = DirectCast(serializer.Deserialize(file__1, GetType(ClassLogger)), ClassLogger)
            End Using

            Return LG

        Catch ex As Exception
            
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

End Class

