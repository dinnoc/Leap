
Partial Class TestAndShip
    Inherits System.Web.UI.Page
    Dim lastLot As String


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim thisLot As String = e.Row.Cells.Item(2).Text

            If thisLot = lastLot Then
                e.Row.Cells.Item(0).Text = ""
                e.Row.Cells.Item(1).Text = ""
                e.Row.Cells.Item(2).Text = ""
            End If

            lastLot = thisLot

        End If

    End Sub
End Class
