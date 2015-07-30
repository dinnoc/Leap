<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SPCSummaryFullView.aspx.vb" MasterPageFile ="~/LeaPBack.master"  Inherits="BatchWorkCentreStatus"  MaintainScrollPositionOnPostback = "true" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div>
    
        <table class="style1">
            <tr>
                <td>
                    <h4>
                        ShipPlanCom Summary Report</h4>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox ID="cbShipped" runat="server" AutoPostBack="True" 
                        Text="Show Shipped Lots" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ScriptManager ID="ScriptManager2" runat="server">
                    </asp:ScriptManager>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" DataKeyNames="spcID" 
                        DataSourceID="odsBatchWorkCentre" BackColor="White" BorderColor="#DEDFDE" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" 
                        GridLines="Vertical">
                        <RowStyle BackColor="#F7F7DE" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                                SortExpression="TPCOrderNo" />
                            <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                                SortExpression="ItemCode" />
                            <asp:BoundField DataField="ItemDescription" 
                                HeaderText="ItemDescription" 
                                SortExpression="ItemDescription" >
                            </asp:BoundField>
                            <asp:BoundField DataField="TPCConfirmedCollectionDate" 
                                DataFormatString="{0:dd/MM/yyyy}" HeaderText="TPCConfirmedCollectionDate" 
                                SortExpression="TPCConfirmedCollectionDate" />
                            <asp:HyperLinkField DataNavigateUrlFields="BatchNumber" 
                                DataNavigateUrlFormatString="~/reports/batchview.aspx?BatchID={0}" 
                                DataTextField="BatchNumber" DataTextFormatString="{0}" />
                            <asp:BoundField DataField="qualityStatus" HeaderText="qualityStatus" 
                                SortExpression="qualityStatus" />
                            <asp:BoundField DataField="BatchID" HeaderText="BatchID" 
                                SortExpression="BatchID" >
                            </asp:BoundField>
                            <asp:BoundField DataField="LastWkCtrDesc" HeaderText="LastWkCtrDesc" 
                                SortExpression="LastWkCtrDesc" >
                            </asp:BoundField>
                            <asp:BoundField DataField="LastWkCtrTargetEndDate" HeaderText="LastWkCtrTargetEndDate" 
                                SortExpression="LastWkCtrTargetEndDate" 
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="LastWkCtrActual" HeaderText="LastWkCtrActual" 
                                SortExpression="LastWkCtrActual" 
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="NextWkCtrDesc" HeaderText="NextWkCtrDesc" 
                                SortExpression="NextWkCtrDesc" DataFormatString="{0:dd/MM/yyyy}" >
                            </asp:BoundField>
                            <asp:BoundField DataField="NextWkCtrTargetEndDate" HeaderText="NextWkCtrTargetEndDate" 
                                SortExpression="NextWkCtrTargetEndDate" DataFormatString="{0:dd/MM/yyyy}" >
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ObjectDataSource ID="odsBatchWorkCentre" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                        TypeName="dsBatchTableAdapters.SPCFullViewTableAdapter">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="80" Name="HighestTransID" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
    <div>
        <table class="style1">
            <tr>
                <td>

    <asp:LinkButton ID="lnkhidden" runat="server"></asp:LinkButton>
                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
                        PopupControlID="panel1" TargetControlID="lnkHidden">
                    </cc1:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="#FFFFCC" ScrollBars="Vertical" 
                        BorderStyle="Double" BorderWidth="4px" Height="600px" Width="1000px">
    
    
    <div>
  
        <asp:ObjectDataSource ID="odsPerformance" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="dsBatchTableAdapters.BatchRouteActualDetailsTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="spcid" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table class="style1">
            <tr>
                <td>
                    Ship Plan Com Order Details</td>
                <td align="right">
                    <asp:LinkButton ID="LinkButton1" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px">Close</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <div >
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="odsPerformance" BackColor="White" BorderColor="#E7E7FF" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
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
            <tr>
            <td colspan = 2> Comments for this shipping order.</td></tr>
            <tr>
                <td colspan="2">
                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" DataKeyNames="spcAuditID" DataSourceID="odsSPCAudit" 
                        GridLines="Horizontal">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="AuditDate" HeaderText="AuditDate" 
                                SortExpression="AuditDate" />
                            <asp:BoundField DataField="auditComment" HeaderText="auditComment" 
                                SortExpression="auditComment" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <EmptyDataTemplate>
                            There are no comments for this order
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="odsSPCAudit" runat="server" DeleteMethod="Delete" 
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="GetData" 
                        TypeName="ShipPlanComTableAdapters.LeaP_ShipPlanComAuditTableAdapter" 
                        UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_spcAuditID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="spcID" Type="Int32" />
                            <asp:Parameter Name="Shipped" Type="Boolean" />
                            <asp:Parameter Name="Type" Type="String" />
                            <asp:Parameter Name="TPCOrderNo" Type="String" />
                            <asp:Parameter Name="TPCShippingInfo" Type="String" />
                            <asp:Parameter Name="TILFinalApprovalDate" Type="DateTime" />
                            <asp:Parameter Name="TILShippingMemoDate" Type="DateTime" />
                            <asp:Parameter Name="TILProposedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="TPCConfirmedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="TPCOrderQuantity" Type="Decimal" />
                            <asp:Parameter Name="Destination" Type="String" />
                            <asp:Parameter Name="TILUpdate" Type="DateTime" />
                            <asp:Parameter Name="TPCUpdate" Type="DateTime" />
                            <asp:Parameter Name="OriginalInputDate" Type="DateTime" />
                            <asp:Parameter Name="LeaPStatus" Type="Int32" />
                            <asp:Parameter Name="AuditDate" Type="DateTime" />
                            <asp:Parameter Name="AuditUser" Type="Int32" />
                            <asp:Parameter Name="auditComment" Type="String" />
                            <asp:Parameter Name="Original_spcAuditID" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView1" Name="spcid" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="spcID" Type="Int32" />
                            <asp:Parameter Name="Shipped" Type="Boolean" />
                            <asp:Parameter Name="Type" Type="String" />
                            <asp:Parameter Name="TPCOrderNo" Type="String" />
                            <asp:Parameter Name="TPCShippingInfo" Type="String" />
                            <asp:Parameter Name="TILFinalApprovalDate" Type="DateTime" />
                            <asp:Parameter Name="TILShippingMemoDate" Type="DateTime" />
                            <asp:Parameter Name="TILProposedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="TPCConfirmedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="TPCOrderQuantity" Type="Decimal" />
                            <asp:Parameter Name="Destination" Type="String" />
                            <asp:Parameter Name="TILUpdate" Type="DateTime" />
                            <asp:Parameter Name="TPCUpdate" Type="DateTime" />
                            <asp:Parameter Name="OriginalInputDate" Type="DateTime" />
                            <asp:Parameter Name="LeaPStatus" Type="Int32" />
                            <asp:Parameter Name="AuditDate" Type="DateTime" />
                            <asp:Parameter Name="AuditUser" Type="Int32" />
                            <asp:Parameter Name="auditComment" Type="String" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
        </table>
        
          </div>
    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <br />
                </td>
            </tr>
        </table>
    
    </div>
    
    </asp:Content>

