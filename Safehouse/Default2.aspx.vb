
Partial Class Safehouse_Default2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim arr(0) As Integer

        Array.Resize(arr, arr.Count + 1)

        arr(1) = 6


        Response.Write(arr.Average())



    End Sub

    'Function StdDev(ByVal k As Long, ByVal Arr() As Single)
    '    Dim i As Integer
    '    Dim avg As Single, SumSq As Single


    '    avg = Arr.Average

    '    For i = 1 To k
    '        SumSq = SumSq + (Arr(i) - avg) ^ 2
    '    Next i

    '    StdDev = Sqr(SumSq / (k - 1))

    'End Function



End Class
