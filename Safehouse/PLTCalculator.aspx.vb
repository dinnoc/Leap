Imports System.Diagnostics
Imports System.IO
Imports System.Data

Partial Class PlantLeadTime_PLTCalculator
    Inherits System.Web.UI.Page
    Dim ItemArr(10) As String
    Dim routeHeaderID As Integer
    Dim starttime As DateTime
    Dim endtime As DateTime


    Sub CalculatePlantLeadTime()
        starttime = Now()

        routeHeaderID = DropDownList1.SelectedValue

        '1 select all batches with a given finished item code

        Dim adapQuery As New PLTInterfaceTableAdapters.QueriesTableAdapter
        adapQuery.DeleteCalculations()

        Dim adapCalc As New PLTInterfaceTableAdapters.PLT_CalculatorTableAdapter

        Dim AdapFin As New PLTInterfaceTableAdapters.PLT_TransactionsTableAdapter
        Dim dtFin As New PLTInterface.PLT_TransactionsDataTable

        Dim adapRoute As New PLTInterfaceTableAdapters.PLT_RoutingsTableAdapter
        Dim dtRoute As New PLTInterface.PLT_RoutingsDataTable


        dtRoute = adapRoute.GetDataBy(routeHeaderID, 1)

        For Each rowRoute As PLTInterface.PLT_RoutingsRow In dtRoute

            dtFin = AdapFin.GetDataBy(rowRoute.Itemcode, 80, DateAdd(DateInterval.Year, -1, Now()), Now())

            For Each row As PLTInterface.PLT_TransactionsRow In dtFin
                'add shipping date to table
                Dim shipdate As Date = adapQuery.SelectTransDate(row.BatchNoTrim, row.ItemCode, 80)
                adapCalc.Insert(row.BatchNoTrim, row.BatchNo, row.ItemCode, 80, shipdate, 1)

                Try
                    'add status change of finsihed lot to table
                    Dim approveDate As Date = adapQuery.SelectTransDate(row.BatchNoTrim, row.ItemCode, 70)
                    If Not approveDate = "#12:00:00 AM#" Then
                        adapCalc.Insert(row.BatchNoTrim, row.BatchNo, row.ItemCode, 70, approveDate, 1)
                    End If


                    Dim mandecdate As Date = adapQuery.SelectTransDate(row.BatchNoTrim, row.ItemCode, 40)
                    If Not mandecdate = "#12:00:00 AM#" Then
                        adapCalc.Insert(row.BatchNoTrim, row.BatchNo, row.ItemCode, 60, mandecdate, 1)
                    End If

                    'get the items at the next level down and get the data for them

                    '          Debug.Print("****Finished  ---  Item:" & row.ItemCode & ";BatchNo:" & row.BatchNoTrim & ":topParentLot:" & row.BatchNoTrim)


                    Dim adapNextRoute As New PLTInterfaceTableAdapters.PLT_RoutingsTableAdapter
                    Dim dtNextRoute As New PLTInterface.PLT_RoutingsDataTable

                    'for each item code at the new level find the transactions assocaited with that batch

                    dtNextRoute = adapNextRoute.GetDataBy(routeHeaderID, 2)

                    For Each rowNextRoute As PLTInterface.PLT_RoutingsRow In dtNextRoute

                        Select Case rowNextRoute.NextItemDesignation
                            Case 2
                                intDates(rowNextRoute.Itemcode, row.BatchNoTrim, 2, row.BatchNoTrim)
                            Case 3

                                'raw materials case
                        End Select

                    Next

                Catch ex As Exception
                End Try

            Next
        Next
        endtime = Now()

        Call selectCalculatorData()

        lblRunTime.Text = DateDiff(DateInterval.Second, starttime, endtime) & " ---  Data dumped to .csv"


    End Sub
    Sub intDates(ByVal itemcode As String, ByVal BatchNoTrim As String, ByVal level As Integer, ByVal TopParentLot As String)
        'item code = itemcode of consumed material, batchnotrim = batch number of parent lot, level = level, topParentLot = Finished product lot

        ' Debug.Print("   Intermediate  ---  Item:" & itemcode & ";BatchNo:" & BatchNoTrim & ":topParentLot:" & TopParentLot & ";level:" & level)

        Dim adapCalc As New PLTInterfaceTableAdapters.PLT_CalculatorTableAdapter
        'Get the batchNoTrim which was consumed to the parent batch with the level 2 item code
        Dim adapQuery As New PLTInterfaceTableAdapters.QueriesTableAdapter
        Dim consBatchNo As String = adapQuery.GetConsumedBatchNumberByParentLotItem(BatchNoTrim, itemcode)

        'Debug.Print("   Intermediate batchno: " & consBatchNo)

        If Not consBatchNo = Nothing Then
            'get consumption date of intermediate
            Dim consDate As Date = adapQuery.ConsumptionDate(itemcode, BatchNoTrim)
            If Not consDate = "#12:00:00 AM#" Then
                adapCalc.Insert(TopParentLot, consBatchNo, itemcode, 50, consDate, level)
            End If

            'get mandec date of intermediate
            Dim mandecDate As Date = adapQuery.SelectTransDate(consBatchNo, itemcode, 40)
            If Not mandecDate = "#12:00:00 AM#" Then
                adapCalc.Insert(TopParentLot, consBatchNo, itemcode, 40, mandecDate, level)
            End If



            Dim adapNextRoute As New PLTInterfaceTableAdapters.PLT_RoutingsTableAdapter
            Dim dtNextRoute As New PLTInterface.PLT_RoutingsDataTable

            'for each item code at the new level find the transactions assocaited with that batch

            dtNextRoute = adapNextRoute.GetDataBy(routeHeaderID, level + 1)

            For Each rowNextRoute As PLTInterface.PLT_RoutingsRow In dtNextRoute

                Select Case rowNextRoute.NextItemDesignation
                    Case 2
                        intDates(rowNextRoute.Itemcode, consBatchNo, level + 1, TopParentLot)
                    Case 3
                        rawDates(rowNextRoute.Itemcode, consBatchNo, level + 1, TopParentLot)
                End Select

            Next
        End If
    End Sub
    Sub rawDates(ByVal itemcode As String, ByVal batchnotrim As String, ByVal level As Integer, ByVal topParentLot As String)

        ' Debug.Print("       RawMats --- Item:" & itemcode & ";BatchNo:" & batchnotrim & ":topParentLot:" & topParentLot)

        Dim adapCalc As New PLTInterfaceTableAdapters.PLT_CalculatorTableAdapter

        Dim adapQuery As New PLTInterfaceTableAdapters.QueriesTableAdapter
        Dim consBatchNo As String = adapQuery.GetConsumedBatchNumberByParentLotItem(batchnotrim, itemcode)

        'Debug.Print("          RawBatchNo:" & consBatchNo)

        If Not consBatchNo = Nothing Then

            'get the consumption date of the new item to the parent lot
            Dim consDate As Date = adapQuery.ConsumptionDate(itemcode, batchnotrim)
            If Not consDate = "#12:00:00 AM#" Then
                adapCalc.Insert(topParentLot, consBatchNo, itemcode, 30, consDate, level)
            End If

            'get the status change date of batch
            Dim approveDate As Date = adapQuery.SelectTransDate(consBatchNo, itemcode, 45)
            If Not approveDate = "#12:00:00 AM#" Then
                adapCalc.Insert(topParentLot, consBatchNo, itemcode, 20, approveDate, level)
                'Debug.Print("           Approve" & approveDate)
            End If

            'get the sampling date of batch
            Dim sampDate As Date = adapQuery.SelectTransDate(consBatchNo, itemcode, 15)
            If Not approveDate = "#12:00:00 AM#" Then
                adapCalc.Insert(topParentLot, consBatchNo, itemcode, 15, sampDate, level)
                'Debug.Print("           Samp" & sampDate)
            End If


            'get the reciept date of batch
            Dim receiptDate As Date = adapQuery.SelectTransDate(consBatchNo, itemcode, 10)
            If Not receiptDate = "#12:00:00 AM#" Then
                adapCalc.Insert(topParentLot, consBatchNo, itemcode, 10, receiptDate, level)
                ' Debug.Print("           rec" & receiptDate)
            End If
        End If




    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Call CalculatePlantLeadTime()
    End Sub

    Sub selectCalculatorData()

        Dim adap As New PLTInterfaceTableAdapters.CalculationWithDescriptionTableAdapter
        Dim dt As New PLTInterface.CalculationWithDescriptionDataTable

        dt = adap.GetData()

        Call dumpToCSV(dt, DropDownList1.SelectedItem.Text & " - " & Now.ToLongDateString)

    End Sub
    Sub dumpToCSV(ByVal dt As datatable, ByVal fname As String)

        Dim j As String = ""
        Dim fs As New FileStream("c:\dump " & fname & ".csv", FileMode.Create)
        Dim sw As New StreamWriter(fs)
        Dim strbld As New StringBuilder
        Dim col As Integer = 0

        Do Until col = dt.Columns.Count
            j = j & dt.Columns(col).ColumnName & ";"
            col = col + 1
        Loop

        strbld.AppendLine(j)

        j = ""
        Dim rcol As Integer = 0

        For Each row In dt.Rows

            Do Until rcol = dt.Columns.Count
                j = j & row.Item(rcol).ToString & ";"
                rcol = rcol + 1
            Loop
            strbld.AppendLine(j)

            j = ""
            rcol = 0

        Next

        sw.WriteLine(strbld)
        sw.Flush()
        sw.Close()
        fs.Close()

    End Sub



End Class
