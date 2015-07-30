<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="ExceptionReport.aspx.vb" Inherits="Reports_MPSExcelReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="odsMPSException" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="WkCtrPerfComment" HeaderText="WkCtrPerfComment" 
                SortExpression="WkCtrPerfComment" />
            <asp:BoundField DataField="Batchid" HeaderText="Batchid" 
                SortExpression="Batchid" />
            <asp:BoundField DataField="WkCtrID" HeaderText="WkCtrID" 
                SortExpression="WkCtrID" />
            <asp:BoundField DataField="CommUser" HeaderText="CommUser" 
                SortExpression="CommUser" />
            <asp:BoundField DataField="commentdate" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="commentdate" SortExpression="commentdate" />
            <asp:BoundField DataField="workcentredesc" 
                HeaderText="workcentredesc" SortExpression="workcentredesc" />
            <asp:BoundField DataField="transactiondate" 
                HeaderText="transactiondate" SortExpression="transactiondate" 
                DataFormatString="{0:dd/MM/yyyy}" ReadOnly="True" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="odsMPSException" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="dsBatchTableAdapters.ExceptionReportTableAdapter">
    </asp:ObjectDataSource>
    <p>
    </p>
</asp:Content>

