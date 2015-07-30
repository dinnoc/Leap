<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="PackMgmtReport.aspx.vb" Inherits="WorkCentrePerformance" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="6">
                <h4>Packaging Management Report</h4>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="cbPacked" runat="server" Text="Show Packed Lots" />
            </td>
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
                <ul>
                    <li>
                        <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
                    </li>
                </ul>
           
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
                    AutoGenerateColumns="False" DataSourceID="odsPackMgmt" Width="100%" 
                    DataKeyNames="spcBatchID" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    GridLines="Horizontal" style="text-align: center">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                            SortExpression="ItemCode" />
                        <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                            SortExpression="ItemDescription" />
                        <asp:ButtonField CommandName="gvBatch" DataTextField="BatchNumber" />
                        <asp:BoundField DataField="TargetpackEndDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="TargetpackEndDate" SortExpression="TargetpackEndDate" />
                        <asp:BoundField DataField="TabletMandec" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Tablet Mandec" SortExpression="TabletMandec" ReadOnly="True" />
                        <asp:BoundField DataField="TabletReceiptDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Tablet Receipt" SortExpression="TabletReceiptDate" 
                            ReadOnly="True" />
                        <asp:BoundField DataField="ExpectedTabMandec_Receipt" HeaderText="Expected Tablet Receipt/Mandec" 
                            SortExpression="ExpectedTabMandec_Receipt" 
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Description" HeaderText="Description" 
                            SortExpression="Description" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsPackMgmt" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="TestAndShipTableAdapters.PackManagementReportTableAdapter">
                    <SelectParameters>
                        <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                        <asp:Parameter Name="highestTranstype" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <cc1:ModalPopupExtender ID="mpeBatch" runat="server" PopupControlID="pnlBatch" 
                    TargetControlID="lnkHidden">
                </cc1:ModalPopupExtender>
                <asp:LinkButton ID="lnkHidden" runat="server"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td colspan="6">
    <asp:Panel ID="pnlBatch" runat="server" BackColor="#FFFFCC" ScrollBars="Vertical" 
                        BorderStyle="Double" BorderWidth="4px" Height="600px" Width="1250px">
    
    
    <div>
  
        <asp:ObjectDataSource ID="odsPerformance" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy" 
            TypeName="dsBatchTableAdapters.BatchRouteActualDetailsTableAdapter">
            <SelectParameters>
                <asp:Parameter Name="spcbatchID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table class="style1">
            <tr>
                <td>
                    Ship Plan Com Order Details</td>
                <td align="right">
                    <asp:LinkButton ID="lnkClose" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px">Close</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <div >
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="odsPerformance" BackColor="White" BorderColor="#E7E7FF" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        GridLines="Horizontal" Width="100%">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                                SortExpression="TPCOrderNo" />
                            <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                                SortExpression="BatchNumber" />
                            <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="StartDate" SortExpression="StartDate" />
                            <asp:BoundField DataField="WorkCentreDesc" HeaderText="WorkCentreDesc" 
                                SortExpression="WorkCentreDesc" />
                            <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="EndDate" SortExpression="EndDate" />
                            <asp:BoundField DataField="TransDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="TransDate" SortExpression="TransDate" />
                            <asp:BoundField DataField="BatchID" HeaderText="BatchID" 
                                SortExpression="BatchID" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                SortExpression="Quantity" />
                            <asp:BoundField DataField="WorkCentreID" HeaderText="WorkCentreID" 
                                SortExpression="WorkCentreID" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        
          </div>
    </asp:Panel>
                </td>
        </tr>
        <tr>
            <td colspan="6">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

