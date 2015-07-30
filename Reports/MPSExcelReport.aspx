<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="MPSExcelReport.aspx.vb" Inherits="Reports_MPSExcelReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="odsMPSExcel" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="workcentredesc" HeaderText="workcentredesc" 
                SortExpression="workcentredesc" />
            <asp:BoundField DataField="subwkctr" HeaderText="subwkctr" 
                SortExpression="subwkctr" />
            <asp:BoundField DataField="bulkitem" HeaderText="bulkitem" 
                SortExpression="bulkitem" />
            <asp:BoundField DataField="lotnumber" HeaderText="lotnumber" 
                SortExpression="lotnumber" />
            <asp:BoundField DataField="MPSDate" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="MPSDate" SortExpression="MPSDate" />
            <asp:BoundField DataField="MPSUpload_date" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="MPSUpload_date" SortExpression="MPSUpload_date" />
            <asp:BoundField DataField="intermediate_status" 
                HeaderText="intermediate_status" SortExpression="intermediate_status" />
            <asp:BoundField DataField="mandec_date" DataFormatString="{0:dd/MM/yyyy}" 
                HeaderText="mandec_date" SortExpression="mandec_date" />
            <asp:BoundField DataField="MPSminusMANDEC" HeaderText="MPSminusMANDEC" 
                SortExpression="MPSminusMANDEC" ReadOnly="True" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="odsMPSExcel" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="dsBatchTableAdapters.MPSExcelReportTableAdapter">
    </asp:ObjectDataSource>
    <p>
    </p>
</asp:Content>

