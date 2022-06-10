Imports Ecometer.ClassModule
Imports Ecometer.ClassChannelBase.ChannelAlgorithm

Module ModuleTEST

    Function GetConfigurationApi200() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "plouves"
            LG.Name = "API 200"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.API200
            Mo.Name = "API 200"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 115200
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "NOx"
            
            
            
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 51
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 52
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO2"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            Mo = New ClassModule()
            Mo.Position = 2
            Mo.ModuleTypeID = EnumModuleType.API200_DIAGS
            Mo.Name = "API 200 DIAGS"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 115200
            Mo.PollingInterval = 20

            Ch = New ClassChannel()
            
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 100
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "SAMPFLOW"
            
            
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 101
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "OZONEFLOW"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "RCELLTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 3
            Ch.Position = 4
            Ch.Name = "BOXTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 4
            Ch.Position = 5
            Ch.Name = "PMTTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 5
            Ch.Position = 6
            Ch.Name = "CONVTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 6
            Ch.Position = 7
            Ch.Name = "RCELLPRESS"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 7
            Ch.Position = 8
            Ch.Name = "SAMPPRESS"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 8
            Ch.Position = 9
            Ch.Name = "NOXSLOPE"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 9
            Ch.Position = 10
            Ch.Name = "NOXOFFSET"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 10
            Ch.Position = 11
            Ch.Name = "NOSLOPE"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 2
            Ch.Position = 12
            Ch.Name = "NOOFFSET"
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationApi400() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 1
            LG.DataFileHeader = "capannone"
            LG.Name = "API 400"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.API400
            Mo.Name = "API 400"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            
            Ch.DatabaseId = 1
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3"
            
            
            
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            Mo = New ClassModule()
            Mo.Position = 2
            Mo.ModuleTypeID = EnumModuleType.API400A_DIAGS
            Mo.Name = "API 400 DIAGS"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 5

            
            
            
            
            
            
            
            
            
            
            

            Ch = New ClassChannel()
            
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 100
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "PHOTOMEAS"
            
            
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 101
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "O3GENREF"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "O3GENDRIVE"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 3
            Ch.Position = 4
            Ch.Name = "SAMPPRESS"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 4
            Ch.Position = 5
            Ch.Name = "SAMPFLOW"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 5
            Ch.Position = 6
            Ch.Name = "SAMPTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 6
            Ch.Position = 7
            Ch.Name = "PHOTOLTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 7
            Ch.Position = 8
            Ch.Name = "O3GENTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 8
            Ch.Position = 9
            Ch.Name = "BOXTEMP"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 9
            Ch.Position = 10
            Ch.Name = "SLOPE"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 102
            Ch.DataArrayIdx = 9
            Ch.Position = 11
            Ch.Name = "OFFSET"
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationApi700() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 1
            LG.DataFileHeader = "capannone"
            LG.Name = "API 700"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.API700
            Mo.Name = "API 700"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 19200
            Mo.PollingInterval = 5

            
            

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 1
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3 Target concentration"
            Ch.Unit = "ppb"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 2
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO Target concentration"
            Ch.Unit = "ppb"
            Mo.Channels.Add(Ch)


            
            Ch = New ClassChannel()
            
            Ch.DatabaseId = 3
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "O3 Actual concentration"
            Ch.Unit = "ppb"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 4
            Ch.DataArrayIdx = 3
            Ch.Position = 4
            Ch.Name = "NO Actual concentration"
            Ch.Unit = "ppb"
            Mo.Channels.Add(Ch)


            
            
            
            
            

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationHoriba370() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "capannone"
            LG.Name = "HORIBA 370"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.HORIBA370
            Mo.Name = "HORIBA 370"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 9600
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "NOx"
            
            
            
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 51
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 52
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO2"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationPAS2000() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "plouves"
            LG.Name = "PAS2000"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.PAS2000
            Mo.Name = "PAS2000"
            Mo.ComPortName = EnumSerialPortName.COM3
            Mo.ComPortBauds = 9600
            Mo.PollingInterval = 10

            Ch = New ClassChannel()
            
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "IPA"
            
            
            
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationVaisala() As ClassLogger
        Try

            

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            
            
            
            
            
            
            
            
            

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 1
            LG.DataFileHeader = "vaisala_ref"
            LG.Name = "Vaisala Refecence"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.VAISALA_WXT510
            Mo.Name = "WXT510"
            If Debugger.IsAttached Then
                Mo.ComPortName = EnumSerialPortName.COM1
                Mo.ComPortBauds = 115200
            Else
                Mo.ComPortName = EnumSerialPortName.COM10
                Mo.ComPortBauds = 19200
            End If
            Mo.PollingInterval = 10
            Mo.Address = "1"

            
            
            
            
            
            
            
            

            Ch = New ClassChannel()
            
            Ch.DatabaseId = 1
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "Temperatura"
            Ch.Unit = "°C"
            
            
            
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 2
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "Umidità"
            Ch.Unit = "%"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 3
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "Pressione"
            Ch.Unit = "mBar"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 4
            Ch.DataArrayIdx = 3
            Ch.Position = 4
            Ch.Name = "Velocità vento"
            Ch.Unit = "m/sec"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 5
            Ch.DataArrayIdx = 4
            Ch.Position = 5
            Ch.Name = "Direzione vento"
            Ch.Unit = "°N"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 6
            Ch.DataArrayIdx = 5
            Ch.Position = 6
            Ch.Name = "Precipitazione"
            Ch.Unit = "mm"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 7
            Ch.DataArrayIdx = 6
            Ch.Position = 7
            Ch.Name = "Precipitazione durata"
            Ch.Unit = "min"
            Ch.StoreCsv = True

            Ch.IsDiagnostic = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 8
            Ch.DataArrayIdx = 7
            Ch.Position = 8
            Ch.Name = "Precipitazione intensità"
            Ch.Unit = "mm/h"

            Ch.IsDiagnostic = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            
            For Each c As ClassChannel In Mo.Channels
                c.MeanInterval = 300
            Next

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationGPT() As ClassLogger
        Try
            
            
            
            
            

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            
            
            
            LG = New ClassLogger
            LG.ID = 1
            LG.DataFileHeader = "capannone"
            LG.Name = "GPT"

            
            
            
            Mo = New ClassModule()
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.API700
            Mo.Name = "API 700"
            Mo.ComPortName = EnumSerialPortName.COM9
            Mo.ComPortBauds = 19200
            Mo.PollingInterval = 5

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 300
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3 Target concentration"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 301
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "O3 Actual concentration"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 302
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO Target concentration"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.DatabaseId = 303
            Ch.DataArrayIdx = 3
            Ch.Position = 4
            Ch.Name = "NO Actual concentration"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 3
            Mo.ModuleTypeID = EnumModuleType.API401
            Mo.Name = "API 401"
            Mo.ComPortName = EnumSerialPortName.COM3
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            Ch.DatabaseId = 310
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 2
            Mo.ModuleTypeID = EnumModuleType.API400
            Mo.Name = "API 400"
            Mo.ComPortName = EnumSerialPortName.COM5
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            Ch.DatabaseId = 1
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 4
            Mo.ModuleTypeID = EnumModuleType.API200E
            Mo.Name = "API 200E"
            Mo.ComPortName = EnumSerialPortName.COM8
            Mo.ComPortBauds = 115200
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            Ch.DatabaseId = 2
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "NOx"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 3
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 4
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO2"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 5
            Mo.ModuleTypeID = EnumModuleType.HORIBA370
            Mo.Name = "HORIBA 370"
            Mo.ComPortName = EnumSerialPortName.COM7
            Mo.ComPortBauds = 9600
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            Ch.DatabaseId = 5
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "NOx"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 6
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 7
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO2"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            
            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationArpaCed() As ClassLogger
        Try
            
            
            
            

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            
            
            
            LG = New ClassLogger
            LG.ID = 1
            LG.DataFileHeader = "arpa_ced"
            LG.Name = "Arpa Ced"


            
            
            
            Mo = New ClassModule()
            Mo.Position = 3
            Mo.ModuleTypeID = EnumModuleType.API401
            Mo.Name = "API 401"
            Mo.ComPortName = EnumSerialPortName.COM3
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 10

            Ch = New ClassChannel()
            Ch.DatabaseId = 310
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 2
            Mo.ModuleTypeID = EnumModuleType.API400
            Mo.Name = "API 400"
            Mo.ComPortName = EnumSerialPortName.COM5
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 10

            Ch = New ClassChannel()
            Ch.DatabaseId = 1
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "O3"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 4
            Mo.ModuleTypeID = EnumModuleType.API200E
            Mo.Name = "API 200E"
            Mo.ComPortName = EnumSerialPortName.COM8
            Mo.ComPortBauds = 115200
            Mo.PollingInterval = 10

            Ch = New ClassChannel()
            Ch.DatabaseId = 2
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "NOx"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 3
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 4
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO2"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            Mo = New ClassModule()
            Mo.Position = 5
            Mo.ModuleTypeID = EnumModuleType.HORIBA370
            Mo.Name = "HORIBA 370"
            Mo.ComPortName = EnumSerialPortName.COM7
            Mo.ComPortBauds = 9600
            Mo.PollingInterval = 5

            Ch = New ClassChannel()
            Ch.DatabaseId = 5
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "NOx"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 6
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "NO"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel()
            Ch.DatabaseId = 7
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "NO2"
            Ch.Unit = "ppb"
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            
            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationSM200() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "ecometer"
            LG.Name = "SM 200"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.SM200
            Mo.Name = "SM 200"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 19200
            Mo.PollingInterval = 5

            
            
            
            
            
            
            
            
            
            
            

            
            

            
            

            
            
            
            
            
            
            
            

            Dim Info As String
            Info = "00 - Down time (min)" + vbCrLf
            Info += "01 - Total sampling volume (m3)" + vbCrLf
            Info += "02 - Initial pressure drop across filter (kPa)" + vbCrLf
            Info += "03 - Final pressure drop across filter (kPa)" + vbCrLf
            Info += "04 - Relative standard deviation of flow rate during sampling (%)" + vbCrLf
            Info += "05 - Background beta counts (Dark)(cpm)" + vbCrLf
            Info += "06 - Clean filter beta count (Blank)(cpm)" + vbCrLf
            Info += "07 - Average internal temparature during blank meas.(K)" + vbCrLf
            Info += "08 - Average ambient pressure during blank meas.(kPa)" + vbCrLf
            Info += "09 - Average Geiger voltage during blank meas.(V)" + vbCrLf
            Info += "10 - Natural1 sample short life beta activity (cpm)" + vbCrLf
            Info += "11 - Natural2 sample residual beta activity (cpm)" + vbCrLf
            Info += "12 - Natural R sample residual beta activity (%)" + vbCrLf
            Info += "13 - Collect sample beta counts (cpm)" + vbCrLf
            Info += "14 - Average internal temperatura during sampling (K)" + vbCrLf
            Info += "15 - Average ambient pressure during sampling (kPa)" + vbCrLf
            Info += "16 - Average Geiger voltage during sampling (V)" + vbCrLf
            Info += "17 - Average relative humidity during sampling (%)" + vbCrLf
            Info += "18 - Total mass in sampled dust (mg)" + vbCrLf
            Info += "19 - Mass error in sampled dust (mg)" + vbCrLf
            Info += "20 - Mass concentration in sampled dust (µg/Nm3)" + vbCrLf
            Info += "21 - Pneumatic status" + vbCrLf
            Info += "22 - Beta status"
            Mo.Info = Info

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

            
            Ch = New ClassChannel()
            
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 20
            Ch.Position = 1
            Ch.Name = "Mass concentration in sampled dust"
            Ch.Unit = "µg/Nm3"
            
            
            
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)


            
            Ch = New ClassChannel()
            
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 202
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "Down time"
            Ch.Unit = "min"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 205
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "Total sampling volume"
            Ch.Unit = "m3"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 206
            Ch.DataArrayIdx = 2
            Ch.Position = 3
            Ch.Name = "Initial pressure drop across filter"
            Ch.Unit = "kPa"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 207
            Ch.DataArrayIdx = 3
            Ch.Position = 4
            Ch.Name = "Final pressure drop across filter"
            Ch.Unit = "kPa"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 208
            Ch.DataArrayIdx = 4
            Ch.Position = 5
            Ch.Name = "Relative standard deviation of flow rate during sampling"
            Ch.Unit = "%"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 209
            Ch.DataArrayIdx = 5
            Ch.Position = 6
            Ch.Name = "Background beta counts (Dark)"
            Ch.Unit = "cpm"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 210
            Ch.DataArrayIdx = 6
            Ch.Position = 7
            Ch.Name = "Clean filter beta count (Blank)"
            Ch.Unit = "cpm"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 211
            Ch.DataArrayIdx = 7
            Ch.Position = 8
            Ch.Name = "Average internal temparature during blank meas."
            Ch.Unit = "K"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 212
            Ch.DataArrayIdx = 8
            Ch.Position = 9
            Ch.Name = "Average ambient pressure during blank meas."
            Ch.Unit = "kPa"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 213
            Ch.DataArrayIdx = 9
            Ch.Position = 10
            Ch.Name = "Average Geiger voltage during blank meas."
            Ch.Unit = "V"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 214
            Ch.DataArrayIdx = 10
            Ch.Position = 11
            Ch.Name = "Natural1 sample short life beta activity"
            Ch.Unit = "cpm"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 215
            Ch.DataArrayIdx = 11
            Ch.Position = 12
            Ch.Name = "Natural2 sample residual beta activity"
            Ch.Unit = "cpm"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 216
            Ch.DataArrayIdx = 12
            Ch.Position = 13
            Ch.Name = "Natural R sample residual beta activity"
            Ch.Unit = "%"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 217
            Ch.DataArrayIdx = 13
            Ch.Position = 14
            Ch.Name = "Collect sample beta counts"
            Ch.Unit = "cpm"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 218
            Ch.DataArrayIdx = 14
            Ch.Position = 15
            Ch.Name = "Average internal temperatura during sampling"
            Ch.Unit = "K"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 219
            Ch.DataArrayIdx = 15
            Ch.Position = 16
            Ch.Name = "Average ambient pressure during sampling"
            Ch.Unit = "kPa"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 220
            Ch.DataArrayIdx = 16
            Ch.Position = 17
            Ch.Name = "Average Geiger voltage during sampling"
            Ch.Unit = "V"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 221
            Ch.DataArrayIdx = 17
            Ch.Position = 18
            Ch.Name = "Average relative humidity during sampling"
            Ch.Unit = "%"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 222
            Ch.DataArrayIdx = 18
            Ch.Position = 19
            Ch.Name = "Total mass in sampled dust"
            Ch.Unit = "mg"
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 223
            Ch.DataArrayIdx = 19
            Ch.Position = 20
            Ch.Name = "Mass error in sampled dust"
            Ch.Unit = "mg"
            Mo.Channels.Add(Ch)

            

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 224
            Ch.DataArrayIdx = 21
            Ch.Position = 21
            Ch.Name = "Pneumatic status"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.IsDiagnostic = True
            Ch.DatabaseId = 225
            Ch.DataArrayIdx = 22
            Ch.Position = 22
            Ch.Name = "Beta status"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationSM200BHP() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "ecometer"
            LG.Name = "SM 200 BH"

            
            Mo = New ClassModule()
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.SM200_RPTM
            Mo.Name = "SM200 RPTM"
            Mo.ComPortName = EnumSerialPortName.COM1
            Mo.ComPortBauds = 19200
            Mo.PollingInterval = 10

            
            
            
            
            
            
            
            
            
            


            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 1
            Ch.DataArrayIdx = 0
            Ch.Position = Ch.ID
            Ch.Name = "RTPM particle concentration last minute"
            Ch.Unit = "ug/Nm3"
            
            
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 2
            Ch.DataArrayIdx = 1
            Ch.Position = Ch.ID
            Ch.Name = "RTPM particle count last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 3
            Ch.DataArrayIdx = 2
            Ch.Position = Ch.ID
            Ch.Name = "RTPM Average particle signal last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 4
            Ch.DataArrayIdx = 3
            Ch.Position = Ch.ID
            Ch.Name = "RTPM False count last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 5
            Ch.DataArrayIdx = 4
            Ch.Position = Ch.ID
            Ch.Name = "RTPM small count last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 6
            Ch.DataArrayIdx = 5
            Ch.Position = Ch.ID
            Ch.Name = "RTPM large count last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 7
            Ch.DataArrayIdx = 6
            Ch.Position = Ch.ID
            Ch.Name = "RTPM laser count last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 7
            Ch.DataArrayIdx = 6
            Ch.Position = Ch.ID
            Ch.Name = "RTPM stray light last minute"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)


            
            
            
            
            
            
            
            
            
            

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 8
            Ch.DataArrayIdx = 7
            Ch.Position = Ch.ID
            Ch.Name = "RTPM mass concentration last filter"
            Ch.Unit = "ug/Nm3"
            
            
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 9
            Ch.DataArrayIdx = 8
            Ch.Position = Ch.ID
            Ch.Name = "RTPM particle count last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 10
            Ch.DataArrayIdx = 9
            Ch.Position = Ch.ID
            Ch.Name = "RTPM Average particle signal last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 11
            Ch.DataArrayIdx = 10
            Ch.Position = Ch.ID
            Ch.Name = "RTPM False count last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 12
            Ch.DataArrayIdx = 11
            Ch.Position = Ch.ID
            Ch.Name = "RTPM small count last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 13
            Ch.DataArrayIdx = 12
            Ch.Position = Ch.ID
            Ch.Name = "RTPM large count last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 14
            Ch.DataArrayIdx = 13
            Ch.Position = Ch.ID
            Ch.Name = "RTPM laser current last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)

            
            Ch = New ClassChannel()
            Ch.Active = True
            
            Ch.DatabaseId = 15
            Ch.DataArrayIdx = 14
            Ch.Position = Ch.ID
            Ch.Name = "RTPM stray light last filter"
            Ch.Unit = ""
            Mo.Channels.Add(Ch)


            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationSilena600CE() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "plouves"
            LG.Name = "Silena600CE"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.Silena600CE
            Mo.Name = "Silena600CE"
            Mo.ComPortName = EnumSerialPortName.COM5
            Mo.ComPortBauds = 600
            Mo.ComPortDataBits = 7
            Mo.ComPortStopBits = IO.Ports.StopBits.One
            Mo.ComPortParity = IO.Ports.Parity.Even
            Mo.PollingInterval = 15

            Ch = New ClassChannel()
            Ch.Active = True
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "Gamma"
            Ch.MeanInterval = 600
            
            
            Ch.Decimals = 4
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationSilena() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "plouves"
            LG.Name = "Silena"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.Silena
            Mo.Name = "Silena"
            Mo.ComPortName = EnumSerialPortName.COM5
            Mo.ComPortBauds = 9600
            
            
            
            Mo.PollingInterval = 10

            Ch = New ClassChannel()
            Ch.Active = True
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "Gamma"
            Ch.MeanInterval = 600
            
            
            Ch.Decimals = 4
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function

    Function GetConfigurationTEOM_1400A() As ClassLogger
        Try

            Dim LG As ClassLogger
            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG = New ClassLogger
            LG.ID = 4000
            LG.DataFileHeader = "plouves"
            LG.Name = "TEOM_1400A"

            Mo = New ClassModule()
            
            
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.TEOM_1400A
            Mo.Name = "TEOM_1400A"
            Mo.ComPortName = EnumSerialPortName.COM6
            Mo.ComPortBauds = 9600
            
            
            
            Mo.PollingInterval = 10

            Ch = New ClassChannel()
            Ch.Active = True
            Ch.DatabaseId = 50
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "ug"
            Ch.MeanInterval = 600
            
            
            Ch.Decimals = 4
            Ch.StoreCsv = True
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

            
            Return LG

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
            Return Nothing
        End Try
    End Function


    Sub GetConfiguration1(LG As ClassLogger)
        Try

            Dim Mo As ClassModule
            Dim Ch As ClassChannel
            Dim ChC As ClassChannelCommand

            LG.ID = 1
            LG.Name = "API 401"

            Mo = New ClassModule
            Mo.Active = True
            Mo.ID = 1
            Mo.Position = 1
            Mo.ModuleTypeID = EnumModuleType.API401
            Mo.Name = "API 401"
            Mo.ComPortName = EnumSerialPortName.COM2
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 10

            Ch = New ClassChannel
            Ch.Active = True
            Ch.ID = 1
            Ch.DatabaseId = 12
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "Data Channel 1"
            Ch.MeanInterval = 60
            Ch.Formule = "y=x"
            Mo.Channels.Add(Ch)

            
            ChC = New ClassChannelCommand
            ChC.Active = True
            ChC.ID = 1
            ChC.Position = 2
            ChC.Name = "Command Channel 1 - ZERO"
            ChC.Command = "C ZERO" 
            ChC.DateTime = CDate(Now.AddMinutes(1).ToString("dd/MM/yyyy HH:mm:00")) 
            ChC.Repeat = True
            Mo.ChannelsCommand.Add(ChC)

            
            ChC = New ClassChannelCommand
            ChC.Active = True
            ChC.ID = 2
            ChC.Position = 3
            ChC.Name = "Command Channel 2 - STBY"
            ChC.Command = "C STBY" 
            ChC.DateTime = CDate(Now.AddMinutes(4).ToString("dd/MM/yyyy HH:mm:00"))
            ChC.Repeat = True
            Mo.ChannelsCommand.Add(ChC)

            
            ChC = New ClassChannelCommand
            ChC.Active = True
            ChC.ID = 3
            ChC.Position = 4
            ChC.Name = "Command Channel 3"
            ChC.Command = "C O3GEN" 
            ChC.Value = 100
            ChC.DateTime = CDate(Now.AddMinutes(6).ToString("dd/MM/yyyy HH:mm:00"))
            ChC.Repeat = True
            Mo.ChannelsCommand.Add(ChC)

            ChC = New ClassChannelCommand
            ChC.Active = False
            ChC.ID = 4
            ChC.Position = 5
            ChC.Name = "Command Channel 4"
            ChC.Command = "T ZERO"
            ChC.DateTime = CDate(Now.AddMinutes(15).ToString("dd/MM/yyyy HH:mm:00"))
            ChC.Repeat = True
            Mo.ChannelsCommand.Add(ChC)

            
            ChC = New ClassChannelCommand
            ChC.Active = True
            ChC.ID = 5
            ChC.Position = 6
            ChC.Name = "Command Channel 5 - STBY"
            ChC.Command = "C STBY" 
            ChC.Value = 0
            ChC.DateTime = CDate(Now.AddMinutes(18).ToString("dd/MM/yyyy HH:mm:00"))
            ChC.Repeat = True
            Mo.ChannelsCommand.Add(ChC)
            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            Mo = New ClassModule
            Mo.Active = True
            Mo.ID = 2
            Mo.Position = 2
            Mo.ModuleTypeID = EnumModuleType.API400A_DIAGS
            Mo.Name = "API 401 DIAGS"
            Mo.ComPortName = EnumSerialPortName.COM2
            Mo.ComPortBauds = 2400
            Mo.PollingInterval = 10

            Ch = New ClassChannel
            Ch.Active = True
            Ch.ID = 1
            Ch.DatabaseId = 100
            Ch.DataArrayIdx = 0
            Ch.Position = 1
            Ch.Name = "Diag 1"
            Ch.MeanInterval = 120
            Ch.Formule = "y=x"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.Active = True
            Ch.ID = 2
            Ch.DatabaseId = 101
            Ch.DataArrayIdx = 1
            Ch.Position = 2
            Ch.Name = "Diag 2"
            Ch.MeanInterval = 120
            Ch.Formule = "y=x"
            Mo.Channels.Add(Ch)
            
            Mo.Channels.Sort()

            
            LG.Modules.Add(Mo)


            
            
            
            
            

            
            
            
            
            
            
            

            
            

            
            

            
            LG.Modules.Sort()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub
    Sub GetConfiguration2(LG As ClassLogger)
        Try

            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG.ID = 4900
            LG.Name = "Tecora"

            Mo = New ClassModule
            Mo.ID = 1
            Mo.Name = "Tecora"
            Mo.PollingInterval = 5

            Ch = New ClassChannel
            Ch.ID = 1
            Ch.Position = 1
            Ch.Name = "Channel 1"
            Ch.MeanInterval = 60
            Ch.Formule = "y=x+2*1,2"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.ID = 2
            Ch.Position = 4
            Ch.Name = "Channel 2"
            Ch.MeanInterval = 2 * 60
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.ID = 3
            Ch.Position = 2
            Ch.Name = "Channel 3"
            Ch.MeanInterval = 5 * 60
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.ID = 4
            Ch.Position = 3
            Ch.Name = "Channel 4"
            Ch.MeanInterval = 10 * 60
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub
    Sub GetConfiguration3(LG As ClassLogger)
        Try

            Dim Mo As ClassModule
            Dim Ch As ClassChannel

            LG.ID = 4900
            LG.Name = "Pozzo P1"

            Mo = New ClassModule
            Mo.ID = 1
            Mo.Name = "Olimpo Sonda S1"
            Mo.PollingInterval = 5

            Ch = New ClassChannel
            Ch.ID = 1
            Ch.Position = 1
            Ch.Name = "Channel 1"
            Ch.MeanInterval = 60
            Ch.Formule = "y=x+2*1,2"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.ID = 2
            Ch.Position = 4
            Ch.Name = "Channel 2"
            Ch.MeanInterval = 2 * 60
            Ch.Formule = "y=x"
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.ID = 3
            Ch.Position = 2
            Ch.Name = "Channel 3"
            Ch.MeanInterval = 5 * 60
            Mo.Channels.Add(Ch)

            Ch = New ClassChannel
            Ch.ID = 4
            Ch.Position = 3
            Ch.Name = "Channel 4"
            Ch.MeanInterval = 10 * 60
            Mo.Channels.Add(Ch)

            
            Mo.Channels.Sort()

            LG.Modules.Add(Mo)

            
            LG.Modules.Sort()

        Catch ex As Exception
            ClassUtils.LogExeption(ex)
        End Try
    End Sub

End Module
