Imports System.IO
Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types



Partial Class RunInterfaceScraper
    Inherits System.Web.UI.Page
    Public Iformat As IFormatProvider
    Public alphaArr(53) As Char
    Public trimArr(5) As Char
    Public oldManufact, oldStatus, oldDispatch, oldWithdrawl, oldReceipt As DateTime
    Public RunOldManufact, RunOldStatus, RunOldDispatch, RunOldWithdrawl, RunOldReceipt As DateTime

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        trimArr.SetValue(Chr(46), 0)
        trimArr.SetValue(Chr(47), 1)
        trimArr.SetValue(Chr(92), 2)

    End Sub
    Protected Sub BtnRunInterface_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnRunInterface.Load


        'need to update lot data first as system uses this data to pull the change date for the lot and add to transactions
        Label1.Text = "XFP Lot data interface running..."
        UpdatePanel1.Update()

        Response.Write(Now & "  Start of XFP_lots table interface <br/>")
        Dim clInterface As New clInterface
        clInterface.GetLotData("PROD")
        Response.Write(Now & "  End of XFP_lots table interface <br/>")

        Response.Write(Now & "   Get Status Change from XFP Start<br/>")
        clInterface.getStatusChangeTraceData("PROD")
        Response.Write(Now & "   Get Status Change from XFP End<br/>")

        Response.Write(Now & "  Start of SAP Interface Files interface <br/>")
        Call GetFiles()
        UpdatePanel1.Update()
        Response.Write(Now & "  End of SAP Interface Files interface <br/>")

        Response.Write(Now & "  Start of Lims interface <br/>")
        Dim limsInt As New clInterface
        limsInt.GetLIMSRecieptAndApprovedDates()
        Response.Write(Now & "  End of Lims interface <br/>")

        Response.Write(Now & "  Start of Lot Status Update interface <br/>")
        Call updateLotsStatus()
        Response.Write(Now & "  End of Lot Status Update interface <br/>")

        Label1.Text = "Processing complete!!!"
        UpdatePanel1.Update()
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCleanUp.Click
        Dim qAdap As New InterfaceScraperTableAdapters.QueriesTableAdapter

        qAdap.DeleteInterfaceFiles()
        qAdap.DeleteTransactions()

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

        Dim transAdap As New InterfaceScraperTableAdapters.QueriesTableAdapter
        oldManufact = transAdap.MaxFileWriteDate(1)
        oldStatus = transAdap.MaxFileWriteDate(2)
        oldDispatch = transAdap.MaxFileWriteDate(3)
        oldWithdrawl = transAdap.MaxFileWriteDate(4)
        oldReceipt = transAdap.MaxFileWriteDate(7)

        RunOldManufact = oldManufact
        RunOldStatus = oldStatus
        RunOldDispatch = oldDispatch
        RunOldWithdrawl = oldWithdrawl
        RunOldReceipt = oldReceipt

        Dim path As String = "C:\Documents and Settings\dinnissj\My Documents\SourceCode\LeaP Source\Interface\Archive\Archive"
        path = Server.MapPath("Interface") & "\TRP\Archive"

        'get the files in the directory

        Dim files() As String = Directory.GetFiles(path)
        Dim i As Integer

        Do Until i = files.Count
            'for each file check if its date is greater than last access date for that file
            Dim fileInfo As New System.IO.FileInfo(files(i))

            If fileInfo.LastWriteTime > DateAdd(DateInterval.Day, -180, Today()) Then
                Call fileconsume(fileInfo)
            End If

            i = i + 1
        Loop


        Dim adapTrans As New InterfaceScraperTableAdapters.LeaP_InterfaceFilesTableAdapter

        'write the file age to the table
        adapTrans.Insert(1, "manufact", RunOldManufact)
        adapTrans.Insert(2, "status", RunOldStatus)
        adapTrans.Insert(3, "dispatch", RunOldDispatch)
        adapTrans.Insert(4, "withdrawl", RunOldWithdrawl)
        adapTrans.Insert(7, "Receipt1901", RunOldReceipt)
    End Sub

    Sub fileconsume(ByVal fileinfo As FileInfo)

        '20 - reciept of bulk tablets
        '30 - Materials issued to bulk
        '40 - Mandecd at bulk stage
        '45 - Bulk moved from Q status to A status
        '55 - Materials issued to finished
        '60 - Mandecd at finished stage
        '70 - Finished Moved from Q status to A status
        '80 - Shipped from production

        Dim adapInt As New InterfaceScraperTableAdapters.LeaP_TransactionsTableAdapter
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
                    If lot.IndexOfAny(alphaArr) = -1 Then
                        trans = 40
                    Else
                        trans = 60
                    End If


                    trLot = trimLot(lot)

                    adapInt.Insert("manufact", trans, tranDate, Today(), CSVdata(2), CSVdata(1), CSVdata(0), trLot)

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

                        adapInt.Insert("status", trans, tranDate, Today(), CSVdata(4), CSVdata(1), CSVdata(0), trLot)
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

                    If CStr(CSVdata(0)) Like "00*" Then
                        adapInt.Insert("dispatch", 80, tranDate, Today(), CSVdata(2), CSVdata(1), CSVdata(0), trLot)
                    End If

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

                    Dim lot As String = CSVdata(1)
                    Dim trans As Integer
                    If lot.IndexOfAny(alphaArr) = -1 Then
                        trans = 30
                    Else
                        trans = 55

                    End If

                    trLot = trimLot(CSVdata(1))

                    Dim Iformat As IFormatProvider
                    Dim tranDate As Date = DateTime.ParseExact(CSVdata(5), "ddMMyyyy", Iformat)
                    adapInt.Insert("withdrawl", trans, tranDate, Today(), CSVdata(4), CSVdata(1), CSVdata(0), trLot)

                Loop
                Response.Write(fileinfo.FullName & "<br>")

                If fileinfo.LastWriteTime > RunOldWithdrawl Then
                    RunOldWithdrawl = fileinfo.LastWriteTime
                End If
            End If

        ElseIf fileinfo.Name Like "receipt*" Then

            If fileinfo.LastWriteTime > DateAdd(DateInterval.Second, 1, oldReceipt) Then

                Do Until sr.EndOfStream



                    Dim line As String = sr.ReadLine()
                    Dim CSVdata() As String = Split(line, ",")


                    'if its a 1901 lot then add the line, otherwise ignore
                    If CSVdata(1) Like "1901*" Then
                        trLot = trimLot(CSVdata(2))
                        Dim Iformat As IFormatProvider
                        Dim tranDate As Date = DateTime.ParseExact(CSVdata(4), "ddMMyyyy", Iformat)
                        adapInt.Insert("Rec1901", 20, tranDate, Today(), CSVdata(3), CSVdata(2), CSVdata(1), trLot)

                    End If
                Loop
                Response.Write(fileinfo.FullName & "<br>")
                'update the date of the oldest file to the new date if its older than the last oldest date
                If fileinfo.LastWriteTime > RunOldReceipt Then
                    RunOldReceipt = fileinfo.LastWriteTime
                End If
            End If
        End If
        sr.Close()

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
        StatusChangeDate = adapQ.GetDecisionDateByLot(lotnumber)
        Return StatusChangeDate

    End Function
#Region "Old status change date code"


    'Function getStatusChangeDate(ByVal itemcode As String, ByVal lotnumber As String) As DateTime

    '    Dim StatusChangeDate As DateTime

    '    Dim OraConn As New OracleConnection
    '    Dim OraComm As New OracleCommand

    '    OraConn.ConnectionString = "Data Source=ELAN;User Id=james_read_only;Password=dinnissj;"
    '    OraComm.Connection = OraConn
    '    OraComm.CommandText = "select datedecision from elan2406prd.xfp_lots where codelot = '" & lotnumber & "'"

    '    OraConn.Open()

    '    Dim oraRead As OracleDataReader

    '    oraRead = OraComm.ExecuteReader

    '    While oraRead.Read()
    '        If Not oraRead.IsDBNull(0) Then
    '            StatusChangeDate = DateTime.ParseExact(oraRead.GetString(0), "yyyyMMdd", Iformat)
    '        Else
    '            StatusChangeDate = Nothing
    '        End If
    '    End While

    '    OraConn.Close()
    '    OraConn.Dispose()
    '    OraComm.Dispose()

    '    Return StatusChangeDate

    'End Function

#End Region

#End Region

#Region "Update Lot table with latest TransactionID and Transaction Date AND update lots table "

    Sub updateLotsStatus()

        Dim clInterface As New clInterface
        clInterface.updateLotTransactions()

    End Sub



    Protected Sub Button1_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Load
        Response.Write(Now & "  Start of Prod and Arch XFP_lots interface<br/>")
        Dim clInterface As New clInterface
        clInterface.GetLotData("PROD")
        clInterface.GetLotData("ARCH")
        Response.Write(Now & "  End of Prod and Arch XFP_lots interface<br/>")


    End Sub

#End Region


    Protected Sub btnHighestTrans_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnHighestTrans.Load
        Dim clint As New clInterface
        clint.updateLotTransactions()

    End Sub
End Class
