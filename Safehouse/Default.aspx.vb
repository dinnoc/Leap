Imports System.Diagnostics
Imports System.IO

Imports System.Data

Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim adap As New PLTInterfaceTableAdapters.CalculationWithDescriptionTableAdapter
        Dim dt As New PLTInterface.CalculationWithDescriptionDataTable

        dt = adap.GetData()

        Call dumpToCSV(dt, Now.ToLongDateString)



    End Sub


    Sub dumpToCSV(ByVal dt As datatable, ByVal fname As String)

        Dim j As String = ""
        Dim fs As New FileStream("c:\dump " & fname & ".csv", FileMode.Create)
        Dim sw As New StreamWriter(fs)
        Dim strbld As New StringBuilder
        Dim col As Integer = 0

        Do Until col = dt.Columns.Count
            j = j & dt.Columns(col).ColumnName & ";"
            col = col + 1
        Loop

        strbld.AppendLine(j)

        j = ""
        Dim rcol As Integer = 0

        For Each row In dt.Rows

            Do Until rcol = dt.Columns.Count
                j = j & row.Item(rcol).ToString & ";"
                rcol = rcol + 1
            Loop
            strbld.AppendLine(j)

            j = ""
            rcol = 0

        Next

        sw.WriteLine(strbld)
        sw.Flush()
        sw.Close()
        fs.Close()

    End Sub

    Sub htmldump()


        Dim adap As New RoutingsTableAdapters.LeaP_ItemMasterTableAdapter
        Dim dt As New Routings.LeaP_ItemMasterDataTable

        dt = adap.GetData()


        Dim context As HttpContext = HttpContext.Current
        context.Response.Clear()
        Dim col As Integer = 0

        Do Until col = dt.Columns.Count
            context.Response.Write(dt.Columns(col).ColumnName & ";")
            col = col + 1
        Loop

        context.Response.Write(Environment.NewLine)

        Dim rcol As Integer = 0
        Dim j As String = ""

        For Each row As Routings.LeaP_ItemMasterRow In dt

            Do Until rcol = dt.Columns.Count
                j = j & row.Item(rcol).ToString & ";"
                rcol = rcol + 1
            Loop
            context.Response.Write(j)
            Debug.Print(j)
            context.Response.Write(Environment.NewLine)

            j = ""
            rcol = 0


        Next
        context.Response.ContentType = "text/csv"
        context.Response.AppendHeader("Content-Disposition", "attachment; filename=test_dump.csv")
        context.Response.End()





    End Sub




    'Dim qAdap As New InterfaceScraperTableAdapters.QueriesTableAdapter
    'Dim maxDispDate As Date = qAdap.MaxFileWriteDate(5)

    'Response.Write(maxDispDate)



    'Dim limsint As New clInterface
    'limsint.GetLIMSRecieptAndApprovedDates()










    'Response.Write(Request.ServerVariables("SERVER_SOFTWARE"))

    'Dim str As String = " 3156005A "
    'Response.Write("JD" & str & "JD")
    'str = str.Trim
    'Response.Write("JD" & str & "JD")

    'Dim getlims As New clInterface
    'getlims.GenerateRoutings()


    'Dim str As String = "00661635"

    'If str Like "00*" Then

    '    MsgBox("hit")

    'End If


    ' End Sub


    Function dateFromXFPString(ByVal strDate As String) As Date

        Dim year As Integer = System.Convert.ToInt32(strDate.Substring(0, 4))
        Dim month As Integer = System.Convert.ToInt32(strDate.Substring(4, 2))
        Dim day As Integer = System.Convert.ToInt32(strDate.Substring(6, 2))

        Dim dt = New DateTime(year, month, day)

        Return dt

    End Function


End Class
