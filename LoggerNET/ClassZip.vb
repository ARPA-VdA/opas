Imports Ionic.Zip

Public Class ClassZip

    Public Property ZipFileName() As String

    Public Function AddFile(ByVal fileName As String) As Boolean
        Try

            If ZipFileName = String.Empty Then Return False


            If My.Computer.FileSystem.FileExists(ZipFileName) Then

                Using zip As ZipFile = ZipFile.Read(ZipFileName)
                    zip.AddFile(fileName, String.Empty)
                    zip.Save()
                End Using

            Else

                Using zip As ZipFile = New ZipFile
                    zip.AddFile(fileName, String.Empty)
                    zip.Save(ZipFileName)
                End Using

            End If

            Return True


        Catch ex As Exception
            
            ClassUtils.LogExeption(ex)
            Return False
        End Try

    End Function

End Class
