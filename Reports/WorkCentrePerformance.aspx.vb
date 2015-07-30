
Partial Class WorkCentrePerformance
    Inherits System.Web.UI.Page
    Public rowCount As Integer
    Public okCount As Integer
    Public arrUSL(0) As Integer
    Public arrActual(0) As Integer


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            txtStartDate.Text = DateAdd(DateInterval.Month, -1, Now()).ToString("dd/MM/yyyy")
            txtEndDate.Text = Now().ToString("dd/MM/yyyy")
            GridView1.DataBind()
        End If


        Try
            Dim adapTrans As New RoutingsTableAdapters.QueriesTableAdapter
            lblTransType.Text = adapTrans.WorkCentreTransByWkCtrID(DropDownList1.SelectedValue)
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

        Dim transtype As Integer

        If cbIncomplete.Checked = True Then
            transtype = lblTransType.Text
        Else
            transtype = 1000
        End If


        odsWCPerformance.SelectParameters("startdate").DefaultValue = dtStart
        odsWCPerformance.SelectParameters("enddate").DefaultValue = dtend
        odsWCPerformance.SelectParameters("TransType").DefaultValue = transtype

        GridView1.DataBind()
    End Sub


    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound

        If GridView1.Rows.Count > 1 Then

            lblTotal.Text = rowCount
            lblOK.Text = okCount
            lblPerformance.Text = okCount / rowCount * 100

            If arrActual.Count > 1 Then
                'calc stdev of Actual array

                Array.Resize(arrUSL, arrUSL.Count - 1)
                Array.Resize(arrActual, arrActual.Count - 1)

                Dim ActStdev As Single = StdDev(arrActual)
                Dim ActMean As Single = arrActual.Average
                Dim USLMean As Single = arrUSL.Average

                Dim cpL As Single = (ActMean - 0) / 3 * ActStdev
                Dim cpU As Single = (USLMean - ActMean) / 3 * ActStdev

                Dim cpK As Single

                If cpL < cpU Then
                    cpK = cpL
                Else
                    cpK = cpU
                End If

                lblAverageActual.Text = ActMean
                lblStdevActual.Text = ActStdev
                lblAvgTarget.Text = USLMean
                lblCpK.Text = cpK

            End If

        End If

    End Sub
    Function StdDev(ByVal Arr() As Integer) As Single

        Dim i As Integer
        Dim avg As Single, SumSq As Single
        Dim k As Integer = Arr.Count - 1

        avg = Arr.Average
        For i = 0 To k
            SumSq = SumSq + (Arr(i) - avg) ^ 2
        Next i

        StdDev = (SumSq / (k)) ^ (1 / 2)

    End Function



#Region "Gridview Handlers"

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand

        If Not e.CommandName = "Sort" Then

            Dim batchid As String = GridView1.DataKeys(e.CommandArgument).Values.Item(1)

            If e.CommandName = "gvBatch" Then
                'open batchview page in new window
            End If

            If e.CommandName = "Exception" Then
                If Not IsDBNull(GridView1.DataKeys(e.CommandArgument).Item(2)) Then
                    'if this batch has an exception already then remove the exception

                    Dim adapExcl As New ShipPlanComTableAdapters.QueriesTableAdapter
                    adapExcl.RemoveExclusion(batchid, DropDownList1.SelectedValue)
                    GridView1.DataBind()

                Else
                    'if this batch has no exception at the moment then add one via comment
                    MessageControl1.OpenMessage(batchid, DropDownList1.SelectedValue, True)
                End If

            End If
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then


            If Not e.Row.Cells(8).Text = "&nbsp;" And IsDBNull(GridView1.DataKeys(e.Row.RowIndex).Item(2)) Then

                Array.Resize(arrUSL, arrUSL.Count + 1)
                Array.Resize(arrActual, arrActual.Count + 1)

                'add the upper spec into the array for each line on the grid
                arrUSL(arrUSL.Count - 2) = GridView1.DataKeys(e.Row.RowIndex).Item(3)
                'add the actual spec into teh array for each line on the grid
                arrActual(arrActual.Count - 2) = GridView1.DataKeys(e.Row.RowIndex).Item(4)

                rowCount = rowCount + 1

                If CInt(e.Row.Cells(8).Text) >= 0 Then
                    okCount = okCount + 1
                Else
                    e.Row.Cells(8).BackColor = Drawing.Color.Red
                End If


                'if the order and actual item code dont match and its on the shipment report then color red
                If e.Row.Cells(2).Text <> e.Row.Cells(7).Text And (DropDownList1.SelectedValue = 5 Or DropDownList1.SelectedValue = 4) Then
                    e.Row.Cells(7).BackColor = Drawing.Color.Red
                End If

            ElseIf e.Row.Cells(8).Text = "&nbsp;" Then
                e.Row.Cells(8).BackColor = Drawing.Color.Orange
                e.Row.Cells(6).BackColor = Drawing.Color.Orange
            ElseIf Not IsDBNull(GridView1.DataKeys(e.Row.RowIndex).Item(2)) Then
                e.Row.Cells(9).BackColor = Drawing.Color.Black
            End If



        End If
    End Sub
#End Region



End Class
