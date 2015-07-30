<%@ Page Title="" Language="VB" MaintainScrollPositionOnPostback =TRUE MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="ItemMaster.aspx.vb" Inherits="ItemMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td>
                <h4>Item Master</h4></td>
            <td width="50%">
                </td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="odsItem" DataTextField="ItemCode" DataValueField="ItemCode">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsItem" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="RoutingsTableAdapters.LeaP_ItemMasterTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ItemCode" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="Original_ItemCode" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ItemCode" Type="String" />
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
            <td>
                Routing</td>
        </tr>
        <tr>
            <td>
                Item Data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:LinkButton ID="lnkAddItem" runat="server">Add new Item</asp:LinkButton>
            </td>
            <td>
                Item Routing<br />
                All routings automatically include shipment, 
                workcentrecompletetransaction 80.</td>
        </tr>
        <tr>
            <td valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    DataKeyNames="ItemCode" DataSourceID="odsItemDetails" DefaultMode="Edit" 
                    Height="50px" Width="125px" EnableModelValidation="True">
                    <Fields>
                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" ReadOnly="True" 
                            SortExpression="ItemCode" />
                        <asp:TemplateField HeaderText="RoutingHeaderID" 
                            SortExpression="RoutingHeaderID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="odsRoute" 
                                    DataTextField="RoutingDescription" DataValueField="RoutingHeaderID" 
                                    SelectedValue='<%# Bind("RoutingHeaderID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsRoute" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_RoutingHeaderTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_RoutingHeaderID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="RoutingDescription" Type="String" />
                                        <asp:Parameter Name="Original_RoutingHeaderID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="RoutingDescription" Type="String" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("RoutingHeaderID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                            SortExpression="ItemDescription" />
                        <asp:BoundField DataField="Multiplier1" HeaderText="Multiplier1" 
                            SortExpression="Multiplier1" />
                        <asp:BoundField DataField="Multiplier2" HeaderText="Multiplier2" 
                            SortExpression="Multiplier2" />
                        <asp:BoundField DataField="Divisor1" HeaderText="Divisor1" 
                            SortExpression="Divisor1" />
                        <asp:BoundField DataField="Divisor2" HeaderText="Divisor2" 
                            SortExpression="Divisor2" />
                        <asp:BoundField DataField="BlisterLine" HeaderText="BlisterLine" 
                            SortExpression="BlisterLine" />
                        <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                <asp:ObjectDataSource ID="odsItemDetails" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetDataBy" 
                    TypeName="RoutingsTableAdapters.LeaP_ItemMasterTableAdapter" 
                    InsertMethod="Insert" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ItemCode" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ItemCode" Type="String" />
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="ItemDescription" Type="String" />
                        <asp:Parameter Name="Multiplier1" Type="Decimal" />
                        <asp:Parameter Name="Multiplier2" Type="Decimal" />
                        <asp:Parameter Name="Divisor1" Type="Decimal" />
                        <asp:Parameter Name="Divisor2" Type="Decimal" />
                        <asp:Parameter Name="BlisterLine" Type="String" />
                        <asp:Parameter Name="ProdGroup" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="itemcode" 
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="ItemDescription" Type="String" />
                        <asp:Parameter Name="Multiplier1" Type="Decimal" />
                        <asp:Parameter Name="Multiplier2" Type="Decimal" />
                        <asp:Parameter Name="Divisor1" Type="Decimal" />
                        <asp:Parameter Name="Divisor2" Type="Decimal" />
                        <asp:Parameter Name="BlisterLine" Type="String" />
                        <asp:Parameter Name="ProdGroup" Type="Int32" />
                        <asp:Parameter Name="Original_ItemCode" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </td>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="odsRouting">
                    <Columns>
                        <asp:BoundField DataField="WorkCentreDesc" HeaderText="WorkCentreDesc" 
                            SortExpression="WorkCentreDesc" />
                        <asp:BoundField DataField="TotalDuration" HeaderText="TotalDuration" 
                            SortExpression="TotalDuration" />
                        <asp:BoundField DataField="Sequence" HeaderText="Sequence" 
                            SortExpression="Sequence" />
                        <asp:BoundField DataField="Description" HeaderText="Description" 
                            SortExpression="Description" />
                        <asp:BoundField DataField="WorkCentreCompleteTransaction" 
                            HeaderText="WorkCentreCompleteTransaction" 
                            SortExpression="WorkCentreCompleteTransaction" />
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="odsRouting" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="RoutingsTableAdapters.RouteDisplayDetailsTableAdapter">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="itemcode" 
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataKeyNames="ItemCode" 
                    DataSourceID="odsItemRouting" Width="75%" EnableModelValidation="True">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" ReadOnly="True" 
                            SortExpression="ItemCode" />
                        <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                            SortExpression="ItemDescription" />
                        <asp:TemplateField HeaderText="RoutingHeaderID" 
                            SortExpression="RoutingHeaderID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="odsRouting" 
                                    DataTextField="RoutingDescription" DataValueField="RoutingHeaderID" 
                                    SelectedValue='<%# Bind("RoutingHeaderID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsRouting" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_RoutingHeaderTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_RoutingHeaderID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="RoutingDescription" Type="String" />
                                        <asp:Parameter Name="Original_RoutingHeaderID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="RoutingDescription" Type="String" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="odsRouting" 
                                    DataTextField="RoutingDescription" DataValueField="RoutingHeaderID" 
                                    Enabled="False" SelectedValue='<%# Bind("RoutingHeaderID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsRouting" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_RoutingHeaderTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_RoutingHeaderID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="RoutingDescription" Type="String" />
                                        <asp:Parameter Name="Original_RoutingHeaderID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="RoutingDescription" Type="String" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Multiplier1" HeaderText="Blisters Per Carton" 
                            SortExpression="Multiplier1" />
                        <asp:BoundField DataField="Multiplier2" HeaderText="OEE" 
                            SortExpression="Multiplier2" />
                        <asp:BoundField DataField="Divisor1" HeaderText="Rate" 
                            SortExpression="Divisor1" />
                        <asp:BoundField DataField="Divisor2" HeaderText="Unused" 
                            SortExpression="Divisor2" />
                        <asp:BoundField DataField="BlisterLine" HeaderText="BlisterLine" 
                            SortExpression="BlisterLine" />
                        <asp:TemplateField HeaderText="ProdGroup" SortExpression="ProdGroup">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="odsProdGroup" 
                                    DataTextField="Description" DataValueField="ProdGroupId" 
                                    SelectedValue='<%# Bind("ProdGroup") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsProdGroup" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_ProdGroupTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_ProdGroupId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="ProdGroupId" Type="Int32" />
                                        <asp:Parameter Name="Description" Type="String" />
                                        <asp:Parameter Name="EmailGroup" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Description" Type="String" />
                                        <asp:Parameter Name="EmailGroup" Type="String" />
                                        <asp:Parameter Name="Original_ProdGroupId" Type="Int32" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="odsProdGroup" 
                                    DataTextField="Description" DataValueField="ProdGroupId" Enabled="False" 
                                    SelectedValue='<%# Bind("ProdGroup") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsProdGroup" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_ProdGroupTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_ProdGroupId" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="ProdGroupId" Type="Int32" />
                                        <asp:Parameter Name="Description" Type="String" />
                                        <asp:Parameter Name="EmailGroup" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Description" Type="String" />
                                        <asp:Parameter Name="EmailGroup" Type="String" />
                                        <asp:Parameter Name="Original_ProdGroupId" Type="Int32" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="odsItemRouting" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="RoutingsTableAdapters.LeaP_ItemMasterTableAdapter" 
                    DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ItemCode" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ItemCode" Type="String" />
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="ItemDescription" Type="String" />
                        <asp:Parameter Name="Multiplier1" Type="Decimal" />
                        <asp:Parameter Name="Multiplier2" Type="Decimal" />
                        <asp:Parameter Name="Divisor1" Type="Decimal" />
                        <asp:Parameter Name="Divisor2" Type="Decimal" />
                        <asp:Parameter Name="BlisterLine" Type="String" />
                        <asp:Parameter Name="ProdGroup" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="ItemDescription" Type="String" />
                        <asp:Parameter Name="Multiplier1" Type="Decimal" />
                        <asp:Parameter Name="Multiplier2" Type="Decimal" />
                        <asp:Parameter Name="Divisor1" Type="Decimal" />
                        <asp:Parameter Name="Divisor2" Type="Decimal" />
                        <asp:Parameter Name="BlisterLine" Type="String" />
                        <asp:Parameter Name="ProdGroup" Type="Int32" />
                        <asp:Parameter Name="Original_ItemCode" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                Product Group Edit</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView3" runat="server">
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>

