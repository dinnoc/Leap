
Partial Class Reports_DailyEmail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim emailer As New clEmailer
        emailer.GetNewMessages(False, Request.Url.AbsoluteUri)

    End Sub

End Class
