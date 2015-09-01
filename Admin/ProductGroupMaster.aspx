<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="ProductGroupMaster.aspx.vb" Inherits="Admin_ProductGroupMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    &nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProdGroupID" DataSourceID="odsProdGroup" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="ProdGroupID" HeaderText="ProdGroupID" InsertVisible="False" ReadOnly="True" SortExpression="ProdGroupID" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="EmailGroup" HeaderText="EmailGroup" SortExpression="EmailGroup" />
        </Columns>
    </asp:GridView>
    <br />
    <br />
    <br />
    <br />
    <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="ProdGroupID" DataSourceID="odsProdGroup" EnableModelValidation="True" Height="50px" Width="125px">
        <Fields>
            <asp:BoundField DataField="ProdGroupID" HeaderText="ProdGroupID" InsertVisible="False" ReadOnly="True" SortExpression="ProdGroupID" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:BoundField DataField="EmailGroup" HeaderText="EmailGroup" SortExpression="EmailGroup" />
            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
        </Fields>
    </asp:DetailsView>
    <asp:ObjectDataSource ID="odsProdGroup" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="RoutingsTableAdapters.LeaP_ProdGroupTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_ProdGroupID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="EmailGroup" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="EmailGroup" Type="String" />
            <asp:Parameter Name="Original_ProdGroupID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

