
Partial Class WorkCentrePerformance
    Inherits System.Web.UI.Page
    Public rowCount As Integer
    Public okCount As Integer
    Public arrUSL(0) As Integer
    Public arrActual(0) As Integer
    Public getTWCount As New clInterface

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            txtStartDate.Text = Now().ToString("dd/MM/yyyy")
            txtEndDate.Text = DateAdd(DateInterval.Month, 2, Now()).ToString("dd/MM/yyyy")

        End If

        Try
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        gv1Databind()
    End Sub

    Protected Sub MessageControl1_ctrlClosed() Handles MessageControl1.ctrlClosed
        gv1Databind()
        gvUpdate.Update()
    End Sub

    Sub gv1Databind()
        Dim clint As New clInterface

        Dim dtStart As Date = clint.dateFromEnglishDateString(txtStartDate.Text)
        Dim dtend As Date = clint.dateFromEnglishDateString(txtEndDate.Text)
        odsWCPerformance.SelectParameters("startdate").DefaultValue = dtStart
        odsWCPerformance.SelectParameters("enddate").DefaultValue = dtend
        GridView1.DataBind()




    End Sub


#Region "Gridview Handlers"


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            ' Dim batchidtrim As String = e.Row.Cells(7).Text
            Dim batchidtrim As String = GridView1.DataKeys(e.Row.RowIndex).Item(1)

            Dim prCount As Integer = 1 'getTWCount.GetTWPRCount(batchidtrim)

            Dim batchid As String = GridView1.DataKeys(e.Row.RowIndex).Item(0)

            Dim adap As New ODBCTableAdapters.BRTSBatchDataTableAdapter
            Dim dt As New ODBC.BRTSBatchDataDataTable
            dt = adap.GetData(batchid)

            If dt.Rows.Count > 0 Then
                Dim dr As ODBC.BRTSBatchDataRow = dt.Rows(0)
                e.Row.Cells(8).Text = dr.qp_name
                e.Row.Cells(9).Text = dr.qa_name
                e.Row.Cells(10).Text = dr.qc_rec
                e.Row.Cells(11).Text = dr.qa_rec
                e.Row.Cells(12).Text = dr.qa_rev
                e.Row.Cells(13).Text = dr.prim_qp
            End If

            If prCount > 0 Then
                e.Row.Cells(10).Text = prCount
            Else
                e.Row.Cells(10).Text = ""
            End If

        End If
    End Sub
#End Region



End Class
