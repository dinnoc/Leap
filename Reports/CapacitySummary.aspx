<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="CapacitySummary.aspx.vb" Inherits="WorkCentrePerformance" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="6">
                <h4>Work Centre Performance</h4>
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
             
                    <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
               
           
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
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="6">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" DataSourceID="odsCapacityHistorical" GridLines="Horizontal" 
                    Width="100%">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="yearES" HeaderText="yearES" ReadOnly="True" 
                            SortExpression="yearES" />
                        <asp:BoundField DataField="monthES" HeaderText="monthES" ReadOnly="True" 
                            SortExpression="monthES" />
                        <asp:BoundField DataField="totalduration" HeaderText="totalduration" 
                            ReadOnly="True" SortExpression="totalduration" DataFormatString="{0:n}" />
                        <asp:BoundField DataField="workcentredesc" HeaderText="workcentredesc" 
                            SortExpression="workcentredesc" />
                        <asp:BoundField DataField="numberofbatches" HeaderText="numberofbatches" 
                            ReadOnly="True" SortExpression="numberofbatches" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsCapacityHistorical" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="CapacityTableAdapters.CapacityByWorkcentreHistoricalViewTableAdapter">
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

