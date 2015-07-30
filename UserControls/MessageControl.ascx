<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MessageControl.ascx.vb" Inherits="UserControls_MessageControl" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>




<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate >

<cc1:ModalPopupExtender ID="MPEMessage" runat="server" TargetControlID = "lnkHidden"  PopupControlID = "pnlMessage">
</cc1:ModalPopupExtender>

<asp:LinkButton ID="lnkHidden" runat="server"></asp:LinkButton>

<asp:Panel ID="pnlMessage" runat="server" Width="600px" BackColor="#FFFF99" 
    HorizontalAlign="Center" BorderStyle="Double">
    <table  width="95%">
        <tr>
            <td colspan="3" style="text-align: left">
                LeaP Message</td>
            <td style="text-align: right">
                <asp:Label ID="lbluser" runat="server" style="font-size: x-small" Text="Label"></asp:Label>
                &nbsp;
                <asp:LinkButton ID="LinkButton1" runat="server" BorderStyle="Solid" 
                    BorderWidth="1px" style="text-align: right">Close</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="text-align: left">
                Batch</td>
            <td style="text-align: left">
                &nbsp;</td>
            <td colspan="2">
                <asp:TextBox ID="txtBatchNumbers" runat="server" Font-Size="XX-Small" 
                    Height="59px" TextMode="MultiLine" Width="100%"></asp:TextBox>
             <asp:LinkButton ID="lnkRemove" runat="server" Font-Size="XX-Small">Remove Last</asp:LinkButton>
        
                <asp:CheckBox ID="cbAllBulk" runat="server" Font-Size="X-Small" 
                    Text="Update all bulk" />
        
            </td>
        </tr>
        <tr>
            <td style="text-align: left">
                WorkCentre</td>
            <td style="text-align: left">
                <asp:DropDownList ID="ddlWkCtr" runat="server" DataSourceID="odsWkCtr" 
                    DataTextField="WorkCentreDesc" DataValueField="WorkCentreID">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsWkCtr" runat="server" DeleteMethod="Delete" 
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
            </td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="text-align: left">
                <asp:CheckBox ID="cbUrgent" runat="server" Text="Urgent" />
            </td>
            <td style="text-align: left">
                <asp:CheckBox ID="cbFIO" runat="server" Text="FIO (do not report)" />
            </td>
            <td >
                <asp:CheckBox ID="cbInterimApproval" runat="server" 
                    Text="Lot(s) for interim Approval" />
            </td>
                <td >
                <asp:CheckBox ID="cbException" Enabled = "false" runat="server" 
                    Text="Exception" />
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: left">
                <asp:DropDownList ID="ddlAutoComment" runat="server" 
                    DataSourceID="odsAutoComment" DataTextField="Comment" DataValueField="Comment" 
                    Width="100%">
                </asp:DropDownList>
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
            <td>
                <asp:Button ID="btnAutoComm" runat="server" Text="Add Comment" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" 
                    Height="124px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Button ID="btnSend" runat="server" Text="Send" />
                <asp:Label ID="lblMessage" runat="server" style="color: #FF0000"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>

</ContentTemplate>

</asp:UpdatePanel>


