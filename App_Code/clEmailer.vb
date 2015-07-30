Imports Microsoft.VisualBasic

Public Class clEmailer

    Sub GetNewMessages(ByVal Urgent As Boolean, ByVal senderURL As String)
        Dim msg As String

        'get all results which havent been sent yet

        Dim adapEmail As New ShipPlanComTableAdapters.DailyEmailTableAdapter
        Dim dtEmail As New ShipPlanCom.DailyEmailDataTable

        If Urgent Then
            dtEmail = adapEmail.GetUrgent()
        Else
            dtEmail = adapEmail.GetData()
        End If


        Dim pgURL As String = senderURL
        Dim replyURL As String = Left(pgURL, InStrRev(pgURL, "/")) & "batchview.aspx"
        Dim headermsg As String

        If Urgent Then
            headermsg = "Leap Urgent Update"
        Else
            headermsg = "Leap Daily Update"
        End If

        Dim currWkCtr As String = ""
        msg = "<h1>" & headermsg & "</h1>"

        msg = msg + "<table border = 1>"
        msg = msg + "<tr bgcolor = 'blue'><td> Lot Number</td><td> Message</td><td>Sender</td><td>link</td></tr>"
        For Each row As ShipPlanCom.DailyEmailRow In dtEmail

            If Not currWkCtr = row.WorkCentreDesc And row.InterimApproval = False Then
                msg = msg + "<tr bgcolor = 'yellow'><td colspan = 4><b>" & row.WorkCentreDesc & "</b></td></tr>"
                msg = msg + "<tr><td>" & row.Batchid & "</td><td>" & row.WkCtrPerfComment & "</td><td>" & row.CommUser & "</td><td><a href=" & replyURL & "?BatchID=" & row.Batchid & ">Review</a></td></tr>"
                currWkCtr = row.WorkCentreDesc
            ElseIf row.InterimApproval = False Then
                msg = msg + "<tr><td>" & row.Batchid & "</td><td>" & row.WkCtrPerfComment & "</td><td>" & row.CommUser & "</td><td><a href=" & replyURL & "?BatchID=" & row.Batchid & ">Review</a></td></tr>"
            End If

            If Not currWkCtr = row.WorkCentreDesc And row.InterimApproval = True Then
                msg = msg + "<tr bgcolor = 'green'><td colspan = 4><b>" & row.WorkCentreDesc & " - Interim Approval</b></td></tr>"
                msg = msg + "<tr><td>" & row.Batchid & "</td><td>" & row.WkCtrPerfComment & "</td><td>" & row.CommUser & "</td><td><a href=" & replyURL & "?BatchID=" & row.Batchid & ">Review</a></td></tr>"
                currWkCtr = row.WorkCentreDesc
            ElseIf row.InterimApproval = True Then
                msg = msg + "<tr><td>" & row.Batchid & "</td><td>" & row.WkCtrPerfComment & "</td><td>" & row.CommUser & "</td><td><a href=" & replyURL & "?BatchID=" & row.Batchid & ">Review</a></td></tr>"
            End If


        Next
        msg = msg & "</table>"

        Try
            sendMail("DoNotReply@LeaP.Takeda.ie", "leapEmail@Takeda.dom", headermsg, msg)

            'udpate date sent in email list
            If Not Urgent Then
                Dim adapComm As New ShipPlanComTableAdapters.QueriesTableAdapter
                adapComm.UpdateCommentAfterSend()
            End If

        Catch ex As Exception

        End Try
    End Sub


    Sub sendMail(ByVal [From] As String, ByVal [To] As String, ByVal subject As String, ByVal body As String)

        Dim MailClient As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient("Mail.takeda.ie")

        Dim insMail As New System.Net.Mail.MailMessage( _
        [From], [To], subject, body)
        insMail.IsBodyHtml = True
        MailClient.Send(insMail)

    End Sub
End Class
