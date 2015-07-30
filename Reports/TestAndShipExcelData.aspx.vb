
Partial Class Reports_TestAndShipExcelData
    Inherits System.Web.UI.Page
    Public clint As New clInterface

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblStart.Text = DateAdd(DateInterval.Month, -2, Now()).ToString("MM/dd/yyyy")
        lblEnd.Text = DateAdd(DateInterval.Month, 4, Now()).ToString("MM/dd/yyyy")

       


        odsTestAndShip.SelectParameters("startdate").DefaultValue = CStr(lblStart.Text)
        odsTestAndShip.SelectParameters("enddate").DefaultValue = CStr(lblEnd.Text)


        GridView1.DataBind()


    End Sub


 
End Class
