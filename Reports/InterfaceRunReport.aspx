<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="InterfaceRunReport.aspx.vb" Inherits="Reports_InterfaceRunReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
    <tr>
        <td colspan="2">
            <h4>
                Interface Run Report</h4>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            Use this report to tell you how up to date the data is in leap</td>
    </tr>
    <tr>
        <td valign="top" width="50%">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="odsInterface" BackColor="White" BorderColor="#E7E7FF" 
                BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" 
                Width="100%">
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:BoundField DataField="Description" HeaderText="Description" 
                        SortExpression="Description" />
                    <asp:BoundField DataField="LastWrite" HeaderText="LastWrite" ReadOnly="True" 
                        SortExpression="LastWrite" />
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <asp:ObjectDataSource ID="odsInterface" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                TypeName="InterfaceScraperTableAdapters.LastInterfaceRunTableAdapter">
            </asp:ObjectDataSource>
        </td>
        <td style="text-align: left" valign="top">
            Notes:<br />
            <br />
            -At month end the SAP interface may not run for up to 4 days after the 1st of 
            the month due to accounts closing the month.&nbsp; In this case the data for 
            receipts, dispensings, mandecs, batch approval and shipments will not be fully 
            up to date.&nbsp; The data for batch status and QC approval will be up to up to 
            date during this period as they are taken direct from the Lims and XFP 
            databases.<br />
            <br />
            - Lims interface write date is the latest date which a batch was approved or 
            rejected in Lims which has been processed into the leap transaction table<br />
            <br />
            - XFP status interface is the date which the xfp lots table was copied between 
            the XFP system and the LeaP system.</td>
    </tr>
</table>
</asp:Content>

