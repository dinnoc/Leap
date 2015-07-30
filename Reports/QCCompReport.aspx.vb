
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

    Protected Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        GridView1.DataBind()

    End Sub

    Protected Sub odsQCCompReport_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsQCCompReport.Selecting
        Dim clint As New clInterface

        Dim dtStart As Date = clint.dateFromEnglishDateString(txtStartDate.Text)
        Dim dtend As Date = clint.dateFromEnglishDateString(txtEndDate.Text)

        odsQCCompReport.SelectParameters("startdate").DefaultValue = dtStart
        odsQCCompReport.SelectParameters("enddate").DefaultValue = dtend

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If e.Row.Cells(4).Text = "&nbsp;" Then

                If Not e.Row.Cells(8).Text = "&nbsp;" Then

                    If e.Row.Cells(8).Text < 0 Then
                        e.Row.BackColor = Drawing.Color.Orange

                    End If
                End If

                If Not e.Row.Cells(7).Text = "&nbsp;" Then

                    If e.Row.Cells(7).Text < 0 Then
                        e.Row.Cells(7).BackColor = Drawing.Color.Red
                    End If



                End If


            End If
        End If
    End Sub
End Class
