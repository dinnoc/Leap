
Partial Class Reports_BatchView
    Inherits System.Web.UI.Page

    Protected Sub GridView3_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView3.RowCommand
        If e.CommandName = "AddComment" Then

            Dim wkctrid As Integer = GridView3.DataKeys(e.CommandArgument).Values(0).ToString
            MessageControl1.OpenMessage(GridView3.DataKeys(e.CommandArgument).Values(1).ToString, wkctrid)

        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            If Not Request.QueryString("batchID") = Nothing Then

                Dim adapSPC As New ShipPlanComTableAdapters.QueriesTableAdapter
                lblBatch.Text = adapSPC.GetSPCBatchNumber(Request.QueryString("BatchID"))
                txtBatch.Text = Left(Request.QueryString("BatchID"), 7) & "%"
                GridView3.DataBind()
                MessageHistory1.spcBatchid = lblBatch.Text
                MessageHistory1.MessageHistory_databind()
                Call BindTrackwiseList(lblBatch.Text)

                Try

                    GridView4.DataBind()

                Catch ex As Exception

                End Try

            End If
        End If

    End Sub

    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound
        Dim clint As New clInterface



        If e.Row.RowType = DataControlRowType.DataRow Then

            If Not e.Row.Cells(5).Text = "&nbsp;" Then


                Dim targDate As Date = clint.dateFromEnglishDateString(e.Row.Cells(4).Text)
                Dim actDate As Date = clint.dateFromEnglishDateString(e.Row.Cells(5).Text)

                If targDate < actDate Then
                    e.Row.Cells(5).BackColor = Drawing.Color.Red
                ElseIf targDate > actDate Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                ElseIf targDate = actDate Then
                    e.Row.Cells(5).BackColor = Drawing.Color.LightGreen
                End If

            End If

        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        DataList2.DataBind()

    End Sub
    Protected Sub DataList2_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList2.ItemCommand

        Dim spcBatchID As Integer = e.CommandArgument

        lblBatch.Text = spcBatchID

        Dim lnkbtn As LinkButton = e.CommandSource


        txtBatch.Text = Left(lnkbtn.Text, 7) & "%"

        GridView4.DataBind()
        MessageHistory1.spcBatchid = spcBatchID
        MessageHistory1.MessageHistory_databind()

        'get batch trim from batchID
        Call BindTrackwiseList(spcBatchID)

    End Sub

    Sub BindTrackwiseList(ByVal spcbatchid As Integer)
        Try


            Dim adapQ As New ShipPlanComTableAdapters.QueriesTableAdapter
            Dim batchTrim As String = adapQ.BatchTrimBySpcBatchID(spcbatchid)
            TrackWiseList1.BatchTrimID = batchTrim
            TrackWiseList1.ControlDataBind()

        Catch ex As Exception

        End Try
    End Sub


    Protected Sub MessageControl1_ctrlClosed(ByVal sender As Object, ByVal e As System.EventArgs) Handles MessageControl1.ctrlClosed
        GridView3.DataBind()
        MessageHistory1.MessageHistory_databind()
        UpdatePanel1.Update()

    End Sub

 

End Class
