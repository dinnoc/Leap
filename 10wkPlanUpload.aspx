<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="10wkPlanUpload.aspx.vb" Inherits="_10wkPlanUpload"  MaintainScrollPositionOnPostback = "true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td>
                Upload 10 week plan</td>
        </tr>
        <tr>
            <td>
                    <asp:FileUpload ID="FileUpload10wkData" runat="server" />
                    <br />
                    <asp:Button ID="btnGet10wkData" runat="server" Text="Get 10wk Plan data" />
                </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                <br />
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    DataKeyNames="int10wkPlanID" DataSourceID="odsInsert" DefaultMode="Insert" 
                    EnableModelValidation="True" Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="int10wkPlanID" HeaderText="int10wkPlanID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="int10wkPlanID" />
                        <asp:BoundField DataField="WkCtr" HeaderText="WkCtr" SortExpression="WkCtr" />
                        <asp:BoundField DataField="SubWkCtr" HeaderText="SubWkCtr" 
                            SortExpression="SubWkCtr" />
                        <asp:BoundField DataField="BulkItem" HeaderText="BulkItem" 
                            SortExpression="BulkItem" />
                        <asp:BoundField DataField="LotNumber" HeaderText="LotNumber" 
                            SortExpression="LotNumber" />
                        <asp:BoundField DataField="MPSDate" HeaderText="MPSDate (mm/dd/yyyy)" 
                            SortExpression="MPSDate" />
                        <asp:BoundField DataField="UploadDate" HeaderText="UploadDate (mm/dd/yyyy)" 
                            SortExpression="UploadDate" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
                <asp:ObjectDataSource ID="odsInsert" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="ShipPlanComTableAdapters.LeaP_10wkPlanTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_int10wkPlanID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="WkCtr" Type="Int32" />
                        <asp:Parameter Name="SubWkCtr" Type="String" />
                        <asp:Parameter Name="BulkItem" Type="String" />
                        <asp:Parameter Name="LotNumber" Type="String" />
                        <asp:Parameter Name="MPSDate" Type="DateTime" />
                        <asp:Parameter Name="UploadDate" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="WkCtr" Type="Int32" />
                        <asp:Parameter Name="SubWkCtr" Type="String" />
                        <asp:Parameter Name="BulkItem" Type="String" />
                        <asp:Parameter Name="LotNumber" Type="String" />
                        <asp:Parameter Name="MPSDate" Type="DateTime" />
                        <asp:Parameter Name="UploadDate" Type="DateTime" />
                        <asp:Parameter Name="Original_int10wkPlanID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataKeyNames="int10wkPlanID" DataSourceID="ods10wk" 
                    EnableModelValidation="True" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" 
                    Width="75%">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="int10wkPlanID" HeaderText="int10wkPlanID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="int10wkPlanID" />
                        <asp:BoundField DataField="WkCtr" HeaderText="WkCtr" SortExpression="WkCtr" />
                        <asp:BoundField DataField="SubWkCtr" HeaderText="SubWkCtr" 
                            SortExpression="SubWkCtr" />
                        <asp:BoundField DataField="BulkItem" HeaderText="BulkItem" 
                            SortExpression="BulkItem" />
                        <asp:BoundField DataField="LotNumber" HeaderText="LotNumber" 
                            SortExpression="LotNumber" />
                        <asp:BoundField DataField="MPSDate" HeaderText="MPSDate" 
                            SortExpression="MPSDate" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="UploadDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="UploadDate" SortExpression="UploadDate" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="ods10wk" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="ShipPlanComTableAdapters.LeaP_10wkPlanTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_int10wkPlanID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="WkCtr" Type="Int32" />
                        <asp:Parameter Name="SubWkCtr" Type="String" />
                        <asp:Parameter Name="BulkItem" Type="String" />
                        <asp:Parameter Name="LotNumber" Type="String" />
                        <asp:Parameter Name="MPSDate" Type="DateTime" />
                        <asp:Parameter Name="UploadDate" Type="DateTime" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="WkCtr" Type="Int32" />
                        <asp:Parameter Name="SubWkCtr" Type="String" />
                        <asp:Parameter Name="BulkItem" Type="String" />
                        <asp:Parameter Name="LotNumber" Type="String" />
                        <asp:Parameter Name="MPSDate" Type="DateTime" />
                        <asp:Parameter Name="UploadDate" Type="DateTime" />
                        <asp:Parameter Name="Original_int10wkPlanID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

