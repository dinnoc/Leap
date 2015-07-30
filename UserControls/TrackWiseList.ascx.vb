Imports Oracle.DataAccess.Client
Imports Oracle.DataAccess.Types
Imports System.Data

Partial Class UserControls_TrackWiseList
    Inherits System.Web.UI.UserControl

    Private _BatchTrimID As String
    Private _PRID As String


    Public Property BatchTrimID() As String
        Get
            Return _BatchTrimID
        End Get
        Set(ByVal value As String)
            _BatchTrimID = value

        End Set
    End Property

    Public Property PRID() As String
        Get
            Return _PRID

        End Get
        Set(ByVal value As String)
            _PRID = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ControlDataBind()
    End Sub
    Sub ControlDataBind()

        Try

            If Not BatchTrimID = Nothing Or Not PRID = Nothing Then

                Dim oradb As String = "Data Source=TWPROD;User Id=JAMES;Password=dinnissj;"

                Dim conn As New OracleConnection(oradb)
                conn.Open()

                Dim cmd As New OracleCommand
                cmd.Connection = conn

                If Not _BatchTrimID = Nothing Then
                    cmd.CommandText = "Select a.pr_id, b.name, c.name as status, a.s_value,a.data_field_id from TWPROD.pr_addtl_data a " & _
                        "inner join twprod.PR b on a.pr_id = b.id " & _
                        "inner join twprod.pr_status_type c on c.id = b.status_type " & _
                        "where a.s_value like '%" & _BatchTrimID & "%' and (a.data_field_id = 80 or a.data_field_id = 179)"

                ElseIf Not _PRID = Nothing Then
                    cmd.CommandText = "select a.id,a.name, b.s_value, b.data_field_id from twprod.pr a " & _
                                "inner join twprod.pr_addtl_data b on a.id = b.pr_id " & _
                                "where (b.data_field_id = 80 ) and a.id = " & _PRID

                End If


                cmd.CommandType = CommandType.Text

                Dim OraDS As New DataSet
                Dim OraAdap As New OracleDataAdapter

                OraAdap.SelectCommand = cmd
                OraAdap.Fill(OraDS)

                GridView1.DataSource = OraDS
                GridView1.DataBind()

                cmd.Dispose()
                conn.Dispose()


            End If

        Catch ex As Exception

            GridView1.EmptyDataText = "An error has occured with trackwise data retrieval"
            GridView1.DataBind()


        End Try


    End Sub


End Class
