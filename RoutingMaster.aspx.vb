
Partial Class RoutingMaster
    Inherits System.Web.UI.Page

    Protected Sub DetailsView2_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsView2.ItemInserting
        odsRouteLInes.InsertParameters("RoutingHeaderID").DefaultValue = DropDownList3.SelectedValue

    End Sub
End Class
