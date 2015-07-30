
Partial Class Safehouse_Default
    Inherits System.Web.UI.Page
    Dim arrOffDays(7) As Integer


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            txtStartDate.Text = Today
            txtEndDate.Text = DateAdd(DateInterval.Year, 1, Today)
        End If

     
    End Sub




   



    Protected Sub btnCreateCalendar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCreateCalendar.Click

        getOffWeekdays()
        fillCalendar()

    End Sub

    Sub getOffWeekdays()
        'get dates from radio button list
        Dim i As Integer
        Do Until i = cblWeekDays.Items.Count

            If cblWeekDays.Items(i).Selected = True Then
                arrOffDays.SetValue(CInt(cblWeekDays.Items(i).Value), i)
            End If
            i = i + 1
        Loop
    End Sub
    Sub fillCalendar()

        Dim startdate As Date = CDate(txtStartDate.Text)
        Dim enddate As Date = CDate(txtEndDate.Text)

        'Set Calendar for a workcentre

        Dim adapCal As New RoutingsTableAdapters.LeaP_CalendarTableAdapter
        Dim adapQ As New RoutingsTableAdapters.QueriesTableAdapter

        adapQ.DeleteCalendarBetweenDates(startdate, enddate)

        Dim currdate As Date = startdate
        Do Until currdate = enddate
            If arrOffDays.Contains(currdate.DayOfWeek) Then
                adapCal.Insert(1, currdate)
            End If
            currdate = DateAdd(DateInterval.Day, 1, currdate)
        Loop


    End Sub

    Protected Sub btnAddDate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddDate.Click
        Dim adapCal As New RoutingsTableAdapters.LeaP_CalendarTableAdapter
        adapCal.Insert(1, calOff.SelectedDate)
        GridView1.DataBind()

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If Weekday(CDate(e.Row.Cells(1).Text)) = 7 Or Weekday(CDate(e.Row.Cells(1).Text)) = 1 Then

                e.Row.BackColor = Drawing.Color.GreenYellow
            Else
                e.Row.BackColor = Drawing.Color.Aqua
            End If
        End If
    End Sub
End Class
