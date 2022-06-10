Public Class ClassStopWatch

    Private ReadOnly StopWatch As Stopwatch

    Public Sub New()
        StopWatch = New Stopwatch()
        StopWatch.Start()
    End Sub

    Public Sub StopTimer()

        StopWatch.Stop()

        
        Dim ts As TimeSpan = StopWatch.Elapsed

        
        Dim elapsedTime As String = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
            ts.Hours, ts.Minutes, ts.Seconds, ts.Milliseconds / 10)
        Console.WriteLine(elapsedTime, "RunTime")
        Debug.WriteLine(elapsedTime, "RunTime")
    End Sub

End Class
