
Partial Class WorkCentrePerformance
    Inherits System.Web.UI.Page
    Public rowCount As Integer
    Public okCount As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            txtStartDate.Text = DateAdd(DateInterval.Month, -1, Now()).ToString("dd/MM/yyyy")
            txtEndDate.Text = Now().ToString("dd/MM/yyyy")
            GridView1.DataBind()

        End If

    End Sub

    Sub gv1Databind()
        Dim clint As New clInterface

        Dim dtStart As Date = clint.dateFromEnglishDateString(txtStartDate.Text)
        Dim dtend As Date = clint.dateFromEnglishDateString(txtEndDate.Text)

        odsWCPerformance.SelectParameters("startdate").DefaultValue = dtStart
        odsWCPerformance.SelectParameters("enddate").DefaultValue = dtend

        GridView1.DataBind()
    End Sub

    Protected Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click

        gv1Databind()
    End Sub

    Protected Sub GridView1_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBinding

    End Sub

    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        lblTotal.Text = rowCount
        lblOK.Text = okCount
        lblPerformance.Text = okCount / rowCount * 100

    End Sub

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
                rowCount = rowCount + 1

                If CInt(e.Row.Cells(8).Text) >= 0 Then
                    okCount = okCount + 1
                Else
                    e.Row.Cells(8).BackColor = Drawing.Color.Red
                End If

            ElseIf e.Row.Cells(8).Text = "&nbsp;" Then
                e.Row.Cells(8).BackColor = Drawing.Color.Orange
                e.Row.Cells(6).BackColor = Drawing.Color.Orange
            ElseIf Not IsDBNull(GridView1.DataKeys(e.Row.RowIndex).Item(2)) Then
                e.Row.Cells(9).BackColor = Drawing.Color.Black
            End If



        End If
    End Sub

    Protected Sub MessageControl1_ctrlClosed() Handles MessageControl1.ctrlClosed
        gv1Databind()
        gvUpdate.Update()
    End Sub




End Class
