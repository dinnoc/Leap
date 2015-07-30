<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="RoutingMaster.aspx.vb" Inherits="RoutingMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table class="style1">
        <tr>
            <td>
                <h4>
                    Routing Master</h4>
            </td>
            <td valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                Select a routing to edit:<br />
                <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" 
                    DataSourceID="odsRouteHeader" DataTextField="RoutingDescription" 
                    DataValueField="RoutingHeaderID">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsRouteHeader" runat="server" DeleteMethod="Delete" 
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
                <br />
                All routings automatically include shipment as the last workcentre.&nbsp; Do not 
                add it to the routing below or it will show up twice in reporting.&nbsp; </td>
            <td valign="top">
                Add a new routing:<asp:DetailsView ID="DetailsView3" runat="server" 
                    AutoGenerateRows="False" DataKeyNames="RoutingHeaderID" 
                    DataSourceID="odsRouteHeader" DefaultMode="Insert" Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="RoutingHeaderID" HeaderText="RoutingHeaderID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="RoutingHeaderID" />
                        <asp:BoundField DataField="RoutingDescription" HeaderText="RoutingDescription" 
                            SortExpression="RoutingDescription" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataKeyNames="RoutingLineID" 
                    DataSourceID="odsRouteLInes">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="RoutingLineID" HeaderText="RoutingLineID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="RoutingLineID" />
                        <asp:TemplateField HeaderText="WorkCentreID" SortExpression="WorkCentreID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList5" runat="server" 
                                    DataSourceID="odsWorkCentre" DataTextField="WorkCentreDesc" 
                                    DataValueField="WorkCentreID" SelectedValue='<%# Bind("WorkCentreID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsWorkCentre" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList5" runat="server" 
                                    DataSourceID="odsWorkCentre" DataTextField="WorkCentreDesc" 
                                    DataValueField="WorkCentreID" SelectedValue='<%# Bind("WorkCentreID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsWorkCentre" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TotalDuration" HeaderText="Total Duration (working days)" 
                            SortExpression="TotalDuration" />
                        <asp:BoundField DataField="ProcessDuration" HeaderText="Process Duration (hrs)" 
                            SortExpression="ProcessDuration" />
                        <asp:BoundField DataField="Sequence" HeaderText="Sequence" 
                            SortExpression="Sequence" />
                        <asp:BoundField DataField="RoutingHeaderID" HeaderText="RoutingHeaderID" 
                            SortExpression="RoutingHeaderID" />
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="odsRouteLInes" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetDataBy" 
                    TypeName="RoutingsTableAdapters.LeaP_RoutingLineTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_RoutingLineID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="WorkCentreID" Type="Int32" />
                        <asp:Parameter Name="TotalDuration" Type="Int32" />
                        <asp:Parameter Name="ProcessDuration" Type="Int32" />
                        <asp:Parameter Name="Sequence" Type="Int32" />
                        <asp:Parameter Name="Original_RoutingLineID" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList3" Name="RoutingHeaderID" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                        <asp:Parameter Name="WorkCentreID" Type="Int32" />
                        <asp:Parameter Name="TotalDuration" Type="Int32" />
                        <asp:Parameter Name="ProcessDuration" Type="Int32" />
                        <asp:Parameter Name="Sequence" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                Add a new line<br />
                <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" 
                    DataKeyNames="RoutingLineID" DataSourceID="odsRouteLInes" DefaultMode="Insert" 
                    Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="RoutingLineID" HeaderText="RoutingLineID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="RoutingLineID" />
                        <asp:TemplateField HeaderText="WorkCentreID" SortExpression="WorkCentreID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList5" runat="server" 
                                    DataSourceID="odsWorkCentre" DataTextField="WorkCentreDesc" 
                                    DataValueField="WorkCentreID" SelectedValue='<%# Bind("WorkCentreID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsWorkCentre" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DropDownList5" runat="server" 
                                    DataSourceID="odsWorkCentre" DataTextField="WorkCentreDesc" 
                                    DataValueField="WorkCentreID" SelectedValue='<%# Bind("WorkCentreID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsWorkCentre" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList5" runat="server" 
                                    DataSourceID="odsWorkCentre" DataTextField="WorkCentreDesc" 
                                    DataValueField="WorkCentreID" SelectedValue='<%# Bind("WorkCentreID") %>'>
                                </asp:DropDownList>
                                <asp:ObjectDataSource ID="odsWorkCentre" runat="server" DeleteMethod="Delete" 
                                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                    SelectMethod="GetData" 
                                    TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                                    UpdateMethod="Update">
                                    <DeleteParameters>
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                        <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="WorkCentreDesc" Type="String" />
                                        <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                                    </InsertParameters>
                                </asp:ObjectDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="TotalDuration" HeaderText="TotalDuration" 
                            SortExpression="TotalDuration" />
                        <asp:BoundField DataField="ProcessDuration" HeaderText="ProcessDuration" 
                            SortExpression="ProcessDuration" />
                        <asp:BoundField DataField="Sequence" HeaderText="Sequence" 
                            SortExpression="Sequence" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
                <br />
            </td>
        </tr>
    </table>
</asp:Content>

