
Partial Class PlantLeadTime_Reports_AutoPivot
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim routeid As Integer = -1

        routeid = Request.QueryString("RouteID")

        If routeid <> -1 Then

            Dim ds As PLTReporting
            Dim dt As New PLTReporting.AllRouteTransTableAutoRandomStartPivotDataTable

            Dim pivotTA As New PLTReportingTableAdapters.AllRouteTransTableAutoRandomStartPivotTableAdapter

            pivotTA.SetCommandTimeOut(60000)

            pivotTA.Fill(dt, routeid)

            GridView1.DataSource = dt

            GridView1.DataBind()
        End If





    End Sub
End Class
