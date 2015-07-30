Imports System.IO
Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types

Partial Class PLTInterfaceScraper
    Inherits System.Web.UI.Page
    Public Iformat As IFormatProvider
    Public alphaArr(53) As Char
    Public trimArr(5) As Char
    Public oldManufact, oldStatus, oldDispatch, oldWithdrawl, oldreceipt As DateTime
    Public RunOldManufact, RunOldStatus, RunOldDispatch, RunOldWithdrawl, runoldreceipt As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        trimArr.SetValue(Chr(46), 0)
        trimArr.SetValue(Chr(47), 1)
        trimArr.SetValue(Chr(92), 2)
        Call RunInt()

    End Sub
    Protected Sub BtnRunInterface_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnRunInterface.Click
        Call RunInt()
    End Sub
    Sub RunInt()


        Response.Write(Now & "   Get Lot Data from XFP Start<br/>")
        Dim clInterface As New clInterface
        clInterface.GetLotData("PROD")
        Response.Write(Now & "   Get Lot Data from XFP End<br/>")

        Response.Write(Now & "   Get Status Change from XFP Start<br/>")
        clInterface.getStatusChangeTraceData("PROD")
        Response.Write(Now & "   Get Status Change from XFP End<br/>")

        Response.Write(Now & "   Get Sampling data from XFP Start<br/>")
        clInterface.GetXFPSampleDate("PROD")
        Response.Write(Now & "   Get Sampling data from XFP End<br/>")

        Response.Write(Now & "   Get Interface data Start<br/>")
        Call GetFiles()
        Response.Write(Now & "   Get Interface data End<br/>")

    End Sub

#Region "Get SAP interface files"

    Sub GetFiles()



        'fill the array with the alphabet caps and lower case
        Dim y As Integer = 0
        Dim n As Integer
        For n = 65 To 90
            Dim d As Char = Chr(n)
            alphaArr.SetValue(d, y)
            y = y + 1
        Next
        For n = 97 To 122
            Dim d As Char = Chr(n)
            alphaArr.SetValue(d, y)
            y = y + 1
        Next

        'get the oldest dates in the db for each type of files

        Dim transAdap As New PLTInterfaceTableAdapters.QueriesTableAdapter
        oldManufact = transAdap.MaxFileWriteDate(1)
        oldStatus = transAdap.MaxFileWriteDate(2)
        oldDispatch = transAdap.MaxFileWriteDate(3)
        oldWithdrawl = transAdap.MaxFileWriteDate(4)
        oldreceipt = transAdap.MaxFileWriteDate(5)

        RunOldManufact = oldManufact
        RunOldStatus = oldStatus
        RunOldDispatch = oldDispatch
        RunOldWithdrawl = oldWithdrawl
        runoldreceipt = oldreceipt


        Dim path As String = "C:\Documents and Settings\dinnissj\My Documents\SourceCode\LeaP Source\Interface\Archive\Archive"
        path = "\\citrix-01\XFP\Elan2406PRD\TR2406PRD\XFP_SAP\TRP\Archive"

        'get the files in the directory

        Dim files() As String = Directory.GetFiles(path)
        Dim i As Integer

        Do Until i = files.Count
            'for each file check if its date is greater than last access date for that file
            Dim fileInfo As New System.IO.FileInfo(files(i))

            If fileInfo.LastWriteTime > DateAdd(DateInterval.Day, -1095, Today()) Then
                Call fileconsume(fileInfo)
            End If

            i = i + 1
        Loop


        Dim adapTrans As New PLTInterfaceTableAdapters.PLT_InterfaceFilesTableAdapter

        'write the file age to the table
        adapTrans.Insert(1, "manufact", RunOldManufact)
        adapTrans.Insert(2, "status", RunOldStatus)
        adapTrans.Insert(3, "dispatch", RunOldDispatch)
        adapTrans.Insert(4, "withdrawl", RunOldWithdrawl)
        adapTrans.Insert(5, "receipt", runoldreceipt)

    End Sub

    Sub fileconsume(ByVal fileinfo As FileInfo)
        Try

            '10 - Materials Recieved to warehouse
            '30 - Materials issued to a lot
            '40 - Mandec of a lot
            '45 - Bulk moved from Q status to A status
            '55 - Materials issued to finished
            '70 - Finished Moved from Q status to A status
            '80 - Shipped from production

            Dim adapInt As New PLTInterfaceTableAdapters.PLT_TransactionsTableAdapter
            Dim trLot As String

            Dim sr As New StreamReader(fileinfo.FullName)
            'check if its a manufact file


            If fileinfo.Name Like "manufact*" Then
                'check if its older than the last one in the run   .One second added to allow for times matching bug with time comparison.
                If fileinfo.LastWriteTime > DateAdd(DateInterval.Second, 1, oldManufact) Then

                    Do Until sr.EndOfStream

                        Dim line As String = sr.ReadLine()
                        Dim CSVdata() As String = Split(line, ",")
                        Dim Iformat As IFormatProvider
                        Dim tranDate As Date = DateTime.ParseExact(CSVdata(3), "ddMMyyyy", Iformat)


                        'if lot has an alpha character in it then it is a pack lot and should have a pack transaction
                        'if there is no alpha it is a bulk lot and has a bulk lot transaction
                        Dim lot As String = CSVdata(1)
                        Dim trans As Integer

                        trans = 40
                        trLot = trimLot(lot)

                        adapInt.Insert("manufact", trans, tranDate, Today(), CSVdata(2), CSVdata(1), trLot, CSVdata(0), Nothing, Nothing, Nothing)

                    Loop

                    Response.Write(fileinfo.FullName & "<br>")


                    If fileinfo.LastWriteTime > RunOldManufact Then
                        RunOldManufact = fileinfo.LastWriteTime
                    End If



                End If


            ElseIf fileinfo.Name Like "status*" Then

                If fileinfo.LastWriteTime > DateAdd(DateInterval.Second, 1, oldStatus) Then

                    Do Until sr.EndOfStream

                        Dim line As String = sr.ReadLine()
                        Dim CSVdata() As String = Split(line, ",")

                        If CSVdata(3) = "A" Or CSVdata(3) = "R" Then

                            Dim lot As String = CSVdata(1)
                            Dim trans As Integer
                            If lot.IndexOfAny(alphaArr) = -1 Then
                                trans = 45
                            Else
                                trans = 70
                            End If

                            Dim tranDate As Date = Today()
                            tranDate = getStatusChangeDate(CSVdata(0), CSVdata(1))
                            'tranDate = Today()

                            trLot = trimLot(CSVdata(1))

                            adapInt.Insert("status", trans, tranDate, Today(), CSVdata(4), CSVdata(1), trLot, CSVdata(0), Nothing, Nothing, Nothing)
                        End If

                    Loop

                    Response.Write(fileinfo.FullName & "<br>")

                    If fileinfo.LastWriteTime > RunOldStatus Then
                        RunOldStatus = fileinfo.LastWriteTime
                    End If


                End If


            ElseIf fileinfo.Name Like "dispatch*" Then

                If fileinfo.LastWriteTime > DateAdd(DateInterval.Second, 1, oldDispatch) Then
                    Do Until sr.EndOfStream

                        Dim line As String = sr.ReadLine()
                        Dim CSVdata() As String = Split(line, ",")
                        Dim Iformat As IFormatProvider
                        Dim tranDate As Date = DateTime.ParseExact(CSVdata(3), "ddMMyyyy", Iformat)

                        trLot = trimLot(CSVdata(1))


                        adapInt.Insert("dispatch", 80, tranDate, Today(), CSVdata(2), CSVdata(1), trLot, CSVdata(0), Nothing, Nothing, Nothing)

                    Loop

                    Response.Write(fileinfo.FullName & "<br>")

                    If fileinfo.LastWriteTime > RunOldDispatch Then
                        RunOldDispatch = fileinfo.LastWriteTime
                    End If



                End If

            ElseIf fileinfo.Name Like "withdraw*" Then

                If fileinfo.LastWriteTime > DateAdd(DateInterval.Second, 1, oldWithdrawl) Then

                    Do Until sr.EndOfStream

                        Dim line As String = sr.ReadLine()
                        Dim CSVdata() As String = Split(line, ",")

                        'check to see if withdrawl is to a pack or bulk lot

                        Dim trans As Integer = 30
                        trLot = trimLot(CSVdata(1))

                        Dim trconsLot = trimLot(CSVdata(3))

                        Dim Iformat As IFormatProvider
                        Dim tranDate As Date = DateTime.ParseExact(CSVdata(5), "ddMMyyyy", Iformat)
                        adapInt.Insert("withdrawl", trans, tranDate, Today(), CSVdata(4), CSVdata(1), trLot, CSVdata(0), CSVdata(3), CSVdata(2), trconsLot)

                    Loop
                    Response.Write(fileinfo.FullName & "<br>")

                    If fileinfo.LastWriteTime > RunOldWithdrawl Then
                        RunOldWithdrawl = fileinfo.LastWriteTime
                    End If
                End If


            ElseIf fileinfo.Name Like "receipt*" Then

                If fileinfo.LastWriteTime > DateAdd(DateInterval.Second, 1, oldreceipt) Then

                    Do Until sr.EndOfStream

                        Dim line As String = sr.ReadLine()
                        Dim CSVdata() As String = Split(line, ",")

                        'check to see if withdrawl is to a pack or bulk lot

                        Dim trans As Integer = 10
                        trLot = trimLot(CSVdata(2))

                        Dim Iformat As IFormatProvider
                        Dim tranDate As Date = DateTime.ParseExact(CSVdata(4), "ddMMyyyy", Iformat)
                        adapInt.Insert("Receipt", trans, tranDate, Today(), CSVdata(3), CSVdata(2), trLot, CSVdata(1), Nothing, Nothing, Nothing)

                    Loop
                    Response.Write(fileinfo.FullName & "<br>")

                    If fileinfo.LastWriteTime > runoldreceipt Then
                        runoldreceipt = fileinfo.LastWriteTime
                    End If


                End If


            End If


            sr.Close()

        Catch ex As Exception
            Dim sw As New StreamWriter("c:/PLTerrors.txt")
            sw.WriteLine(fileinfo.Name & " " & fileinfo.LastWriteTime & " " & ex.Message)

        End Try

    End Sub
    Function trimLot(ByVal Lot As String) As String

        Dim trimIndex As Integer = Lot.IndexOfAny(trimArr)
        Dim trLot As String
        If trimIndex > -1 Then
            trLot = Left(Lot, trimIndex)
        Else
            trLot = Lot
        End If

        Return trLot

    End Function

    Function getStatusChangeDate(ByVal itemcode As String, ByVal lotnumber As String) As DateTime

        Dim StatusChangeDate As DateTime
        Dim adapQ As New InterfaceScraperTableAdapters.QueriesTableAdapter
        StatusChangeDate = adapQ.GetHighestXFPStatusChangeTransaction(lotnumber)
        Return StatusChangeDate

    End Function





#End Region



End Class
