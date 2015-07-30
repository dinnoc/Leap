Imports Microsoft.VisualBasic
Imports System.Diagnostics
Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types
Imports System.IO


Public Class clInterface
    Dim arrCal(1000) As Date
#Region "Generate Routings"

    Sub GenerateRoutings()
        Dim adapQ As New RoutingsTableAdapters.QueriesTableAdapter
        adapQ.DeleteRouteData()

        'get all the batches which require routings (perhaps this can be set to only batches which have not shipped or do not have work orders available?)
        Dim adap As New dsBatchTableAdapters.BatchDetailsTableAdapter
        Dim dt As New dsBatch.BatchDetailsDataTable
        dt = adap.GetData()

        For Each row As dsBatch.BatchDetailsRow In dt
            Call routeit(row)
        Next
        'for each batch generate a routing
    End Sub

    Sub routeit(ByVal row As dsBatch.BatchDetailsRow)
        'populate the calendar array

        Dim adapCal As New RoutingsTableAdapters.LeaP_CalendarTableAdapter
        Dim dtCal As New Routings.LeaP_CalendarDataTable

        dtCal = adapCal.GetData

        Dim i As Integer

        For Each Calrow As Routings.LeaP_CalendarRow In dtCal
            arrCal.SetValue(Calrow.OffDate, i)
            i = i + 1
        Next

        'get the routing for this item
        Dim adapRouteCalc As New RoutingsTableAdapters.RouteCalcDetailsTableAdapter
        Dim dtRouteCalc As New Routings.RouteCalcDetailsDataTable
        dtRouteCalc = adapRouteCalc.GetData(row.ItemCode)

        'fill in the RouteData Table with the information
        Dim enddate As Date = row.TILFinalApprovalDate

        If Not enddate = "#12:00:00 AM#" Then

            Dim nextWorkCentre As Integer
            Dim adapRouteData As New RoutingsTableAdapters.LeaP_RouteDataTableAdapter

            'set the routing for shipment for the specific batch
            adapRouteData.Insert(row.spcBatchID, 5, row.TPCConfirmedCollectionDate, row.TPCConfirmedCollectionDate, 80, 0, 0)
            nextWorkCentre = 5

            For Each rowCalc As Routings.RouteCalcDetailsRow In dtRouteCalc

                Dim startdate As Date = DateAdd(DateInterval.Day, -calcWorkDays(enddate, rowCalc.TotalDuration), enddate)
                adapRouteData.Insert(row.spcBatchID, rowCalc.WorkCentreID, startdate, enddate, rowCalc.WorkCentreCompleteTransaction, nextWorkCentre, rowCalc.ProcessDuration)
                enddate = startdate

                If rowCalc.WorkCentreCompleteTransaction > -1 Then
                    nextWorkCentre = rowCalc.WorkCentreID
                End If
            Next
        End If
    End Sub

    Function calcWorkDays(ByVal enddate As Date, ByVal duration As Integer) As Integer

        Dim newduration As Integer
        Dim i As Integer

        Dim currdate = enddate

        Do Until i = duration
            If arrCal.Contains(currdate) Then
                newduration = newduration + 1
                i = i - 1
            Else
                newduration = newduration + 1
            End If

            currdate = DateAdd(DateInterval.Day, -1, currdate)
            i = i + 1
        Loop

        Return newduration

    End Function





#End Region

#Region "Update all lots with highest transaction"


    Sub updateLotTransactions()


        'updates all lots in spc_batches table with their current highest transaction from the trasnactions table

        Dim adapTrans As New InterfaceScraperTableAdapters.HighestTrans2TableAdapter
        Dim dtTransPack As New InterfaceScraper.HighestTrans2DataTable
        Dim dtTransBulk As New InterfaceScraper.HighestTrans2DataTable

        Dim newHighTrans As Integer = 0

        Dim adapLot As New ShipPlanComTableAdapters.LeaP_spcBatchesTableAdapter
        Dim dtLot As New ShipPlanCom.LeaP_spcBatchesDataTable

        Dim adapQ As New InterfaceScraperTableAdapters.QueriesTableAdapter

        dtLot = adapLot.GetDataByLessThanTransType(80)

        For Each row As ShipPlanCom.LeaP_spcBatchesRow In dtLot

            'get current highest transaction
            'Dim highestTransaction As Integer = row.HighestTransType

            'get the highest transaction from transaction table for the bulk lot
            dtTransBulk = adapTrans.GetData(row.BatchTrimmed, row.BatchNumber)

            'get the highest transaction from transaction table related to the packaging lot
            dtTransPack = adapTrans.GetData(row.BatchNumber, row.BatchNumber)


            If dtTransBulk.Rows.Count > 0 Then
                'if there are no lines in pack table use the bulk, if there are lines in the pack table then use that
                newHighTrans = dtTransBulk.Rows(0).Item(1)
            End If

            'if the transaction is the QC testing transaction
            If newHighTrans = 65 Then

                'if there are no packaging based transactions
                If dtTransPack.Rows.Count = 0 Then

                    'find the highest transaction which is less than 65 and set the highest transaction to this 
                    Dim dtTransBulkU65 As New InterfaceScraper.HighestTrans2DataTable
                    dtTransBulkU65 = adapTrans.GetDataBy(row.BatchTrimmed, 65, row.BatchNumber)

                    If dtTransBulkU65.Rows.Count > 0 Then
                        'set the transaction to that highest trans
                        adapQ.UpdateSPCBatchTable(dtTransBulkU65.Rows(0).Item(1), dtTransBulkU65.Rows(0).Item(0), row.BatchNumber)
                    Else
                        'if the only transaction is the 65 for QC set the highest transaction to 0 - to start as no other processes are complete
                        adapQ.UpdateSPCBatchTable(0, dtTransBulk.Rows(0).Item(0), row.BatchNumber)
                    End If

                    'if there are packaging based transactions
                Else

                    'if the pack based transaction is > 65 then set the transaction to the current highest transaction
                    If dtTransPack.Rows(0).Item(1) > 65 Then
                        adapQ.UpdateSPCBatchTable(dtTransPack.Rows(0).Item(1), dtTransPack.Rows(0).Item(0), row.BatchNumber)
                    Else
                        'if the pack based transaction is packaging complete (trans 60 which is < 65)
                        'set the highest transaction to QC complete
                        adapQ.UpdateSPCBatchTable(65, dtTransBulk.Rows(0).Item(0), row.BatchNumber)
                    End If

                End If

                'if bulk trans is not 65
            Else

                'if there are pack trans set to pack trans
                If dtTransPack.Rows.Count > 0 Then
                    adapQ.UpdateSPCBatchTable(dtTransPack.Rows(0).Item(1), dtTransPack.Rows(0).Item(0), row.BatchNumber)

                    'if no pack trans set to highest bulk trans
                ElseIf dtTransBulk.Rows.Count > 0 Then
                    adapQ.UpdateSPCBatchTable(dtTransBulk.Rows(0).Item(1), dtTransBulk.Rows(0).Item(0), row.BatchNumber)
                End If

            End If




            newHighTrans = 0



        Next

    End Sub

#End Region

#Region "Get XFP lot data and enter into table"


    Sub GetLotData(ByVal acct As String)

        Dim OraConn As New OracleConnection
        Dim OraComm As New OracleCommand

        OraConn.ConnectionString = "Data Source=ELANPRD;User Id=ELAN2406PRD;Password=XFP;"
        OraComm.Connection = OraConn

        If acct = "PROD" Then
            'jd 11.03.11 commented out as no longer required.  Set up interface to either overwrite exisiting lots or enter new lots.
            'Dim adapQuery As New InterfaceScraperTableAdapters.QueriesTableAdapter
            'adapQuery.DeleteXFP_Lots()
            OraComm.CommandText = "select codelot, codeart, status, compteurcont, dtdatereception, dtdateanalyse, dtdatelimiteutilisation, dtdateperempt, dtdatedecision,  qualitystatus,ID from elan2406prd.xfp_lots"
        ElseIf acct = "ARCH" Then
            OraComm.CommandText = "select codelot, codeart, status, compteurcont, dtdatereception, dtdateanalyse, dtdatelimiteutilisation, dtdateperempt, dtdatedecision,  qualitystatus,ID from arch2406prd.xfp_lots where dtdatedecision > '01-JAN-08'"
        End If

        OraConn.Open()

        Dim oraRead As OracleDataReader
        oraRead = OraComm.ExecuteReader
        Dim adapXFPLots As New InterfaceScraperTableAdapters.Leap_XFP_LotsTableAdapter

        Dim defaultdate As DateTime = "1/1/2020"

        While oraRead.Read()

            Try

                If Not oraRead.IsDBNull(0) Then

                    Dim codelot, codelottrim As String
                    If Not oraRead.IsDBNull(0) Then
                        codelot = Left(oraRead.GetString(0), 12)
                        codelottrim = trimLot(oraRead.GetString(0))
                    Else
                        codelot = Nothing
                        codelottrim = Nothing
                    End If

                    Dim codeart As String
                    If Not oraRead.IsDBNull(1) Then
                        codeart = Left(oraRead.GetString(1), 12)
                    Else
                        codeart = Nothing
                    End If

                    Dim status As String
                    If Not oraRead.IsDBNull(2) Then
                        status = oraRead.GetString(2)
                    Else
                        status = Nothing
                    End If


                    Dim compteurcont As Integer
                    If Not oraRead.IsDBNull(3) Then
                        compteurcont = oraRead.GetInt32(3)
                    Else
                        compteurcont = Nothing
                    End If

                    Dim dtdatereception As DateTime
                    If Not oraRead.IsDBNull(4) Then
                        dtdatereception = oraRead.GetDateTime(4)
                    Else
                        dtdatereception = defaultdate
                    End If

                    Dim dtdateanalyse As DateTime
                    If Not oraRead.IsDBNull(5) Then
                        dtdateanalyse = oraRead.GetDateTime(5)
                    Else
                        dtdateanalyse = defaultdate
                    End If

                    Dim dtdatelimiteutilisation As DateTime
                    If Not oraRead.IsDBNull(6) Then
                        dtdatelimiteutilisation = oraRead.GetDateTime(6)
                    Else
                        dtdatelimiteutilisation = defaultdate
                    End If

                    Dim dtdateperempt As DateTime
                    If Not oraRead.IsDBNull(7) Then
                        dtdateperempt = oraRead.GetDateTime(7)
                    Else
                        dtdateperempt = defaultdate
                    End If


                    Dim dtdatedecision As Date
                    If Not oraRead.IsDBNull(8) Then
                        dtdatedecision = oraRead.GetDateTime(8)
                    Else
                        dtdatedecision = defaultdate
                    End If


                    Dim qualitystatus As String
                    If Not oraRead.IsDBNull(9) Then
                        qualitystatus = oraRead.GetString(9)
                    Else
                        qualitystatus = Nothing
                    End If

                    Dim id As Integer
                    If Not oraRead.IsDBNull(10) Then
                        id = oraRead.GetInt32(10)
                    Else
                        id = Nothing
                    End If

                    'Check if this lot is already in the table, if so update teh lot if not add a new one

                    Dim qadap As New InterfaceScraperTableAdapters.QueriesTableAdapter
                    If qadap.BatchCountInXFPLotsTable(codelot) > 0 Then

                        adapXFPLots.Update(codelot, codeart, status, compteurcont, dtdatereception, dtdateanalyse, dtdatelimiteutilisation, dtdateperempt, dtdatedecision, qualitystatus, codelottrim, id, codelot)

                    Else

                        adapXFPLots.Insert(codelot, codeart, status, compteurcont, dtdatereception, dtdateanalyse, dtdatelimiteutilisation, dtdateperempt, dtdatedecision, qualitystatus, codelottrim, id)

                    End If


                End If

            Catch ex As Exception

                Dim sr As New StreamWriter("c:/LeaPErrors.txt", True)
                sr.WriteLine(Today & "xfp_lots table error: " & oraRead.GetString(0) & "  " & ex.Message)
                sr.Close()
                sr.Dispose()

            End Try

        End While

        OraConn.Close()
        OraConn.Dispose()
        OraComm.Dispose()
    End Sub

#End Region

#Region "Get XFP status change trace data and enter into table"

    Sub getStatusChangeTraceData(ByVal acct As String)
        Dim maxDateTrace As String = 0
        Dim OraConn As New OracleConnection
        Dim OraComm As New OracleCommand

        OraConn.ConnectionString = "Data Source=ELANPRD;User Id=ELAN2406PRD;Password=XFP;"
        OraComm.Connection = OraConn

        'get the higest transaction date from the file
        Dim adapQ As New InterfaceScraperTableAdapters.QueriesTableAdapter
        Dim highestDate As Date = adapQ.MaxFileWriteDate(6)
        Dim strHighestDate As String = dateToXFPString(highestDate)

        'remove the data from the leap table for the date which is the highest date as we may not have got all the data
        'for that date if transactions occured after interface run

        adapQ.DeleteXFPStatusChangeByDate(strHighestDate)

        'get the data from prod or arch where the date of the trace is greater than the date currently in the interface files table (file type 6)
        If acct = "PROD" Then
            OraComm.CommandText = "select numlot, statutlot,codeart,fonction,datetrace,message from elan2406prd.xfp_lotstraces " & _
            "where (STATUTLOT = 'A' or statutlot = 'R') AND fonction = 'MODIF STATUT LOT' and datetrace >= " & strHighestDate
        ElseIf acct = "ARCH" Then
            OraComm.CommandText = "select numlot, statutlot,codeart,fonction,datetrace,message from arch2406prd.xfp_lotstraces " & _
            "where (STATUTLOT = 'A' or statutlot = 'R') AND fonction = 'MODIF STATUT LOT' and datetrace >= " & strHighestDate
        End If

        OraConn.Open()

        Dim oraRead As OracleDataReader
        oraRead = OraComm.ExecuteReader
        Dim adapXFPStatusTraces As New InterfaceScraperTableAdapters.LeaP_XFP_Status_ChangeTableAdapter


        While oraRead.Read()

            Dim BatchID As String
            If Not oraRead.IsDBNull(0) Then
                BatchID = oraRead.GetString(0)
            Else
                BatchID = Nothing
            End If

            Dim batchidslashtrim As String = trimLot(BatchID)

            Dim status As String
            If Not oraRead.IsDBNull(1) Then
                status = oraRead.GetString(1)
            Else
                status = Nothing
            End If

            Dim itemcode As String
            If Not oraRead.IsDBNull(2) Then
                itemcode = oraRead.GetString(2)
                itemcode = Left(itemcode, 12)
            Else
                itemcode = Nothing
            End If

            Dim Fonction As String
            If Not oraRead.IsDBNull(3) Then
                Fonction = oraRead.GetString(3)
            Else
                Fonction = Nothing
            End If

            Dim DateTrace As String
            If Not oraRead.IsDBNull(4) Then
                DateTrace = oraRead.GetString(4)
            Else
                DateTrace = Nothing
            End If

            If CInt(DateTrace) > CInt(maxDateTrace) Then
                maxDateTrace = DateTrace
            End If

            Dim Message As String
            If Not oraRead.IsDBNull(5) Then
                Message = oraRead.GetString(5)
                Message = Left(Message, 200)
            Else
                Message = Nothing
            End If

            Dim dtDateTrace As Date = dateFromXFPString(DateTrace)

            'check if this record already exists
            Dim rowExists As Integer = adapQ.GetRowCountForXFPStatusChange(BatchID, status, DateTrace)

            If Not rowExists > 0 Then
                adapXFPStatusTraces.Insert(BatchID, status, itemcode, DateTrace, dtDateTrace, Message, Fonction, batchidslashtrim)
            End If

        End While


        Dim intFilesAdap As New InterfaceScraperTableAdapters.HighestTransTableAdapter

        Dim adapTrans As New InterfaceScraperTableAdapters.LeaP_InterfaceFilesTableAdapter
        adapTrans.Insert(6, "XFP_Status", dateFromXFPString(maxDateTrace))

        OraComm.Dispose()
        OraConn.Close()
        OraConn.Dispose()


    End Sub

#End Region

#Region "Get LIMS transaction data and input to lims table"


    Dim maxlimsdate As DateTime = "01/01/1900"


    Sub GetLIMSRecieptAndApprovedDates()
        Dim qAdap As New InterfaceScraperTableAdapters.QueriesTableAdapter
        Dim maxDispDate As Date = qAdap.MaxFileWriteDate(5)

      
        Dim oraRead As OracleDataReader
        Dim batchID As String = "none"

        Try

            'get max disposition date from Interface files table

            Dim tranAdap As New InterfaceScraperTableAdapters.LeaP_TransactionsTableAdapter

            Dim OraConn As New OracleConnection
            Dim OraComm As New OracleCommand

            OraConn.ConnectionString = "Data Source=PROD;User Id=LIMSRO; Password=LIMSRO;"
            OraComm.Connection = OraConn
            'format for server
            OraComm.CommandText = "SELECT a.lot_number, a.lot_name, a.disposition, a.disposition_date, b.x_item_code  FROM LIMS.lot_sampling_point a inner join lims.lot b on a.lot_number = b.lot_number where disposition = 'APPROVED' and disposition_date > to_date('" & CDate(maxDispDate) & "','mm/dd/yyyy hh:mi:ss PM') order by disposition_date asc"
            Debug.Print(OraComm.CommandText)

            Dim sr As New StreamWriter("c:/LeaPErrors.txt", True)
            sr.WriteLine(Today & "lims SQL " & OraComm.CommandText)
            sr.Close()
            sr.Dispose()

            'for use on laptop            OraComm.CommandText = "SELECT a.lot_number, a.lot_name, a.disposition, a.disposition_date, b.x_item_code  FROM LIMS.lot_sampling_point a inner join lims.lot b on a.lot_number = b.lot_number where disposition = 'APPROVED' and disposition_date > to_date('" & CDate(maxDispDate) & "','dd/mm/yyyy hh24:mi:ss') order by disposition_date asc"
            OraConn.Open()

            oraRead = OraComm.ExecuteReader

            While oraRead.Read()

                Dim dispDate As Date = oraRead.GetDateTime(3)
                batchID = oraRead.GetString(1)
                batchID = trimLimsLot(batchID)
                Dim batchIDTrim As String = trimLot(batchID)
                Dim itemcode As String = oraRead.GetString(4)


                If itemcode = "19013758" Then
                    Dim j As Integer = 1000


                End If


                If Not (itemcode = "19013758" Or itemcode = "19013854") Then
                    tranAdap.Insert("LIMSint", 65, dispDate, Now(), 0, batchID, itemcode, batchIDTrim)
                End If


                If dispDate > maxDispDate Then
                    maxDispDate = dispDate
                End If
            End While

            Dim adapTrans As New InterfaceScraperTableAdapters.LeaP_InterfaceFilesTableAdapter
            adapTrans.Insert(5, "LimsInt", maxDispDate)

            OraComm.Dispose()
            OraConn.Close()
            OraConn.Dispose()

        Catch ex As Exception
            Dim adapTrans As New InterfaceScraperTableAdapters.LeaP_InterfaceFilesTableAdapter
            adapTrans.Insert(5, "LimsInt", maxDispDate)

            Dim sr As New StreamWriter("c:/LeaPErrors.txt", True)
            sr.WriteLine(Today & "Lims interface error: " & batchID & "  " & ex.Message)
            sr.Close()
            sr.Dispose()

        End Try

    End Sub


#End Region

#Region "Get XFP sample date and input to transaction table"

    Sub GetXFPSampleDate(ByVal acct As String)
        Dim qAdap As New InterfaceScraperTableAdapters.QueriesTableAdapter
        Dim maxSampDate As Date = qAdap.MaxFileWriteDate(8)
        Dim oraRead As OracleDataReader
        Dim batchID As String = "none"
        Dim clint As New clInterface

        Try


            'get max disposition date from Interface files table

            Dim tranAdap As New PLTInterfaceTableAdapters.PLT_TransactionsTableAdapter

            Dim OraConn As New OracleConnection
            Dim OraComm As New OracleCommand

            'add this line to allow for the fact that there may be more transactions run on the day after the interface is run
            'this may mean double transactions for that batch but the pivottable will look after that
            maxSampDate = DateAdd(DateInterval.Day, -1, maxSampDate)

            Dim lastdate As String = clint.dateToXFPString(maxSampDate)

            OraConn.ConnectionString = "Data Source=ELANPRD;User Id=ELAN2406PRD;Password=XFP;"
            OraComm.Connection = OraConn

            If acct = "PROD" Then
                OraComm.CommandText = "select * from (select Numlot, codeart, min(datetrace) as datetr from elan2406prd.xfp_lotstraces where FONCTION = 'PRELEVEMENT CONT' " & _
                                                  "group by numlot, codeart) where datetr > '" & lastdate & "'"
            ElseIf acct = "ARCH" Then
                OraComm.CommandText = "select * from (select Numlot, codeart, min(datetrace) as datetr from arch2406prd.xfp_lotstraces where FONCTION = 'PRELEVEMENT CONT' " & _
                                          "group by numlot, codeart) where datetr > '" & lastdate & "'"
            End If

            OraConn.Open()

            oraRead = OraComm.ExecuteReader

            While oraRead.Read()

                Dim sampDate As String = oraRead.GetString(2)
                Dim dtSampDate As Date = clint.dateFromXFPString(sampDate)
                batchID = oraRead.GetString(0)
                batchID = trimLimsLot(batchID)
                Dim batchIDTrim As String = trimLot(batchID)
                Dim itemcode As String = oraRead.GetString(1)

                tranAdap.Insert("Sample", 15, dtSampDate, Now(), 0, batchID, batchIDTrim, itemcode, "", "", "")

                If dtSampDate > maxSampDate Then
                    maxSampDate = dtSampDate
                End If
            End While

            Dim adapTrans As New InterfaceScraperTableAdapters.LeaP_InterfaceFilesTableAdapter
            adapTrans.Insert(8, "Sampling", maxSampDate)

            OraComm.Dispose()
            OraConn.Close()
            OraConn.Dispose()

        Catch ex As Exception
            Dim adapTrans As New InterfaceScraperTableAdapters.LeaP_InterfaceFilesTableAdapter
            adapTrans.Insert(8, "Sampling", maxSampDate)

            Dim sr As New StreamWriter("c:/LeaPErrors.txt", True)
            sr.WriteLine(Today & "XFP Sample date interface error: " & batchID & "  " & ex.Message)
            sr.Close()
            sr.Dispose()

        End Try

    End Sub

#End Region

#Region "Copy XFP Items to LeaP Item table"

    Sub GetXFPItemsToLeapItemTable()
        Dim oraRead As OracleDataReader
        Dim qAdap As New InterfaceScraperTableAdapters.QueriesTableAdapter
        Dim adapItem As New InterfaceScraperTableAdapters.LeaP_XFP_ItemsTableAdapter

        Try
            qAdap.DeleteLeapXFPItems()
            Dim OraConn As New OracleConnection
            Dim OraComm As New OracleCommand

            OraConn.ConnectionString = "Data Source=ELANPRD;User Id=ELAN2406PRD;Password=XFP;"
            OraComm.Connection = OraConn

            OraComm.CommandText = "select codeart, designprincipale from elan2406prd.xfp_articles"

            OraConn.Open()

            oraRead = OraComm.ExecuteReader

            While oraRead.Read()

                Dim ItemCode As String = Nothing
                If Not oraRead.IsDBNull(0) Then
                    ItemCode = Trim(oraRead.GetString(0))
                End If

                Dim description As String = Nothing
                If Not oraRead.IsDBNull(1) Then
                    description = Trim(oraRead.GetString(1))
                End If
                adapItem.Insert(ItemCode, description)

            End While

            OraComm.Dispose()
            OraConn.Close()
            OraConn.Dispose()

        Catch ex As Exception

            Dim sr As New StreamWriter("c:/LeaPErrors.txt", True)
            sr.WriteLine(Today & "  XFP Item code interface error: " & ex.Message)
            sr.Close()
            sr.Dispose()

        End Try

    End Sub


#End Region

#Region "Helpers"

    Function trimLot(ByVal Lot As String) As String
        Dim trimArr(5) As Char
        trimArr.SetValue(Chr(46), 0)
        trimArr.SetValue(Chr(47), 1)
        trimArr.SetValue(Chr(92), 2)

        Dim trimIndex As Integer = Lot.IndexOfAny(trimArr)
        Dim trLot As String
        If trimIndex > -1 Then
            trLot = Left(Lot, trimIndex)
        Else
            trLot = Lot
        End If

        Return trLot

    End Function

    Function trimLimsLot(ByVal Lot As String) As String
        Dim trimArr(1) As Char
        trimArr.SetValue(Chr(45), 0)
        Dim trimIndex As Integer = Lot.IndexOfAny(trimArr)
        Dim trLot As String
        If trimIndex > -1 Then
            trLot = Left(Lot, trimIndex)
        Else
            trLot = Lot
        End If

        Return trLot

    End Function

    Function dateFromXFPString(ByVal strDate As String) As Date

        Dim year As Integer = System.Convert.ToInt32(strDate.Substring(0, 4))
        Dim month As Integer = System.Convert.ToInt32(strDate.Substring(4, 2))
        Dim day As Integer = System.Convert.ToInt32(strDate.Substring(6, 2))

        Dim dt = New DateTime(year, month, day)

        Return dt

    End Function
    Function dateToXFPString(ByVal strDate As Date) As String

        Dim str As String = Format(strDate, "yyyyMMdd")
        Return str

    End Function

    Function dateFromEnglishDateString(ByVal strDate As String) As Date

        Dim day As Integer = System.Convert.ToInt32(strDate.Substring(0, 2))
        Dim month As Integer = System.Convert.ToInt32(strDate.Substring(3, 2))
        Dim year As Integer = System.Convert.ToInt32(strDate.Substring(6, 4))

        Dim dt = New DateTime(year, month, day)

        Return dt

    End Function


#End Region
End Class
