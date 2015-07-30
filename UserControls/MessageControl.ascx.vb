Imports System.Security.Principal
Imports System.Net.Mail

Partial Class ctrlClosedEventArgs
    Inherits EventArgs

End Class


Partial Class UserControls_MessageControl
    Inherits System.Web.UI.UserControl


    Public Event ctrlClosed(ByVal sender As Object, _
                    ByVal e As EventArgs)

    Public Sub OpenMessage(ByVal Batchid As String, ByVal workcentreID As Integer, Optional ByVal exception As Boolean = False)

        txtBatchNumbers.Text = ""
        lblMessage.Text = ""

        If Not Batchid = "" Then
            txtBatchNumbers.Text = Batchid & ";"
            ' ddlBatch.SelectedValue = Batchid
        End If

        If Not workcentreID = 0 Then
            ddlWkCtr.SelectedValue = workcentreID
        End If

        If exception = True Then
            cbException.Checked = True
        Else
            cbException.Checked = False
        End If

        lbluser.Text = WindowsIdentity.GetCurrent.Name
        MPEMessage.Show()

    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        MPEMessage.Hide()
        RaiseEvent ctrlClosed(sender, New ctrlClosedEventArgs())

    End Sub

    'Protected Sub lnkAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAdd.Click
    '    'txtBatchNumbers.Text = txtBatchNumbers.Text & ddlBatch.SelectedValue & ";"
    '    'MPEMessage.Show()
    'End Sub

    Protected Sub lnkRemove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRemove.Click
        Dim str As String = txtBatchNumbers.Text

        Dim lastColonPosition As Integer = InStrRev(str, ";")
        str = Left(str, lastColonPosition - 1)
        lastColonPosition = InStrRev(str, ";")
        str = Left(str, lastColonPosition)

        txtBatchNumbers.Text = str

        MPEMessage.Show()

    End Sub

    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSend.Click

        Try

            Dim adap As New ShipPlanComTableAdapters.LeaP_wkCtrPerfCommentTableAdapter
            Dim lotadap As New ShipPlanComTableAdapters.LeaP_spcBatchesTableAdapter
            Dim lotdt As New ShipPlanCom.LeaP_spcBatchesDataTable



            'Get batch string and split into array
            Dim str As String = txtBatchNumbers.Text
            Dim arr = str.Split(";")
            Dim x As Integer
            Dim dNull As Nullable(Of DateTime)
            Dim count As Integer = 0

            Do Until x = arr.Length - 1

                If cbAllBulk.Checked = True Then
                    'get all lots with the same bulk lot number
                    lotdt = lotadap.GetDataByBatchTrimmed(Left(arr(x), 7))
                    For Each row As ShipPlanCom.LeaP_spcBatchesRow In lotdt
                        count = count + adap.Insert(txtMessage.Text, row.BatchNumber, ddlWkCtr.SelectedValue, Now(), lbluser.Text, cbUrgent.Checked, cbFIO.Checked, cbInterimApproval.Checked, dNull, cbException.Checked)
                    Next
                    x = x + 1
                Else
                    count = count + adap.Insert(txtMessage.Text, arr(x), ddlWkCtr.SelectedValue, Now(), lbluser.Text, cbUrgent.Checked, cbFIO.Checked, cbInterimApproval.Checked, dNull, cbException.Checked)
                    x = x + 1
                End If

            Loop

            Dim msg As String = Server.HtmlEncode(txtMessage.Text)

            If cbUrgent.Checked = True Then

                Dim emailer As New clEmailer
                emailer.GetNewMessages(True, Request.Url.AbsoluteUri)

            End If


            lblMessage.Text = "    " & count & " message(s) were successfully logged."
            '  MPEMessage.Show()
            MPEMessage.Hide()
            RaiseEvent ctrlClosed(sender, New ctrlClosedEventArgs())

        Catch ex As Exception
            lblMessage.Text = "This message was not successfully sent.  Please contact support"
        End Try

    End Sub

    Sub sendMail(ByVal [From] As String, ByVal [To] As String, ByVal subject As String, ByVal body As String)

        Dim MailClient As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient("Mail.takeda.ie")

        Dim insMail As New System.Net.Mail.MailMessage( _
        [From], [To], subject, body)
        insMail.IsBodyHtml = True
        MailClient.Send(insMail)

    End Sub



  
    Protected Sub btnAutoComm_Click(sender As Object, e As System.EventArgs) Handles btnAutoComm.Click
        txtMessage.Text = txtMessage.Text & " -- " & ddlAutoComment.SelectedValue
        MPEMessage.Show()
    End Sub
End Class
