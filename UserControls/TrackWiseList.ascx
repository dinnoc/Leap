<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TrackWiseList.ascx.vb" Inherits="UserControls_TrackWiseList" %>
<asp:GridView ID="GridView1" runat="server" BackColor="White" 
    BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
    GridLines="Horizontal">
    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
    <EmptyDataTemplate>
        There is no trackwise data to display
    </EmptyDataTemplate>
    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
    <AlternatingRowStyle BackColor="#F7F7F7" />
</asp:GridView>
