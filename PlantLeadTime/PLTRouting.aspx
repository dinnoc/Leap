<%@ Page Title="" Language="VB" MasterPageFile="~/PLT.master" AutoEventWireup="false" CodeFile="PLTRouting.aspx.vb" Inherits="PlantLeadTime_PLTRouting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="odsRouteHeader" DataTextField="Description" 
                    DataValueField="PLTHeaderID">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsRouteHeader" runat="server" DeleteMethod="Delete" 
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
                Add a new routing
                <br />
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    DataKeyNames="PLTHeaderID" DataSourceID="odsRouteHeader" DefaultMode="Insert" 
                    Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="PLTHeaderID" HeaderText="PLTHeaderID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="PLTHeaderID" />
                        <asp:BoundField DataField="Description" HeaderText="Description" 
                            SortExpression="Description" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataKeyNames="RoutingID" DataSourceID="odsRoute">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="RoutingID" HeaderText="RoutingID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="RoutingID" />
                        <asp:TemplateField HeaderText="RouteHeader" SortExpression="RouteHeader">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Enabled="False" 
                                    Text='<%# Bind("RouteHeader") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("RouteHeader") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Itemcode" HeaderText="Itemcode" 
                            SortExpression="Itemcode" />
                        <asp:BoundField DataField="routeLevel" HeaderText="routeLevel" 
                            SortExpression="routeLevel" />
                        <asp:BoundField DataField="NextItemDesignation" 
                            HeaderText="NextItemDesignation" SortExpression="NextItemDesignation" />
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="odsRoute" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="PLTInterfaceTableAdapters.PLT_RoutingsTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_RoutingID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RouteHeader" Type="Int32" />
                        <asp:Parameter Name="Itemcode" Type="String" />
                        <asp:Parameter Name="routeLevel" Type="Int32" />
                        <asp:Parameter Name="NextItemDesignation" Type="Int32" />
                        <asp:Parameter Name="Original_RoutingID" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="routeheader" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="RouteHeader" Type="Int32" />
                        <asp:Parameter Name="Itemcode" Type="String" />
                        <asp:Parameter Name="routeLevel" Type="Int32" />
                        <asp:Parameter Name="NextItemDesignation" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <br />
            </td>
            <td rowspan="2">
                Notes:<br />
                Next item Designation is the type of material that is the next item in the level 
                sequence
                <br />
                1 = Intermediate<br />
                2 = Raw Material<br />
                3 = No next item (ie: at the raw material stage)<br />
                <br />
                <br />
                If you&nbsp; have more than one item at the same level they must have a route 
                level designation.<asp:DetailsView ID="DetailsView2" runat="server" 
                    AutoGenerateRows="False" DataKeyNames="RoutingID" DataSourceID="odsRoute" 
                    DefaultMode="Insert" Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="RoutingID" HeaderText="RoutingID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="RoutingID" />
                        <asp:BoundField DataField="Itemcode" HeaderText="Itemcode" 
                            SortExpression="Itemcode" />
                        <asp:BoundField DataField="routeLevel" HeaderText="routeLevel" 
                            SortExpression="routeLevel" />
                        <asp:BoundField DataField="NextItemDesignation" 
                            HeaderText="NextItemDesignation" SortExpression="NextItemDesignation" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

