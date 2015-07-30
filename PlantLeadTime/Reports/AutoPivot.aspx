<%@ Page Title="" Language="VB" MasterPageFile="~/PLT.master" AutoEventWireup="false" CodeFile="AutoPivot.aspx.vb" Inherits="PlantLeadTime_Reports_AutoPivot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="odsAutoPivot">
        <Columns>
            <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" 
                SortExpression="BatchNo" />
            <asp:BoundField DataField="itemcode" HeaderText="itemcode" 
                SortExpression="itemcode" />
            <asp:BoundField DataField="180" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="180" SortExpression="180" />
            <asp:BoundField DataField="170" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="170" SortExpression="170" />
            <asp:BoundField DataField="140" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="140" SortExpression="140" />
            <asp:BoundField DataField="145" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="145" SortExpression="145" />
            <asp:BoundField DataField="130" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="130" SortExpression="130" />
            <asp:BoundField DataField="115" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="115" SortExpression="115" />
            <asp:BoundField DataField="110" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="110" SortExpression="110" />
            <asp:BoundField DataField="245" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="245" SortExpression="245" />
            <asp:BoundField DataField="240" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="240" SortExpression="240" />
            <asp:BoundField DataField="230" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="230" SortExpression="230" />
            <asp:BoundField DataField="215" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="215" SortExpression="215" />
            <asp:BoundField DataField="210" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="210" SortExpression="210" />
            <asp:BoundField DataField="345" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="345" SortExpression="345" />
            <asp:BoundField DataField="340" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="340" SortExpression="340" />
            <asp:BoundField DataField="330" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="330" SortExpression="330" />
            <asp:BoundField DataField="315" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="315" SortExpression="315" />
            <asp:BoundField DataField="310" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="310" SortExpression="310" />
            <asp:BoundField DataField="445" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="445" SortExpression="445" />
            <asp:BoundField DataField="440" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="440" SortExpression="440" />
            <asp:BoundField DataField="430" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="430" SortExpression="430" />
            <asp:BoundField DataField="415" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="415" SortExpression="415" />
            <asp:BoundField DataField="410" DataFormatString="{0:dd/MM/yyyy 00:00:00}" 
                HeaderText="410" SortExpression="410" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="odsAutoPivot" runat="server" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="PLTReportingTableAdapters.AllRouteTransTableAutoRandomStartPivotTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="routeID" QueryStringField="routeID" 
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

