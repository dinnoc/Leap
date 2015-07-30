Imports System.Data.OleDb
Imports System.Data
Partial Class _10wkPlanUpload
    Inherits System.Web.UI.Page




    Protected Sub btnGet10wkData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGet10wkData.Click
        If FileUpload10wkData.HasFile = True Then
            uploadfile("10WK")
        Else
            lblError.Text = "There is no file to upload"
        End If
    End Sub

#Region "Consume Spreadsheet"

    Sub uploadfile(ByVal type As String)

        Dim path As String = FileUpload10wkData.FileName

        If FileUpload10wkData.HasFile Then
            Try
                ' alter path for your project
                FileUpload10wkData.SaveAs(Server.MapPath("~/spcuploads/10wk.xlsx"))


                lblError.Text = "Upload File Name: " & _
                     FileUpload10wkData.PostedFile.FileName & "<br>" & _
                    "Type: " & _
                     FileUpload10wkData.PostedFile.ContentType & _
                    " File Size: " & _
                     FileUpload10wkData.PostedFile.ContentLength & " kb<br>"

            Catch ex As Exception
                lblError.Text = "Error: " & ex.Message.ToString
            End Try
        Else
            lblError.Text = "Please select a file to upload."
        End If
        get10wkdata()
    End Sub

#End Region

#Region "Extract data from 10wk plan upload and update lines"

    Sub get10wkdata()

        Dim dt10 As System.Data.DataTable

        'OPEN CONNECTION TO SPREADSHEET
        Dim path As String = Server.MapPath("spcUploads/10wk.xlsx")
        Dim oleDBconn As New OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & path & ";Extended Properties=Excel 12.0;")

        oleDBconn.Open()

        'READ DATA FROM Uploaddata sheet
        Dim oleDBcomm As New OleDbCommand("Select * from [UploadData$]", oleDBconn)
        Dim oleda As New OleDbDataAdapter
        oleda.SelectCommand = oleDBcomm

        Dim ds As New Data.DataSet

        'FILL SPREADSHEET DATA INTO DATA TABLE
        oleda.Fill(ds, "10wkPlan")
        oleDBconn.Close()
        dt10 = ds.Tables(0)

        Dim countrow As Integer = 0
        Dim adap10wk As New ShipPlanComTableAdapters.LeaP_10wkPlanTableAdapter

        'check if batch number already exists in table

        Dim adapQ As New ShipPlanComTableAdapters.QueriesTableAdapter

        Do Until dt10.Rows(countrow).Item(0).ToString = "" Or countrow >= dt10.Rows.Count - 1
            'set date variable to default
                Dim MPSdate As Date = "01/01/1900"

                'get the data
                Dim WkCtr As Integer = CInt(dt10.Rows(countrow).Item(0).ToString())
                Dim SubWkCtr As String = dt10.Rows(countrow).Item(1).ToString()
                Dim BulkItem As String = dt10.Rows(countrow).Item(2).ToString()
            Dim BatchID As String = dt10.Rows(countrow).Item(3).ToString()



                If IsDate(dt10.Rows(countrow).Item(4).ToString()) Then
                    MPSdate = CDate(dt10.Rows(countrow).Item(4).ToString())
                End If

            Dim Exist10wkPlanID As Object = adapQ.Check10wkForLotNumber(BatchID)

            If Not Exist10wkPlanID Is Nothing Then
                'delete exisiting row
                adapQ.Delete10wkPlanLineForExistingBatch(Exist10wkPlanID)
            End If

            'insert new row
            adap10wk.Insert(WkCtr, SubWkCtr, BulkItem, BatchID, MPSdate, Now)

            countrow = countrow + 1
        Loop

        lblError.Text = "10wk plan data uploaded successfully"

    End Sub


#End Region

  
    Protected Sub DetailsView1_ItemInserted(sender As Object, e As System.Web.UI.WebControls.DetailsViewInsertedEventArgs) Handles DetailsView1.ItemInserted
        GridView1.DataBind()

    End Sub
End Class
