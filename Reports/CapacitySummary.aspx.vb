
Partial Class WorkCentrePerformance
    Inherits System.Web.UI.Page
    Public rowCount As Integer
    Public okCount As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        txtStartDate.Text = DateAdd(DateInterval.Month, -1, Now()).ToString("dd/MM/yyyy")
        txtEndDate.Text = Now().ToString("dd/MM/yyyy")
   

    End Sub



 
End Class
