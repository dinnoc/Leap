Imports System.IO

Partial Class Safehouse_accesstest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim path As String = "C:\Documents and Settings\dinnissj\My Documents\SourceCode\LeaP Source\Interface\Archive\Archive"
        path = "C:\Documents and Settings\dinnissj\My Documents\SourceCode\AuditTest"

        'get the files in the directory

        Dim files() As String = Directory.GetFiles(path)
    End Sub
End Class
