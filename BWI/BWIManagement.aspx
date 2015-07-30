<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="BWIManagement.aspx.vb" Inherits="BWI_BWIManagement" %>

<%@ Register src="../UserControls/TrackWiseList.ascx" tagname="TrackWiseList" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: x-large;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
    <tr>
        <td>
            &nbsp;</td>
        <td colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td>
            Enter a PR Number:</td>
        <td>
            Select a BWI
            <asp:DropDownList ID="ddlBWISelection" runat="server" AutoPostBack="True" 
                DataSourceID="ldsBWIid" DataTextField="bwiID" DataValueField="bwiID">
            </asp:DropDownList>
            <asp:LinqDataSource ID="ldsBWIid" runat="server" 
                ContextTypeName="BWIDataContext" Select="new (bwiID)" 
                TableName="LeaP_BWIHeaders">
            </asp:LinqDataSource>
&nbsp;<span class="style4">or</span> enter a PR to start creating a new BWI
            <asp:TextBox ID="txtPRnumber" runat="server" Width="77px"></asp:TextBox>
            <asp:Button ID="btnShowPRLots" runat="server" Text="Show Lots" />
        </td>
        <td>
            <uc1:TrackWiseList ID="TrackWiseList1" runat="server" />
        </td>
    </tr>
    <tr>
        <td>
            BWI Number</td>
        <td colspan="2">
            <asp:Label ID="lblBWINumber" runat="server" Font-Bold="True" 
                ForeColor="#FF3300"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            Add lots to this BWI</td>
        <td>
            Enter Lots <asp:TextBox ID="txtLot" runat="server" Width="87px"></asp:TextBox>
&nbsp;Containers <asp:TextBox 
                ID="txtPartial" runat="server" Width="69px"></asp:TextBox>
            <asp:Button ID="btnAddLots" runat="server" Text="Add" />
        </td>
        <td>
            <asp:GridView ID="gvBWIlots" runat="server">
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td colspan="2">
            &nbsp;</td>
    </tr>
</table>
</asp:Content>

