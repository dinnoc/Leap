Imports System.Security.Principal


Partial Class BWI_BWIManagement
    Inherits System.Web.UI.Page
    Public db As New BWIDataContext

   
    Protected Sub btnShowPRLots_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowPRLots.Click

        TrackWiseList1.PRID = txtPRnumber.Text
        TrackWiseList1.ControlDataBind()

    End Sub

    Protected Sub btnAddLots_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddLots.Click
        'if there is no BWI number for this screen add one
        If lblBWINumber.Text = "" Then
            Dim bwiID As Integer
            db.InsertBWI(txtPRnumber.Text, WindowsIdentity.GetCurrent.Name, Now(), bwiID)
            lblBWINumber.Text = bwiID
        End If

        Dim bwiLOT As New LeaP_BWILot
        bwiLOT.bwiID = lblBWINumber.Text
        bwiLOT.bwiLotNumber = txtLot.Text
        bwiLOT.ContainerIDs = txtPartial.Text

        db.LeaP_BWILots.InsertOnSubmit(bwiLOT)
        db.SubmitChanges()

        getBWIlots(lblBWINumber.Text)

    End Sub

    Protected Sub ddlBWISelection_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlBWISelection.SelectedIndexChanged
        lblBWINumber.Text = ddlBWISelection.SelectedValue
        Dim q = (From c In db.LeaP_BWIHeaders Where c.bwiID = lblBWINumber.Text Select c.PRNumber).Single
        txtPRnumber.Text = q
        getBWIlots(lblBWINumber.Text)
    End Sub

    Sub getBWIlots(ByVal BWIid As Integer)

        Dim q = From c In db.LeaP_BWILots Where c.bwiID = BWIid
        gvBWIlots.DataSource = q
        gvBWIlots.DataBind()

    End Sub
End Class
