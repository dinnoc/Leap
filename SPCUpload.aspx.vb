Imports System.Data.OleDb
Imports System.Data
Partial Class _Default
    Inherits System.Web.UI.Page
    Public dt As System.Data.DataTable
    Public alphaArr(52) As Char
    Dim arrCal(1000) As Date
    Public stopSPCDelete As Boolean = False
#Region "Page Stuff"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GridView1.DataBind()
        End If
    End Sub
    Protected Sub btnRoutings_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRoutings.Click
        Call GenerateRoutings()
    End Sub

    Protected Sub btnGetData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGetData.Click
        If FileUploadExcel.HasFile = True Then
            uploadfile("SPC")
        Else
            lblError.Text = "There is no file to upload"
        End If
    End Sub

#End Region

#Region "Consume Spreadsheet"

    Sub uploadfile(ByVal type As String)

        Dim path As String = FileUploadExcel.FileName

        If FileUploadExcel.HasFile Then
            Try
                ' alter path for your project

                FileUploadExcel.SaveAs(Server.MapPath("~/spcuploads/SPC.xlsx"))


                lblError.Text = "Upload File Name: " & _
                    FileUploadExcel.PostedFile.FileName & "<br>" & _
                    "Type: " & _
                    FileUploadExcel.PostedFile.ContentType & _
                    " File Size: " & _
                    FileUploadExcel.PostedFile.ContentLength & " kb<br>"

            Catch ex As Exception
                lblError.Text = "Error: " & ex.Message.ToString
            End Try
        Else
            lblError.Text = "Please select a file to upload."
        End If

            getSPCdata()

   
    End Sub

#End Region

#Region "Extract Data from SPC spreadsheet and insert or update lines"
#Region "Get SPC data master"


    Sub getSPCdata()

        'OPEN CONNECTION TO SPREADSHEET
        Dim path As String = Server.MapPath("spcUploads/spc.xlsx")
        Dim oleDBconn As New OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & path & ";Extended Properties=Excel 12.0;")

        'Try

        oleDBconn.Open()

        'READ DATA FROM SHEET1 OF SPREADSHEET
        Dim oleDBcomm As New OleDbCommand("Select * from [sheet1$]", oleDBconn)
        Dim oleda As New OleDbDataAdapter
        oleda.SelectCommand = oleDBcomm

        Dim ds As New Data.DataSet

        'FILL SPREADSHEET DATA INTO DATA TABLE
        oleda.Fill(ds, "ShipPlanCom")

        oleDBconn.Close()
        dt = ds.Tables(0)

        Call setAlphaArr()

        'START AT THE 1ST DATA ROW OF SPREADSHEET
        Dim countRow As Integer = 5
        Dim adapSPC As New ShipPlanComTableAdapters.QueriesTableAdapter

        'check if there is a value in the order no column if no value skip this line
        Do Until countRow >= dt.Rows.Count

            If Not dt.Rows(countRow).Item(2).ToString = "" Then

                'check if there is a c for cancelled in the first column if so skip this line
                If Not dt.Rows(countRow).Item(0).ToString = "C" And Not dt.Rows(countRow).Item(0).ToString = "c" Then

                    Dim TPCOrdNo As String = dt.Rows(countRow).Item(2)
                    If adapSPC.spcIDfromTPCOrderNumber(TPCOrdNo) = Nothing Then
                        'if the tpc order no does not already exist then add a new line
                        spc_insert_new_line(countRow)
                    Else
                        'if the tpc order no already exists, update with new data
                        spc_update_line(countRow, adapSPC.spcIDfromTPCOrderNumber(TPCOrdNo))
                    End If
                End If
            End If

            countRow = countRow + 1
        Loop


        lblError.Text = "Upload Successful"
        GridView1.DataBind()

    End Sub

#End Region

#Region "Insert new SPC line"


    Sub spc_insert_new_line(ByVal countrow As Integer)

        'FILL ALL THE VARIABLES FOR THE INPUT
        Dim TPCOrdNo As String = dt.Rows(countrow).Item(2)
        '--
        Dim TILFinalApproval As Date = Nothing
        If Not IsDBNull(dt.Rows(countrow).Item(4)) Then
            TILFinalApproval = dt.Rows(countrow).Item(4)
        End If
        '--
        Dim TPCConfirmedCollectionDate As Date = Nothing
        If Not IsDBNull(dt.Rows(countrow).Item(7)) Then
            TPCConfirmedCollectionDate = dt.Rows(countrow).Item(7)
        End If
        '--
        Dim itemcode As String = dt.Rows(countrow).Item(8) & dt.Rows(countrow).Item(9)
        '--
        Dim TPCOrderQuantity As Integer = dt.Rows(countrow).Item(12)
        '--
        Dim TILShippingMemoDate As Date
        'check the type of the shipping memo date and set the value on the basis of the type
        Dim TILShippingMemoDateType As Type = dt.Rows(countrow).Item(5).GetType
        If TILShippingMemoDateType.FullName = "System.String" Then
            TILShippingMemoDate = DateTime.FromOADate(CDbl(dt.Rows(countrow).Item(5)))
        ElseIf TILShippingMemoDateType.FullName = "System.DateTime" Then
            TILShippingMemoDate = dt.Rows(countrow).Item(5)
        End If
        '--
        Dim adapSPC As New ShipPlanComTableAdapters.QueriesTableAdapter

        Dim spcline As Integer
        'insert a new line in the SPC table
        adapSPC.InsertSPCLine(itemcode, TPCOrderQuantity, TILFinalApproval, TILShippingMemoDate, TPCConfirmedCollectionDate, TPCOrdNo, 1, Now(), 1, spcline)


        Dim adapBatch As New ShipPlanComTableAdapters.LeaP_spcBatchesTableAdapter

        Dim d As Char = Chr(10)

        Dim tilPlannedlot As String = Nothing
        Dim arrLot() As String = Nothing
        If Not IsDBNull(dt.Rows(countrow).Item(14)) Then
            tilPlannedlot = dt.Rows(countrow).Item(14)
            arrLot = Split(tilPlannedlot, d)
        End If


        Dim arrQty() As String = Nothing
        Dim TILPlannedQuantity As String = Nothing

        If Not IsDBNull(dt.Rows(countrow).Item(13)) Then
            If Not CStr(dt.Rows(countrow).Item(13)) Like "*TBA*" Or CStr(dt.Rows(countrow).Item(13)) = "" Then
                TILPlannedQuantity = dt.Rows(countrow).Item(13)
                arrQty = Split(TILPlannedQuantity, d)
            End If
        End If


        If Not arrLot Is Nothing Then
            'if there are no lots dont add anything

            If Not arrLot(0) = " " Then


                Dim i As Integer = 0
                Do Until i = arrLot.Count

                    Dim lot As String = arrLot(i)
                    Dim alphaIndex As Integer = lot.IndexOfAny(alphaArr)
                    lot = lot.Remove(alphaIndex, Len(lot) - alphaIndex)


                    If arrQty Is Nothing Then
                        'if there are no qtys for lots just put a 0
                        adapBatch.Insert(arrLot(i), spcline, 0, lot, 0, Nothing)
                    ElseIf arrQty(i) = " " Then
                        'if there are no qtys for lots just put a 0
                        adapBatch.Insert(arrLot(i), spcline, 0, lot, 0, Nothing)
                    Else
                        'if there is qty for a lot put it against the lot
                        adapBatch.Insert(arrLot(i), spcline, arrQty(i), lot, 0, Nothing)
                    End If
                    i = i + 1
                Loop

            End If


        End If

        Try

            'add to item master table if not already there

            Dim adapItem As New RoutingsTableAdapters.LeaP_ItemMasterTableAdapter
            adapItem.Insert(itemcode, 1, dt.Rows(countrow).Item(10) & dt.Rows(countrow).Item(11), 1, 1, 1, 1, Nothing, 1)
        Catch ex As Exception

        End Try

    End Sub

#End Region

#Region "Update SPC line and batches"



    Sub spc_update_line(ByVal countrow As Integer, ByVal spcid As Integer)

        'dt is the spreadsheet datatable
        'read the order number
        Dim TPCOrdNo As String = dt.Rows(countrow).Item(2)
        'read the final approval date
        Dim TILFinalApproval As Date = Nothing
        If Not IsDBNull(dt.Rows(countrow).Item(4)) Then
            TILFinalApproval = dt.Rows(countrow).Item(4)
        End If
        'read the confirmed collection date
        Dim TPCConfirmedCollectionDate As Date = Nothing
        If Not IsDBNull(dt.Rows(countrow).Item(7)) Then
            TPCConfirmedCollectionDate = dt.Rows(countrow).Item(7)
        End If
        'read the itemcode
        Dim itemcode As String = dt.Rows(countrow).Item(8) & dt.Rows(countrow).Item(9)
        'read the order quantity
        Dim TPCOrderQuantity As Integer = dt.Rows(countrow).Item(12)
        'read the ship memo date
        Dim TILShippingMemoDate As Date
        Dim TILShippingMemoDateType As Type = dt.Rows(countrow).Item(5).GetType
        If TILShippingMemoDateType.FullName = "System.String" Then
            Try
                TILShippingMemoDate = DateTime.FromOADate(CDbl(dt.Rows(countrow).Item(5)))

            Catch ex As Exception
                TILShippingMemoDate = CDate((dt.Rows(countrow).Item(5)))
            End Try
        ElseIf TILShippingMemoDateType.FullName = "System.DateTime" Then
            TILShippingMemoDate = dt.Rows(countrow).Item(5)
        End If

        '
        Dim adapSPC As New ShipPlanComTableAdapters.QueriesTableAdapter
        adapSPC.UpdateSPCLine(itemcode, TPCOrderQuantity, TILFinalApproval, TILShippingMemoDate, TPCConfirmedCollectionDate, TPCOrdNo, Now(), 3, spcid)

        'delete exisiting batches for spcline
        adapSPC.DeleteBatchesBySPCID(spcid)

        'recreate the batches
        Dim adapBatch As New ShipPlanComTableAdapters.LeaP_spcBatchesTableAdapter

        Dim d As Char = Chr(10)

        Dim tilPlannedlot As String = Nothing
        Dim arrLot() As String = Nothing
        If Not IsDBNull(dt.Rows(countrow).Item(14)) Then
            tilPlannedlot = dt.Rows(countrow).Item(14)
            arrLot = Split(tilPlannedlot, d)
        End If


        Dim arrQty() As String = Nothing
        Dim TILPlannedQuantity As String = Nothing

        If Not IsDBNull(dt.Rows(countrow).Item(13)) Then
            If Not CStr(dt.Rows(countrow).Item(13)) Like "*TBA*" Or CStr(dt.Rows(countrow).Item(13)) = "" Then
                TILPlannedQuantity = dt.Rows(countrow).Item(13)
                arrQty = Split(TILPlannedQuantity, d)
            End If
        End If


        If Not arrLot Is Nothing Then
            'if there are no lots dont add anything

            If Not arrLot(0) = " " Then

                Dim i As Integer = 0
                Do Until i = arrLot.Count

                    Dim lot As String = arrLot(i)
                    Dim alphaIndex As Integer = lot.IndexOfAny(alphaArr)
                    lot = lot.Remove(alphaIndex, Len(lot) - alphaIndex)
                    lot = lot.Trim

                    If arrQty Is Nothing Then
                        'if there are no qtys for lots just put a 0
                        adapBatch.Insert(arrLot(i).Trim, spcid, 0, lot, 0, Nothing)
                    Else
                        'if there is qty for a lot put it against the lot
                        adapBatch.Insert(arrLot(i).Trim, spcid, arrQty(i), lot, 0, Nothing)
                    End If
                    i = i + 1
                Loop

            End If


        End If

    End Sub

#End Region

#End Region



#Region "helpers"


    Sub clear()
        Dim myadap As New ShipPlanComTableAdapters.QueriesTableAdapter
        myadap.DeleteBatches()
        myadap.DeleteSPC()
    End Sub

    Sub setAlphaArr()
        'fills alpha array with upper and lower case a-z A-Z
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

    End Sub


#End Region

#Region "Calc and generate routings"
    Sub generateRoutings()

        Dim genRoutings As New clInterface
        genRoutings.GenerateRoutings()

    End Sub


    'Sub GenerateRoutings()
    '    Dim adapQ As New RoutingsTableAdapters.QueriesTableAdapter
    '    adapQ.DeleteRouteData()

    '    'get all the batches which require routings (perhaps this can be set to only batches which have not shipped or do not have work orders available?)
    '    Dim adap As New dsBatchTableAdapters.BatchDetailsTableAdapter
    '    Dim dt As New dsBatch.BatchDetailsDataTable
    '    dt = adap.GetData()

    '    For Each row As dsBatch.BatchDetailsRow In dt
    '        Call routeit(row)
    '    Next
    '    'for each batch generate a routing
    'End Sub

    'Sub routeit(ByVal row As dsBatch.BatchDetailsRow)
    '    'populate the calendar array

    '    Dim adapCal As New RoutingsTableAdapters.LeaP_CalendarTableAdapter
    '    Dim dtCal As New Routings.LeaP_CalendarDataTable

    '    dtCal = adapCal.GetData

    '    Dim i As Integer

    '    For Each Calrow As Routings.LeaP_CalendarRow In dtCal
    '        arrCal.SetValue(Calrow.OffDate, i)
    '        i = i + 1
    '    Next

    '    'get the routing for this item
    '    Dim adapRouteCalc As New RoutingsTableAdapters.RouteCalcDetailsTableAdapter
    '    Dim dtRouteCalc As New Routings.RouteCalcDetailsDataTable
    '    dtRouteCalc = adapRouteCalc.GetData(row.ItemCode)

    '    'fill in the RouteData Table with the information
    '    Dim enddate As Date = row.TILFinalApprovalDate

    '    If Not enddate = "#12:00:00 AM#" Then

    '        Dim nextWorkCentre As Integer
    '        Dim adapRouteData As New RoutingsTableAdapters.LeaP_RouteDataTableAdapter

    '        'set the routing for shipment for the specific batch
    '        adapRouteData.Insert(row.spcBatchID, 5, row.TPCConfirmedCollectionDate, row.TPCConfirmedCollectionDate, 80, 0, 0)
    '        nextWorkCentre = 5

    '        For Each rowCalc As Routings.RouteCalcDetailsRow In dtRouteCalc
    '            Dim startdate As Date = DateAdd(DateInterval.Day, -calcWorkDays(enddate, rowCalc.TotalDuration), enddate)
    '            adapRouteData.Insert(row.spcBatchID, rowCalc.WorkCentreID, startdate, enddate, rowCalc.WorkCentreCompleteTransaction, nextWorkCentre, rowCalc.ProcessDuration)
    '            enddate = startdate
    '            nextWorkCentre = rowCalc.WorkCentreID
    '        Next
    '    End If
    'End Sub

    'Function calcWorkDays(ByVal enddate As Date, ByVal duration As Integer) As Integer

    '    Dim newduration As Integer
    '    Dim i As Integer

    '    Dim currdate = enddate

    '    Do Until i = duration
    '        If arrCal.Contains(currdate) Then
    '            newduration = newduration + 1
    '            i = i - 1
    '        Else
    '            newduration = newduration + 1
    '        End If

    '        currdate = DateAdd(DateInterval.Day, -1, currdate)
    '        i = i + 1
    '    Loop

    '    Return newduration

    'End Function

#End Region

#Region "Edit and insert handlers"

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand

        Dim SPCID As Integer

        If e.CommandName = "gvEdit" Then
            SPCID = GridView1.DataKeys(e.CommandArgument).Value
            dvEditInsert.ChangeMode(DetailsViewMode.Edit)
            odsSPCDetails.SelectParameters("spcID").DefaultValue = SPCID
            dvEditInsert.DataBind()
            mpeInsertUpdateSPC.Show()

        ElseIf e.CommandName = "gvAudit" Then
            SPCID = GridView1.DataKeys(e.CommandArgument).Value
            Response.Redirect("~\reports\SPCAuditReport.aspx?spcid=" & SPCID)

        End If
    End Sub

    Protected Sub dvEditInsert_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertedEventArgs) Handles dvEditInsert.ItemInserted
        GridView1.DataBind()
    End Sub

    Protected Sub dvEditInsert_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles dvEditInsert.ItemInserting
        odsSPCDetails.InsertParameters("AuditChangedate").DefaultValue = Now()
        odsSPCDetails.InsertParameters("AuditUser").DefaultValue = 2

    End Sub

    Protected Sub dvEditInsert_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewUpdatedEventArgs) Handles dvEditInsert.ItemUpdated
        GridView1.DataBind()
    End Sub
    Protected Sub dvEditInsert_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewUpdateEventArgs) Handles dvEditInsert.ItemUpdating
        odsSPCDetails.UpdateParameters("AuditChangedate").DefaultValue = Now()
        odsSPCDetails.UpdateParameters("AuditUser").DefaultValue = 2

    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting

        Dim adapQRoute As New RoutingsTableAdapters.QueriesTableAdapter
        adapQRoute.DeleteRouteDataBySPCid(e.Keys(0))

        'delete batches
        Dim spcid As Integer = e.Keys(0)
        Dim adapQ As New ShipPlanComTableAdapters.QueriesTableAdapter
        adapQ.DeleteBatchesBySPCID(spcid)
     End Sub
    Protected Sub lnkInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkInsert.Click
        dvEditInsert.ChangeMode(DetailsViewMode.Insert)
        mpeInsertUpdateSPC.Show()
    End Sub
    Protected Sub dvInsertLot_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles dvInsertLot.ItemInserting

        odsLots.InsertParameters("HighestTransType").DefaultValue = 0
        odsLots.InsertParameters("spcid").DefaultValue = GridView1.SelectedDataKey.Value

    End Sub
    Protected Sub GridView4_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView4.RowUpdating
        odsLots.UpdateParameters("HighestTransType").DefaultValue = 0
        odsLots.UpdateParameters("spcid").DefaultValue = GridView1.SelectedDataKey.Value

    End Sub


    Protected Sub lnkInsertLot_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkInsertLot.Click
        dvInsertLot.Visible = True
    End Sub


    Protected Sub odsLots_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsLots.Inserted
        GridView4.DataBind()
        dvInsertLot.Visible = False
    End Sub

#End Region

#Region "Presentation Handlers"
    Public LotNumber As String

    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            If Not e.Row.Cells(5).Text = "&nbsp;" Then
                If CDate(e.Row.Cells(4).Text) < CDate(e.Row.Cells(5).Text) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.Red
                ElseIf CDate(e.Row.Cells(4).Text) > CDate(e.Row.Cells(5).Text) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                ElseIf CDate(e.Row.Cells(4).Text) = CDate(e.Row.Cells(5).Text) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen

                End If
            End If

            Dim newLotNumber As String = e.Row.Cells(1).Text

            If newLotNumber = LotNumber Then

                e.Row.Cells(1).Text = ""
            Else
                LotNumber = newLotNumber
            End If

        End If
    End Sub
    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        mpeDetails.Show()
        GridView3.DataBind()
    End Sub
    Protected Sub lnkClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkClose.Click
        mpeDetails.Hide()
    End Sub

#End Region

#Region "comment Handlers"


    Protected Sub GridView3_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView3.RowCommand

        If e.CommandName = "comment" Then

            Dim batchid As String = GridView3.DataKeys(e.CommandArgument).Values.Item(0)
            Dim wkctrID As Integer = GridView3.DataKeys(e.CommandArgument).Values.Item(1)

            MessageControl1.OpenMessage(batchid, wkctrID, False)

        End If



    End Sub


    Protected Sub MessageControl1_ctrlClosed(ByVal sender As Object, ByVal e As System.EventArgs) Handles MessageControl1.ctrlClosed
        GridView3.DataBind()
        gv3update.Update()

    End Sub






#End Region


End Class
