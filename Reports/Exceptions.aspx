<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="Exceptions.aspx.vb" Inherits="Reports_Exceptions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        EnableModelValidation="True">
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsBatchTableAdapters.Leap_ExclusionsTableAdapter">
    </asp:ObjectDataSource>



</asp:Content>

