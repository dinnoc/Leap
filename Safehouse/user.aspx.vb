
Partial Class Safehouse_user
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim User = System.Security.Principal.WindowsIdentity.GetCurrent.User
        Dim UserName = User.Translate(GetType(System.Security.Principal.NTAccount)).Value
        Label1.Text = UserName
    End Sub
End Class
