
Partial Class PlantLeadTime_PLTRouting
    Inherits System.Web.UI.Page


    Protected Sub DetailsView2_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles DetailsView2.ItemInserting
        odsRoute.InsertParameters("RouteHeader").DefaultValue = DropDownList1.SelectedValue
    End Sub
End Class
