
Partial Class WorkCentrePerformance
    Inherits System.Web.UI.Page
    Public rowCount As Integer
    Public okCount As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            txtStartDate.Text = DateAdd(DateInterval.Month, -1, Now()).ToString("dd/MM/yyyy")
            txtEndDate.Text = DateAdd(DateInterval.Month, 1, Now()).ToString("dd/MM/yyyy")
            GridView1.DataBind()

        End If

        If cbPacked.Checked = True Then
            odsPackMgmt.SelectParameters("HighestTransType").DefaultValue = 100
        Else
            odsPackMgmt.SelectParameters("HighestTransType").DefaultValue = 59
        End If




    End Sub

    Protected Sub odsWCPerformance_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsPackMgmt.Selecting

        Dim clint As New clInterface

        Dim dtStart As Date = clint.dateFromEnglishDateString(txtStartDate.Text)
        Dim dtend As Date = clint.dateFromEnglishDateString(txtEndDate.Text)

        odsPackMgmt.SelectParameters("startdate").DefaultValue = dtStart
        odsPackMgmt.SelectParameters("enddate").DefaultValue = dtend

    End Sub


    Protected Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        GridView1.DataBind()

    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "gvBatch" Then
            odsPerformance.SelectParameters("spcBatchID").DefaultValue = GridView1.DataKeys(e.CommandArgument).Value
            GridView3.DataBind()
            mpeBatch.Show()
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If e.Row.Cells(4).Text = "&nbsp;" And e.Row.Cells(5).Text = "&nbsp;" Then
                e.Row.Cells(6).ForeColor = Drawing.Color.Red
            Else
                e.Row.Cells(6).ForeColor = Drawing.Color.Green
                e.Row.Cells(6).Text = "In Stock"

            End If

        End If
    End Sub

    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound

        Dim clint As New clInterface



        If e.Row.RowType = DataControlRowType.DataRow Then

            If Not e.Row.Cells(5).Text = "&nbsp;" Then


                Dim targDate As Date = clint.dateFromEnglishDateString(e.Row.Cells(4).Text)
                Dim actDate As Date = clint.dateFromEnglishDateString(e.Row.Cells(5).Text)

                If targDate < actDate Then
                    e.Row.Cells(5).BackColor = Drawing.Color.Red
                ElseIf targDate > actDate Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                ElseIf targDate = actDate Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                End If


            End If

        End If
    End Sub

 
End Class
