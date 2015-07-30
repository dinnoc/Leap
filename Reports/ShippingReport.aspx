<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="ShippingReport.aspx.vb" Inherits="Reports_ShippingReport" MaintainScrollPositionOnPostback = "true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="5">
                SHIPPING REPORT</td>
        </tr>
        <tr>
            <td>
                Start Date</td>
            <td>
                <asp:TextBox ID="txtStart" runat="server"></asp:TextBox>
            </td>
            <td>
                End Date</td>
            <td>
                <asp:TextBox ID="txtEnd" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:GridView ID="gridview1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="batchnumber,SMSentCount,COASentCount,InvoiceSentCount" 
                    DataSourceID="odsShippingReport" EnableModelValidation="True" 
                    AllowSorting="True" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    GridLines="Horizontal">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <Columns>
                        <asp:BoundField DataField="TPCorderno" HeaderText="TPC_Order" 
                            SortExpression="TPCorderno" >
                        <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TILshippingmemodate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ship Memo Date" 
                            SortExpression="TILshippingmemodate" />
                        <asp:BoundField DataField="TPCConfirmedCollectionDate" 
                            DataFormatString="{0:dd/MM/yyyy}" HeaderText="Collection Date" 
                            SortExpression="TPCConfirmedCollectionDate" />
                        <asp:BoundField DataField="itemcode" HeaderText="Itemcode" 
                            SortExpression="itemcode" />
                        <asp:BoundField DataField="itemdescription" HeaderText="Description" 
                            SortExpression="itemdescription" />
                        <asp:BoundField DataField="description" HeaderText="Group" 
                            SortExpression="description" />
                        <asp:HyperLinkField DataNavigateUrlFields="BatchNumber" 
                            DataNavigateUrlFormatString="~/reports/batchview.aspx?Batchid={0}" 
                            DataTextField="batchnumber" DataTextFormatString="{0}" />
                        <asp:BoundField DataField="MandecQty" HeaderText="Mandec Qty" 
                            SortExpression="MandecQty" DataFormatString="{0:#}" />
                        <asp:BoundField DataField="ShipQty" HeaderText="Ship Qty" 
                            SortExpression="ShipQty" DataFormatString="{0:#}" />
                        <asp:BoundField DataField="shipDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Ship Date" SortExpression="shipDate" />
                        <asp:ButtonField CommandName="SMSent" Text="SM" HeaderText="SM Sent" />
                        <asp:ButtonField CommandName="COASent" Text="COA" HeaderText="COA Sent" />
                        <asp:ButtonField CommandName="Invoice" HeaderText="Invoice Recieved" 
                            Text="Invoice" />
                        <asp:BoundField DataField="BatchReviewComment" HeaderText="Review Comment" 
                            SortExpression="BatchReviewComment" />
                        <asp:BoundField DataField="ShipmentComment" HeaderText="Ship Comment" 
                            SortExpression="ShipmentComment" />
                        <asp:BoundField DataField="SMSentDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="SMSentDate" SortExpression="SMSentDate" />
                        <asp:BoundField DataField="COASentDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="COASentDate" SortExpression="COASentDate" />
                        <asp:BoundField DataField="InvoiceSentDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="InvoiceSentDate" SortExpression="InvoiceSentDate" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsShippingReport" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsBatchTableAdapters.ShippingReportTableAdapter">
                    <SelectParameters>
                 <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

