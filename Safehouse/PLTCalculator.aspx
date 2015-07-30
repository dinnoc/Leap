<%@ Page Title="" Language="VB" MasterPageFile="~/PLT.master" AutoEventWireup="false" CodeFile="PLTCalculator.aspx.vb" Inherits="PlantLeadTime_PLTCalculator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="2">
                1) Select Route to generate:
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="odsRoute" 
                    DataTextField="Description" DataValueField="PLTHeaderID">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsRoute" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="PLTInterfaceTableAdapters.PLT_RouteHeaderTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_PLTHeaderID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Description" Type="String" />
                        <asp:Parameter Name="Original_PLTHeaderID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Description" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                2)
                <asp:Button ID="Button1" runat="server" Text="Get the data" />
        
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="60%" rowspan="2">
                3) Wait for Data.&nbsp; Run time =<asp:Label ID="lblRunTime" runat="server" 
                    Text="N/A"></asp:Label>
&nbsp;seconds <%--<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="calcID" DataSourceID="odsCalculator">
                    <Columns>
                        <asp:BoundField DataField="FinishedBatchIDTrimmed" 
                            HeaderText="FinishedBatchIDTrimmed" SortExpression="FinishedBatchIDTrimmed" />
                        <asp:BoundField DataField="ItemCode" 
                            HeaderText="ItemCode" SortExpression="ItemCode" />
                        <asp:BoundField DataField="TransType" HeaderText="TransType" 
                            SortExpression="TransType" />
                        <asp:BoundField DataField="TransDate" HeaderText="TransDate" 
                            SortExpression="TransDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HtmlEncode="False" />
                        <asp:BoundField DataField="CalcLevel" HeaderText="CalcLevel" 
                            SortExpression="CalcLevel" />
                        <asp:BoundField DataField="Description" HeaderText="Description" 
                            SortExpression="Description" />
                        <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" 
                            SortExpression="BatchNo" />
                        <asp:BoundField DataField="calcID" HeaderText="calcID" InsertVisible="False" 
                            ReadOnly="True" SortExpression="calcID" />
                    </Columns>
                </asp:GridView>--%>
                </td>
            <td valign="top" height="20px">
                4)
                <asp:LinkButton ID="LinkButton1" runat="server">Export To Excel</asp:LinkButton>
                <br />
                <br />
            </td>
            <td rowspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <%--<asp:ObjectDataSource ID="odsCalculator" runat="server" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    
                    TypeName="PLTInterfaceTableAdapters.CalculationWithDescriptionTableAdapter">
                </asp:ObjectDataSource>--%>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

