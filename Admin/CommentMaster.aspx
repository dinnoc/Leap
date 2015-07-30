<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="CommentMaster.aspx.vb" Inherits="Admin_CommentMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td>
                <h3>
                    Auto Comment Master</h3>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" DataKeyNames="AutoCommentID" DataSourceID="odsAutoComment" 
                    DefaultMode="Insert" EnableModelValidation="True" GridLines="Horizontal" 
                    Height="50px" Width="500px">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <Fields>
                        <asp:BoundField DataField="AutoCommentID" HeaderText="AutoCommentID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="AutoCommentID" />
                        <asp:BoundField DataField="AutoCommentCategory" 
                            HeaderText="AutoCommentCategory" SortExpression="AutoCommentCategory" />
                        <asp:BoundField DataField="Comment" HeaderText="Comment" 
                            SortExpression="Comment" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                </asp:DetailsView>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    DataKeyNames="AutoCommentID" DataSourceID="odsAutoComment" 
                    EnableModelValidation="True" GridLines="Horizontal" Width="500px">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="AutoCommentID" HeaderText="AutoCommentID" 
                            InsertVisible="False" ReadOnly="True" SortExpression="AutoCommentID" />
                        <asp:BoundField DataField="AutoCommentCategory" 
                            HeaderText="AutoCommentCategory" SortExpression="AutoCommentCategory" />
                        <asp:BoundField DataField="Comment" HeaderText="Comment" 
                            SortExpression="Comment" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                </asp:GridView>
                <asp:ObjectDataSource ID="odsAutoComment" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetData" 
                    TypeName="ShipPlanComTableAdapters.LeaP_AutoCommentTableAdapter" 
                    UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_AutoCommentID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="AutoCommentCategory" Type="Int32" />
                        <asp:Parameter Name="Comment" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="AutoCommentCategory" Type="Int32" />
                        <asp:Parameter Name="Comment" Type="String" />
                        <asp:Parameter Name="Original_AutoCommentID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </td>
            <td align="left" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

