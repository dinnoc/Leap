<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="SPCAuditReport.aspx.vb" Inherits="Reports_SPCAuditReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td>
                <h4>
                    Ship Plan Com Audit Report</h4>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" DataKeyNames="spcAuditID" DataSourceID="odsSPCAudit" 
                    GridLines="Horizontal">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="spcAuditID" HeaderText="spcAuditID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="spcAuditID" />
                        <asp:BoundField DataField="spcID" HeaderText="spcID" SortExpression="spcID" />
                        <asp:CheckBoxField DataField="Shipped" HeaderText="Shipped" 
                            SortExpression="Shipped" />
                        <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                        <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                            SortExpression="TPCOrderNo" />
                        <asp:BoundField DataField="TPCShippingInfo" HeaderText="TPCShippingInfo" 
                            SortExpression="TPCShippingInfo" />
                        <asp:BoundField DataField="TILFinalApprovalDate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="TILFinalApprovalDate" 
                            SortExpression="TILFinalApprovalDate" />
                        <asp:BoundField DataField="TILShippingMemoDate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="TILShippingMemoDate" 
                            SortExpression="TILShippingMemoDate" />
                        <asp:BoundField DataField="TILProposedCollectionDate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="TILProposedCollectionDate" 
                            SortExpression="TILProposedCollectionDate" />
                        <asp:BoundField DataField="TPCConfirmedCollectionDate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="TPCConfirmedCollectionDate" 
                            SortExpression="TPCConfirmedCollectionDate" />
                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                            SortExpression="ItemCode" />
                        <asp:BoundField DataField="TPCOrderQuantity" HeaderText="TPCOrderQuantity" 
                            SortExpression="TPCOrderQuantity" />
                        <asp:BoundField DataField="Destination" HeaderText="Destination" 
                            SortExpression="Destination" />
                        <asp:BoundField DataField="TILUpdate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="TILUpdate" SortExpression="TILUpdate" />
                        <asp:BoundField DataField="TPCUpdate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="TPCUpdate" SortExpression="TPCUpdate" />
                        <asp:BoundField DataField="OriginalInputDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="OriginalInputDate" SortExpression="OriginalInputDate" />
                        <asp:BoundField DataField="LeaPStatus" HeaderText="LeaPStatus" 
                            SortExpression="LeaPStatus" />
                        <asp:BoundField DataField="AuditDate" HeaderText="AuditDate" 
                            SortExpression="AuditDate" />
                        <asp:BoundField DataField="AuditUser" HeaderText="AuditUser" 
                            SortExpression="AuditUser" />
                        <asp:BoundField DataField="auditComment" HeaderText="auditComment" 
                            SortExpression="auditComment" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsSPCAudit" runat="server" DeleteMethod="Delete" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="ShipPlanComTableAdapters.LeaP_ShipPlanComAuditTableAdapter">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_spcAuditID" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="spcid" QueryStringField="SPCid" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

