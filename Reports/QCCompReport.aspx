<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="QCCompReport.aspx.vb" Inherits="WorkCentrePerformance" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="6">
                <h4>QC Compression Report</h4>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                Start Date</td>
            <td>
                <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
           
                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                    TargetControlID="txtStartDate">
                </cc1:CalendarExtender>
           
            </td>
            <td>
                End Date</td>
            <td>
                <p>
                    <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
                </p>
           
                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" 
                    TargetControlID="txtEndDate">
                </cc1:CalendarExtender>
           
            </td>
            <td>
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" />
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataSourceID="odsQCCompReport" Width="100%" 
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" GridLines="Horizontal">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="PackBatch" HeaderText="PackBatch" 
                            SortExpression="PackBatch" />
                        <asp:BoundField DataField="BulkBatch" HeaderText="BulkBatch" 
                            SortExpression="BulkBatch" />
                        <asp:BoundField DataField="TargetCompMandec" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="TargetCompMandec" SortExpression="TargetCompMandec" />
                        <asp:BoundField DataField="MonthlySchedDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="MonthlySchedDate" SortExpression="MonthlySchedDate" />
                        <asp:BoundField DataField="ActualCompMandecDate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="ActualCompMandecDate" 
                            ReadOnly="True" SortExpression="ActualCompMandecDate" />
                        <asp:BoundField DataField="IntermediateBatchStatus" 
                            HeaderText="IntermediateBatchStatus" SortExpression="IntermediateBatchStatus" />
                        <asp:BoundField DataField="QCTargetDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="QCTargetDate" ReadOnly="True" SortExpression="QCTargetDate" />
                        <asp:BoundField DataField="CompDays" HeaderText="CompDays" 
                            SortExpression="CompDays" />
                        <asp:BoundField DataField="MPSDays" HeaderText="MPSDays" 
                            SortExpression="MPSDays" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsQCCompReport" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="TestAndShipTableAdapters.QCCompressionReportTableAdapter">
                    <SelectParameters>
                        <asp:Parameter Name="StartDate" Type="String" />
                        <asp:Parameter Name="EndDate" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <br />
            </td>
        </tr>
        <tr>
            <td colspan="6">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

