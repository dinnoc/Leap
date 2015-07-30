<%@ Page Title="" Language="VB" MasterPageFile="~/leapback.master" AutoEventWireup="false" CodeFile="TestHarness.aspx.vb" Inherits="UserControls_TestHarness" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<%@ Register src="MessageControl.ascx" tagname="MessageControl" tagprefix="uc1" %>


<%@ Register src="MessageHistory.ascx" tagname="MessageHistory" tagprefix="uc2" %>


<%@ Register src="TrackWiseList.ascx" tagname="TrackWiseList" tagprefix="uc3" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </cc1:ToolkitScriptManager>
    
    <uc3:TrackWiseList ID="TrackWiseList1" runat="server" />
    
    <br />
    <br />
    <br />
    <br />
   
    
    <asp:Button ID="Button1" runat="server" Text="Button" />
    
    
</asp:Content>

