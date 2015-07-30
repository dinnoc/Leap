<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="Copy of MPSShedulePerformance.aspx.vb" Inherits="Reports_MPSShedulePerformance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style4
        {
            width: 89px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="7">
                <h3>
                    MPS Workcentre Performance</h3>
            </td>
        </tr>
        <tr>
            <td>
                Work Centre</td>
            <td>
                <asp:DropDownList ID="ddlwkCtr" runat="server" DataSourceID="odsWkCtr" 
                    DataTextField="WorkCentreDesc" DataValueField="WorkCentreID">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsWkCtr" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </td>
            <td>
                Start Date</td>
            <td>
                <asp:TextBox ID="txtStart" runat="server"></asp:TextBox>
            </td>
            <td class="style4">
                End Date</td>
            <td>
                <asp:TextBox ID="txtEnd" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
            </td>
        </tr>
        <tr>
            <td>
                Total Batches<br />
                Batches on or before target<br />
                Performance</td>
            <td>
                <asp:Label ID="lblTotalBatches" runat="server"></asp:Label>
                <br />
                <asp:Label ID="lblGoodBatches" runat="server"></asp:Label>
                <br />
                <asp:Label ID="lblPerformance" runat="server"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td class="style4">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="7">
                <asp:GridView ID="gvMPSPerformance" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataSourceID="odsMPSPerformance" 
                    EnableModelValidation="True" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <Columns>
                        <asp:BoundField DataField="subwkctr" HeaderText="subwkctr" 
                            SortExpression="subwkctr" />
                        <asp:BoundField DataField="bulkitem" HeaderText="bulkitem" 
                            SortExpression="bulkitem" />
                        <asp:BoundField DataField="lotnumber" HeaderText="lotnumber" 
                            SortExpression="lotnumber" />
                        <asp:BoundField DataField="MPSTarget" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="MPSTarget" SortExpression="MPSTarget" />
                        <asp:BoundField DataField="LeapActual" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="LeapActual" SortExpression="LeapActual" />
                        <asp:TemplateField HeaderText="MPSminusActual"></asp:TemplateField>
                        <asp:BoundField DataField="SPCTarget" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="SPCTarget" SortExpression="SPCTarget" />
                        <asp:HyperLinkField DataNavigateUrlFields="BatchNumber" 
                            DataNavigateUrlFormatString="~/reports/batchview.aspx?BatchID={0}" 
                            DataTextField="batchnumber" DataTextFormatString="{0}" 
                            HeaderText="Finished Batch" />
                        <asp:BoundField DataField="wkctrperfcomment" HeaderText="wkctrperfcomment" 
                            SortExpression="wkctrperfcomment" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsMPSPerformance" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsBatchTableAdapters.MPSPerformanceTableAdapter">
                    <SelectParameters>
                        <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                        <asp:Parameter Name="wkctr" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

