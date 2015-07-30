
Partial Class Reports_MPSShedulePerformance
    Inherits System.Web.UI.Page
    Dim rowcount As Integer
    Dim goodCount As Integer



    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            txtStart.Text = DateAdd(DateInterval.Month, -1, Now()).ToString("dd/MM/yyyy")
            txtEnd.Text = Now().ToString("dd/MM/yyyy")

        End If
    End Sub

 
    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        Call gvPerfDatabind()
    End Sub

    Sub gvPerfDataBind()

        Dim clint As New clInterface

        Dim dtStart As Date = clint.dateFromEnglishDateString(txtStart.Text)
        Dim dtend As Date = clint.dateFromEnglishDateString(txtEnd.Text)

        odsMPSPerformance.SelectParameters("startdate").DefaultValue = dtStart
        odsMPSPerformance.SelectParameters("enddate").DefaultValue = dtend
        odsMPSPerformance.SelectParameters("wkCtr").DefaultValue = ddlwkCtr.SelectedValue

        gvMPSPerformance.DataBind()


    End Sub


    Protected Sub gvMPSPerformance_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvMPSPerformance.RowDataBound





        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim clint As New clInterface

            Dim MPSTarget As Date = clint.dateFromEnglishDateString(e.Row.Cells(3).Text)
            Dim LeapActual As Date = clint.dateFromEnglishDateString(e.Row.Cells(4).Text)


            rowcount = rowcount + 1

            If Not (e.Row.Cells(3).Text = "&nbsp;" Or e.Row.Cells(4).Text = "&nbsp;") Then

                If CDate(MPSTarget) < CDate(LeapActual) Then

                    e.Row.Cells(5).BackColor = Drawing.Color.Red

                End If
            End If

            If (e.Row.Cells(3).Text <> "&nbsp;" And e.Row.Cells(4).Text = "&nbsp;") Then

                If CDate(MPSTarget) < Now() Then

                    e.Row.Cells(5).BackColor = Drawing.Color.Orange
                    rowcount = rowcount - 1

                End If
            End If

            If Not (e.Row.Cells(3).Text = "&nbsp;" Or e.Row.Cells(4).Text = "&nbsp;") Then

                e.Row.Cells(5).Text = DateDiff(DateInterval.Day, CDate(LeapActual), CDate(MPSTarget))

                If e.Row.Cells(5).Text >= 0 Then
                    goodCount = goodCount + 1
                End If


            End If
        End If

        lblGoodBatches.Text = goodCount
        lblTotalBatches.Text = rowcount
        lblPerformance.Text = Math.Round(goodCount / rowcount * 100, 0) & " %"



    End Sub
End Class
