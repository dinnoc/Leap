
Partial Class ARCHXFPSCRAPER
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim getlims As New clInterface
        getlims.getStatusChangeTraceData("ARCH")


    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim getlims As New clInterface
        getlims.getStatusChangeTraceData("PROD")

    End Sub
End Class
