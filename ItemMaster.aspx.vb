
Partial Class ItemMaster
    Inherits System.Web.UI.Page


    Protected Sub lnkAddItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddItem.Click
        DetailsView1.ChangeMode(DetailsViewMode.Insert)

    End Sub

    Protected Sub odsItemDetails_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsItemDetails.Inserted
        GridView2.DataBind()
    End Sub

    Protected Sub DetailsView1_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsView1.ItemInserting
        'if item already exists then cancel
        lblError.Text = ""
        Dim adapItem As New RoutingsTableAdapters.QueriesTableAdapter
        Dim count As Integer = adapItem.CountOfItemCode(e.Values(0))

        If count > 0 Then
            e.Cancel = True
            lblError.Text = "This Itemcode already exists.  New item not created"
        End If

    End Sub
End Class
