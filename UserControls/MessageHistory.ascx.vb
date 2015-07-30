
Partial Class UserControls_MessageHistory
    Inherits System.Web.UI.UserControl
    Private _spcBatchid As Integer

    Public Property spcBatchid() As Integer
        Get
            Return _spcBatchid
        End Get
        Set(ByVal value As Integer)
            _spcBatchid = value
        End Set
    End Property

    Sub MessageHistory_databind()
        odsBatchComments.SelectParameters(0).DefaultValue = _spcBatchid
        DataList1.DataBind()
    End Sub

End Class
