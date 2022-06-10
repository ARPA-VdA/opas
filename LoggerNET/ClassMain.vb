Imports System.IO
Imports System.Runtime.Serialization
Imports System.Runtime.Serialization.Formatters.Binary
Imports IniParser
Imports IniParser.Model
Imports Newtonsoft.Json





Public Class ClassMain

    
    
    
    
    Public LG As ClassLogger
    Public ConfigFileName As String
    Public AppFullScreen As Boolean
    Public LogWindowsVisible As Boolean
    Public Title As String
    Public FileIniPath As String

    
    
    
    Public FilesDataDatPath As String
    Public FilesDataCsvPath As String
    Public FilesInstCsvPath As String


    Public Sub New()
        Try
            LG = New ClassLogger
        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    
    
    
    
    Public Sub StartUp()

        Try

            
            Dim FormSplashScreen As New FormSplashScreen
            FormSplashScreen.TopMost = True
            FormSplashScreen.ProgressBar.Maximum = 100
            FormSplashScreen.Show()

            
            ClassUtils.LogMessage("Inizio fase startup")
            ClassUtils.LogMessage("Creazione directory...")
            FormSplashScreen.JobProgress.Text = "Creazione directory..."
            FormSplashScreen.ProgressBar.Value = 25
            Application.DoEvents()
            Threading.Thread.Sleep(50)
            Application.DoEvents()
            
            If Not CreatePaths() Then End

            
            ClassUtils.LogMessage("Lettura file ini...")
            FormSplashScreen.JobProgress.Text = "Lettura file ini..."
            FormSplashScreen.ProgressBar.Value = 50
            Application.DoEvents()
            Threading.Thread.Sleep(50)
            Application.DoEvents()
            
            If Not LoadAppConfiguration() Then End

            
            ClassUtils.LogMessage("Lettura file di configurazione del logger...")
            FormSplashScreen.JobProgress.Text = "Lettura file di configurazione del logger..."
            FormSplashScreen.ProgressBar.Value = 75
            Application.DoEvents()
            Threading.Thread.Sleep(50)
            Application.DoEvents()
            
            Dim FullConfigFileName As String
            FullConfigFileName = Path.Combine(My.Application.Info.DirectoryPath, "config\" + ConfigFileName)
            
            If Not My.Computer.FileSystem.FileExists(FullConfigFileName) Then
                ClassUtils.LogExeption(New Exception(String.Format("Il file di configurazione {0} non esiste", FullConfigFileName)))
                FormSplashScreen.JobProgress.Text = String.Format("Il file di configurazione non esiste!")
                Application.DoEvents()
                Threading.Thread.Sleep(1000)
                End
            End If
            LG = LoggerDeserializeJson(FullConfigFileName)
            If LG Is Nothing Then
                FormSplashScreen.JobProgress.Text = String.Format("Impossibile leggere il file di configurazione!")
                Application.DoEvents()
                Threading.Thread.Sleep(1000)
                End
            End If

            
            ClassUtils.LogMessage("Fine fase startup")
            FormSplashScreen.JobProgress.Text = "Attività eseguita."
            Application.DoEvents()
            FormSplashScreen.ProgressBar.Value = 100
            Threading.Thread.Sleep(100)
            Application.DoEvents()
            FormSplashScreen.ProgressBar.Refresh()
            Application.DoEvents()
            Threading.Thread.Sleep(400)
            Application.DoEvents()

            FormSplashScreen.Hide()
            FormSplashScreen.Dispose()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    
    
    
    
    
    Function LoadAppConfiguration() As Boolean
        Dim IniFilename As String

        Try
            
            If FileIniPath = String.Empty Then
                IniFilename = Path.Combine(My.Application.Info.DirectoryPath, Application.ProductName + ".ini")
            Else
                IniFilename = FileIniPath
            End If

            
            If Not My.Computer.FileSystem.FileExists(IniFilename) Then
                MessageBox.Show("Il file di configurazione non esiste!" +
                        ControlChars.CrLf + "L
                        "Errore", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)

                
                ClassUtils.LogMessage(String.Format("Il file di configurazione {0} non esiste!", IniFilename))
                Return False
            End If


            Dim parser = New FileIniDataParser()
            Dim data As IniData = parser.ReadFile(IniFilename)

            
            Me.Title = data("Opzioni")("titolo")

            
            If data("Logger")("configurazione") Is Nothing Then
                ClassUtils.LogExeption(New Exception("Ini file non valido, manca voce [configurazione]"))
                ConfigFileName = Nothing
            Else
                ConfigFileName = data("Logger")("configurazione")
            End If

            
            If data("Logger")("schermo-intero") Is Nothing Then
                ClassUtils.LogExeption(New Exception("Ini file non valido, manca voce [schermo-intero]"))
                AppFullScreen = True
            Else
                AppFullScreen = CBool(data("Logger")("schermo-intero"))
            End If

            
            If data("Logger")("finestra-eventi") Is Nothing Then
                ClassUtils.LogExeption(New Exception("Ini file non valido, manca voce [finestra-eventi]"))
                LogWindowsVisible = True
            Else
                LogWindowsVisible = CBool(data("Logger")("finestra-eventi"))
            End If

            Return True

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            ClassUtils.LogExeption(New Exception("Ini file non valido!"))
            Return False
        End Try

    End Function

    Sub LoggerConfigJsonSaveAs(ByVal LG As ClassLogger)
        Try

            
            Dim objSaveFileDialog As New SaveFileDialog

            
            With objSaveFileDialog
                .InitialDirectory = Path.Combine(My.Application.Info.DirectoryPath, "config")
                .DefaultExt = "json"
                .FileName = "Config"
                .Filter = "Json files (*.json)|*.json"
                .FilterIndex = 1
                .OverwritePrompt = True
                .Title = "Logger net configurazione"
            End With

            
            
            If objSaveFileDialog.ShowDialog = Windows.Forms.DialogResult.OK Then
                Try
                    Dim ConfigFilePath As String
                    
                    ConfigFilePath = objSaveFileDialog.FileName

                    
                    If My.Computer.FileSystem.FileExists(ConfigFilePath) Then
                        Dim ConfigFile As FileInfo = My.Computer.FileSystem.GetFileInfo(ConfigFilePath)
                        Dim BackupFile As String
                        BackupFile = Path.Combine(My.Application.Info.DirectoryPath, "config")
                        BackupFile = Path.Combine(BackupFile, "backup")
                        BackupFile = Path.Combine(BackupFile, Now.ToString("yyyyMMdd.HHmmss") + "." + ConfigFile.Name)

                        My.Computer.FileSystem.CopyFile(ConfigFilePath, BackupFile)
                    End If

                    
                    If LoggerSerializeJson(LG, ConfigFilePath) Then
                        MessageBox.Show("Serializzazione della configurazione eseguita.",
                            Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Information)
                    Else
                        MessageBox.Show("Errore durante la serializzazione della configurazione !",
                            Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Error)
                    End If

                Catch fileException As Exception
                    Throw fileException
                End Try
            End If

            
            objSaveFileDialog.Dispose()
            objSaveFileDialog = Nothing

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

    Function LoggerConfigJsonLoad() As ClassLogger
        Try

            
            Dim objOpenFileDialog As New OpenFileDialog

            
            With objOpenFileDialog
                .DefaultExt = "json"
                .FileName = "Config"
                .Filter = "Json files (*.json)|*.json"
                .FilterIndex = 1
                .Title = "Logger net configurazione"
                .InitialDirectory = Path.Combine(My.Application.Info.DirectoryPath, "config")
            End With

            
            If (objOpenFileDialog.ShowDialog() = DialogResult.OK) Then
                Dim FullConfigFileName As String
                FullConfigFileName = objOpenFileDialog.FileName

                
                Dim LG As New ClassLogger
                LG = LoggerDeserializeJson(FullConfigFileName)

                
                If LG Is Nothing Then
                    MessageBox.Show("Errore durante la de-serializzazione della configurazione !",
                        Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If

                Return LG

            Else
                Return Nothing
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    
    
    
    
    
    Function SaveAppConfiguration() As Boolean
        
        
        

        
        
        

        
        

        
        
        

        
        
        
        

        
        
        

        

        
        

        
        

        
        

        

        
        
        
        

    End Function

    
    
    
    
    
    Function CreatePaths() As Boolean
        Try

            
            
            
            Dim Configs As String = Path.Combine(Application.StartupPath, "config")
            If Not My.Computer.FileSystem.DirectoryExists(Configs) Then
                My.Computer.FileSystem.CreateDirectory(Configs)
            End If
            Dim ConfigsBackup As String = Path.Combine(Configs, "backup")
            If Not My.Computer.FileSystem.DirectoryExists(ConfigsBackup) Then
                My.Computer.FileSystem.CreateDirectory(ConfigsBackup)
            End If

            
            Dim Logpath As String = Path.Combine(Application.StartupPath, "log")
            If Not My.Computer.FileSystem.DirectoryExists(Logpath) Then
                My.Computer.FileSystem.CreateDirectory(Logpath)
            End If

            
            Me.FilesDataDatPath = Path.Combine(Application.StartupPath, "files_medie_dat")
            If Not My.Computer.FileSystem.DirectoryExists(Me.FilesDataDatPath) Then
                My.Computer.FileSystem.CreateDirectory(Me.FilesDataDatPath)
            End If
            Me.FilesDataCsvPath = Path.Combine(Application.StartupPath, "files_medie_csv")
            If Not My.Computer.FileSystem.DirectoryExists(Me.FilesDataCsvPath) Then
                My.Computer.FileSystem.CreateDirectory(Me.FilesDataCsvPath)
            End If

            
            Me.FilesInstCsvPath = Path.Combine(Application.StartupPath, "files_letture_csv")
            If Not My.Computer.FileSystem.DirectoryExists(Me.FilesInstCsvPath) Then
                My.Computer.FileSystem.CreateDirectory(Me.FilesInstCsvPath)
            End If

            Return True

        Catch ex As ArgumentException
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function LoggerSerializeXml(ByVal XmlFilePath As String) As Boolean
        Try

            Dim Ser As New ClassSerializer
            If Ser.SerializeLoggerXml(LG, XmlFilePath) Then
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function LoggerDeserializeXml(ByVal XmlFilePath As String) As Boolean
        Try

            
            
            
            Return True

            

            
            Dim Ser As ClassSerializer
            Ser = New ClassSerializer
            LG = Ser.DeSerializeLoggerXml(XmlFilePath)
            If LG Is Nothing Then
                Return False
            Else
                Return True
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function LoggerSerializeJson(ByVal LG As ClassLogger, ByVal JsonFilePath As String) As Boolean
        Try

            Dim Ser As New ClassSerializer
            If Ser.SerializeLoggerJson(LG, JsonFilePath) Then
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return False
        End Try
    End Function

    Public Function LoggerDeserializeJson(ByVal JsonFilePath As String) As ClassLogger
        Try

            Dim LG As New ClassLogger
            If Debugger.IsAttached Then
                LG = ModuleTEST.GetConfigurationVaisala()
                
                
                
                
                
                
                
                
                
                
                

            Else

                
                Dim Ser As ClassSerializer
                Ser = New ClassSerializer
                LG = Ser.DeSerializeLoggerJson(JsonFilePath)

                

                
                
                

            End If

            
            
            
            LG.SetFullNames()

            
            
            
            LG.ResetAlarms()

            
            
            
            LG.ResetChannels()

            
            
            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function
End Class
