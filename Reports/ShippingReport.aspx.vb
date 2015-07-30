Imports System.Security.Principal
Partial Class Reports_ShippingReport
    Inherits System.Web.UI.Page
    Dim ordernumber As String


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            txtStart.Text = DateAdd(DateInterval.Month, -1, Now()).ToString("dd/MM/yyyy")
            txtEnd.Text = DateAdd(DateInterval.Month, 2, Now()).ToString("dd/MM/yyyy")
            gvshipreportdatabind()


        End If
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        gvshipreportdatabind()
    End Sub

    Sub gvshipreportdatabind()


        Dim clint As New clInterface

        Dim dtStart As Date = clint.dateFromEnglishDateString(txtStart.Text)
        Dim dtend As Date = clint.dateFromEnglishDateString(txtEnd.Text)
        odsshippingreport.SelectParameters("startdate").DefaultValue = dtStart
        odsshippingreport.SelectParameters("enddate").DefaultValue = dtend

        gridview1.DataBind()


    End Sub




    Protected Sub GridView1_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand

        Dim adapWkCtrComment As New ShipPlanComTableAdapters.LeaP_wkCtrPerfCommentTableAdapter
        Dim adapQ As New ShipPlanComTableAdapters.QueriesTableAdapter

        If e.CommandName = "SMSent" Then

            If GridView1.DataKeys(e.CommandArgument).Item(1) > 0 Then
                'remove exisitng transaction
                adapQ.DeleteFromWkCtrCommentsSMCOA(GridView1.DataKeys(e.CommandArgument).Item(0), 101)
            Else
                'add new transaction
                adapWkCtrComment.Insert("SM Sent", GridView1.DataKeys(e.CommandArgument).Item(0), 101, Now, WindowsIdentity.GetCurrent.Name, False, False, False, Now(), False)
            End If

        ElseIf e.CommandName = "COASent" Then

            If GridView1.DataKeys(e.CommandArgument).Item(2) > 0 Then
                'remove exisitng transaction
                adapQ.DeleteFromWkCtrCommentsSMCOA(GridView1.DataKeys(e.CommandArgument).Item(0), 102)
            Else
                adapWkCtrComment.Insert("COA Sent", GridView1.DataKeys(e.CommandArgument).Item(0), 102, Now, WindowsIdentity.GetCurrent.Name, False, False, False, Now(), False)
            End If

        ElseIf e.CommandName = "Invoice" Then

            If GridView1.DataKeys(e.CommandArgument).Item(3) > 0 Then
                'remove exisitng transaction
                adapQ.DeleteFromWkCtrCommentsSMCOA(GridView1.DataKeys(e.CommandArgument).Item(0), 103)
            Else
                adapWkCtrComment.Insert("Invoice Recieved", GridView1.DataKeys(e.CommandArgument).Item(0), 103, Now, WindowsIdentity.GetCurrent.Name, False, False, False, Now(), False)
            End If
        End If
        GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            'Dim newOrderNumber As String = e.Row.Cells(0).Text

            'If newOrderNumber = orderNumber Then
            '    e.Row.Cells(0).Text = ""
            '    e.Row.Cells(1).Text = ""
            '    e.Row.Cells(2).Text = ""
            '    e.Row.Cells(3).Text = ""
            '    e.Row.Cells(4).Text = ""
            'Else
            '    orderNumber = newOrderNumber
            'End If

            If GridView1.DataKeys(e.Row.RowIndex).Item(1) > 0 Then
                e.Row.Cells(10).BackColor = Drawing.Color.Green

            End If

            If GridView1.DataKeys(e.Row.RowIndex).Item(2) > 0 Then
                e.Row.Cells(11).BackColor = Drawing.Color.Green

            End If

            If GridView1.DataKeys(e.Row.RowIndex).Item(3) > 0 Then
                e.Row.Cells(12).BackColor = Drawing.Color.Green

            End If


        End If
    End Sub
End Class
