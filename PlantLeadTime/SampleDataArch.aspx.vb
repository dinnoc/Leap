
Partial Class PlantLeadTime_SampleDataArch
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim clinterface As New clInterface
        clinterface.GetXFPItemsToLeapItemTable()
    End Sub
End Class
