
Partial Class BatchWorkCentreStatus
    Inherits System.Web.UI.Page
    Public lotnumber As String
    Public orderNumber As String


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim newOrderNumber As String = e.Row.Cells(1).Text

            If newOrderNumber = orderNumber Then
                e.Row.Cells(0).Text = ""
                e.Row.Cells(1).Text = ""
                e.Row.Cells(2).Text = ""
                e.Row.Cells(3).Text = ""
                e.Row.Cells(4).Text = ""
                e.Row.Cells(5).Text = ""
            Else
                orderNumber = newOrderNumber
            End If

            If e.Row.Cells(7).Text = "Q" Or e.Row.Cells(7).Text = "H" Then
                e.Row.Cells(7).BackColor = Drawing.Color.Orange
            ElseIf e.Row.Cells(7).Text = "R" Then
                e.Row.Cells(7).BackColor = Drawing.Color.Red
            End If


        End If
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        ModalPopupExtender1.Show()
        GridView3.DataBind()
    End Sub


    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            If Not e.Row.Cells(5).Text = "&nbsp;" Then
                If CDate(e.Row.Cells(4).Text) < CDate(e.Row.Cells(5).Text) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.Red
                ElseIf CDate(e.Row.Cells(4).Text) > CDate(e.Row.Cells(5).Text) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                ElseIf CDate(e.Row.Cells(4).Text) = CDate(e.Row.Cells(5).Text) Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                End If
            End If

            Dim newLotNumber As String = e.Row.Cells(1).Text

            If newLotNumber = LotNumber Then
                e.Row.Cells(0).Text = ""
                e.Row.Cells(1).Text = ""
            Else
                lotnumber = newLotNumber
              
            End If

        End If
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        ModalPopupExtender1.Hide()

    End Sub
End Class
