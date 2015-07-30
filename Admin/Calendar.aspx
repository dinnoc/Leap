<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="Calendar.aspx.vb" Inherits="Safehouse_Default" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate >
        <h4>
            Factory Calendar</h4>
    <p>Start Date:&nbsp;
        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
        </p>
    
 
        <p>
            End Date:&nbsp;&nbsp;
            <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
            <br />
            <asp:CheckBoxList ID="cblWeekDays" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="1">Mon</asp:ListItem>
                <asp:ListItem Value="2">Tues</asp:ListItem>
                <asp:ListItem Value="3">Weds</asp:ListItem>
                <asp:ListItem Value="4">Thurs</asp:ListItem>
                <asp:ListItem Value="5">Fri</asp:ListItem>
                <asp:ListItem Value="6">Sat</asp:ListItem>
                <asp:ListItem Value="7">Sun</asp:ListItem>
            </asp:CheckBoxList>
        </p>
        <p>
            <asp:Button ID="btnCreateCalendar" runat="server" Text="Create Calendar" />
        </p>
        <p>
            <asp:Calendar ID="calOff" runat="server"></asp:Calendar>
        </p>
        <p>
            <asp:Button ID="btnAddDate" runat="server" style="height: 29px" 
                Text="Add Date" />
        </p>
        <p>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="CalendarID" DataSourceID="odsCalendar">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="OffDate" DataFormatString="{0:d}" 
                        HeaderText="OffDate" HtmlEncode="False" SortExpression="OffDate" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="odsCalendar" runat="server" DeleteMethod="Delete" 
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetData" 
                TypeName="RoutingsTableAdapters.LeaP_CalendarTableAdapter" 
                UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_CalendarID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="WorkCentre" Type="Int32" />
                    <asp:Parameter Name="OffDate" Type="DateTime" />
                    <asp:Parameter Name="Original_CalendarID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="WorkCentre" Type="Int32" />
                    <asp:Parameter Name="OffDate" Type="DateTime" />
                </InsertParameters>
            </asp:ObjectDataSource>
        </p>
    
       </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

