<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SPCUpload.aspx.vb" MasterPageFile="~/LeaPBack.master" MaintainScrollPositionOnPostback ="true"
    Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register src="UserControls/MessageControl.ascx" tagname="MessageControl" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
            color: #33CC33;
        }
        .style4
        {
            width: 682px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager> 
    
        <table class="style1">
            <tr>
                <td>
                    <h4>
                        ShipPlanCom Upload</h4>
                </td>
                <td>
                    <h4>
                        &nbsp;</h4>
                </td>
                <td>
                   
                </td>
            </tr>
            <tr>
                <td>
                    <asp:FileUpload ID="FileUploadExcel" runat="server" />
                    <br />
                    <asp:Button ID="btnGetData" runat="server" Text="Get SPC Data" />
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnRoutings" runat="server" Text="GenerateRoutings" />
                </td>
            </tr>
            <tr>
                <td class="style3" colspan="3">
                    &nbsp;<asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:ObjectDataSource ID="odsSPC" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ShipPlanComTableAdapters.LeaP_ShipPlanComTableAdapter"
                        UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_spcID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Shipped" Type="Boolean" />
                            <asp:Parameter Name="Type" Type="String" />
                            <asp:Parameter Name="TPCOrderNo" Type="String" />
                            <asp:Parameter Name="TPCShippingInfo" Type="String" />
                            <asp:Parameter Name="TILFinalApprovalDate" Type="DateTime" />
                            <asp:Parameter Name="TILShippingMemoDate" Type="DateTime" />
                            <asp:Parameter Name="TILProposedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="TPCConfirmedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="TPCOrderQuantity" Type="Decimal" />
                            <asp:Parameter Name="Destination" Type="String" />
                            <asp:Parameter Name="TILUpdate" Type="DateTime" />
                            <asp:Parameter Name="TPCUpdate" Type="DateTime" />
                            <asp:Parameter Name="OriginalInputDate" Type="DateTime" />
                            <asp:Parameter Name="LeaPStatus" Type="Int32" />
                            <asp:Parameter Name="AuditChangeDate" Type="DateTime" />
                            <asp:Parameter Name="AuditUser" Type="Int32" />
                            <asp:Parameter Name="Original_spcID" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Shipped" Type="Boolean" />
                            <asp:Parameter Name="Type" Type="String" />
                            <asp:Parameter Name="TPCOrderNo" Type="String" />
                            <asp:Parameter Name="TPCShippingInfo" Type="String" />
                            <asp:Parameter Name="TILFinalApprovalDate" Type="DateTime" />
                            <asp:Parameter Name="TILShippingMemoDate" Type="DateTime" />
                            <asp:Parameter Name="TILProposedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="TPCConfirmedCollectionDate" Type="DateTime" />
                            <asp:Parameter Name="ItemCode" Type="String" />
                            <asp:Parameter Name="TPCOrderQuantity" Type="Decimal" />
                            <asp:Parameter Name="Destination" Type="String" />
                            <asp:Parameter Name="TILUpdate" Type="DateTime" />
                            <asp:Parameter Name="TPCUpdate" Type="DateTime" />
                            <asp:Parameter Name="OriginalInputDate" Type="DateTime" />
                            <asp:Parameter Name="LeaPStatus" Type="Int32" />
                            <asp:Parameter Name="AuditChangeDate" Type="DateTime" />
                            <asp:Parameter Name="AuditUser" Type="Int32" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:LinkButton ID="lnkInsert" runat="server">Insert new Line</asp:LinkButton>
                    <br />
                    <br />
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="spcID"
                        DataSourceID="odsSPC" AllowSorting="True" BackColor="White" BorderColor="#E7E7FF"
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:ButtonField CommandName="gvEdit" Text="Edit" />
                            <asp:CommandField ShowSelectButton="True" ShowDeleteButton="True" />
                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" SortExpression="TPCOrderNo" />
                            <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" SortExpression="ItemCode">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TPCOrderQuantity" HeaderText="TPCOrderQuantity" SortExpression="TPCOrderQuantity"
                                DataFormatString="{0:0}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TILFinalApprovalDate" HeaderText="TILFinalApprovalDate"
                                SortExpression="TILFinalApprovalDate" DataFormatString="{0:dd/MM/yyyy}">
                            </asp:BoundField>
                            <asp:BoundField DataField="TILShippingMemoDate" HeaderText="TILShippingMemoDate"
                                SortExpression="TILShippingMemoDate" DataFormatString="{0:dd/MM/yyyy}">
                            </asp:BoundField>
                            <asp:BoundField DataField="TPCConfirmedCollectionDate" HeaderText="TPCConfirmedCollectionDate"
                                SortExpression="TPCConfirmedCollectionDate" 
                                DataFormatString="{0:dd/MM/yyyy}" NullDisplayText="No Data">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AuditComment" HeaderText="AuditComment" 
                                SortExpression="AuditComment" />
                            <asp:BoundField DataField="spcID" HeaderText="spcID" InsertVisible="False" ReadOnly="True"
                                SortExpression="spcID" />
                            <asp:ButtonField CommandName="gvAudit" Text="Audit" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <cc1:ModalPopupExtender ID="mpeDetails" runat="server" PopupControlID="pnlDetails"
                        TargetControlID="lnkhidden">
                    </cc1:ModalPopupExtender>
                    <asp:LinkButton ID="lnkhidden" runat="server"></asp:LinkButton>
                    <asp:Panel ID="pnlDetails" runat="server" BackColor="#FFFFCC" Height="600px" Width="1250px"
                        BorderStyle="Double" BorderWidth="1px" ScrollBars="Vertical">
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate >
                                <table class="style1">
                                    <tr>
                                        <td class="style4">
                                            Edit lots for this Order or
                                            <asp:LinkButton ID="lnkInsertLot" runat="server">Insert New Lot</asp:LinkButton>
                                        </td>
                                        <td align="right">
                                            <asp:LinkButton ID="lnkClose" runat="server" BorderStyle="Solid" BorderWidth="1px">Close</asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style4">
                                            <asp:DetailsView ID="dvInsertLot" runat="server" AutoGenerateRows="False" 
                                                BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                                                CellPadding="3" DataKeyNames="spcBatchID" DataSourceID="odsLots" 
                                                DefaultMode="Insert" GridLines="Horizontal" Height="50px" Visible="False" 
                                                Width="125px">
                                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                                <Fields>
                                                    <asp:BoundField DataField="spcBatchID" HeaderText="spcBatchID" 
                                                        InsertVisible="False" ReadOnly="True" SortExpression="spcBatchID" />
                                                    <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                                                        SortExpression="BatchNumber" />
                                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                                        SortExpression="Quantity" />
                                                    <asp:BoundField DataField="BatchTrimmed" HeaderText="BatchTrimmed" 
                                                        SortExpression="BatchTrimmed" />
                                                    <asp:CommandField ShowInsertButton="True" />
                                                </Fields>
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:DetailsView>
                                            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                                                BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                                                CellPadding="3" DataKeyNames="spcBatchID" DataSourceID="odsLots" 
                                                GridLines="Horizontal">
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                <Columns>
                                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                                    <asp:BoundField DataField="spcBatchID" HeaderText="spcBatchID" 
                                                        InsertVisible="False" ReadOnly="True" SortExpression="spcBatchID" />
                                                    <asp:TemplateField HeaderText="spcID" SortExpression="spcID">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="TextBox1" runat="server" Enabled="False" 
                                                                Text='<%# Bind("spcID") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("spcID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                                                        SortExpression="BatchNumber" />
                                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                                        SortExpression="Quantity" />
                                                    <asp:BoundField DataField="BatchTrimmed" HeaderText="BatchTrimmed" 
                                                        SortExpression="BatchTrimmed" />
                                                </Columns>
                                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                        </td>
                                        <td align="right">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style4">
                                            <asp:ObjectDataSource ID="odsLots" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetDataBy" TypeName="ShipPlanComTableAdapters.LeaP_spcBatchesTableAdapter"
                                                UpdateMethod="Update" InsertMethod="Insert">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="Original_spcBatchID" Type="Int32" />
                                                </DeleteParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="BatchNumber" Type="String" />
                                                    <asp:Parameter Name="spcID" Type="Int32" />
                                                    <asp:Parameter Name="Quantity" Type="Decimal" />
                                                    <asp:Parameter Name="BatchTrimmed" Type="String" />
                                                    <asp:Parameter Name="HighestTransType" Type="Int32" />
                                                    <asp:Parameter Name="HighestTransTypeDate" Type="DateTime" />
                                                    <asp:Parameter Name="Original_spcBatchID" Type="Int32" />
                                                </UpdateParameters>
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="GridView1" Name="spcID" PropertyName="SelectedValue"
                                                        Type="Int32" />
                                                </SelectParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="BatchNumber" Type="String" />
                                                    <asp:Parameter Name="spcID" Type="Int32" />
                                                    <asp:Parameter Name="Quantity" Type="Decimal" />
                                                    <asp:Parameter Name="BatchTrimmed" Type="String" />
                                                    <asp:Parameter Name="HighestTransType" Type="Int32" />
                                                    <asp:Parameter Name="HighestTransTypeDate" Type="DateTime" />
                                                </InsertParameters>
                                            </asp:ObjectDataSource>
                                        </td>
                                        <td align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style4">
                                            Review Routing and Progress for Batches in this order
                                        </td>
                                        <td align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="2">
                                        <asp:UpdatePanel id = gv3update runat =server UpdateMode =Conditional >
                                        
                                        <ContentTemplate >
                                                     <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="odsPerformance"
                                                GridLines="Horizontal" DataKeyNames="BatchNumber,WorkCentreID">
                                                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                                <Columns>
                                                    <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" SortExpression="TPCOrderNo" />
                                                    <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" SortExpression="BatchNumber" />
                                                    <asp:BoundField DataField="StartDate" DataFormatString="{0:d}" HeaderText="StartDate"
                                                        SortExpression="StartDate" />
                                                    <asp:BoundField DataField="WorkCentreDesc" HeaderText="WorkCentreDesc" SortExpression="WorkCentreDesc" />
                                                    <asp:BoundField DataField="EndDate" DataFormatString="{0:d}" HeaderText="EndDate"
                                                        HtmlEncode="False" SortExpression="EndDate" />
                                                    <asp:BoundField DataField="TransDate" DataFormatString="{0:d}" HeaderText="TransDate"
                                                        HtmlEncode="False" SortExpression="TransDate" />
                                                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                                    <asp:BoundField DataField="WkCtrPerfComment" HeaderText="WkCtrPerfComment" 
                                                        SortExpression="WkCtrPerfComment" />
                                                    <asp:BoundField DataField="CommDate" DataFormatString="{0:dd/MM/yyyy}" 
                                                        HeaderText="CommDate" SortExpression="CommDate">
                                                        <ItemStyle Font-Size="X-Small" />
                                                    </asp:BoundField>
                                                    <asp:ButtonField CommandName="comment" Text="Comment">
                                                        <ItemStyle Font-Size="X-Small" ForeColor="Red" />
                                                    </asp:ButtonField>
                                                </Columns>
                                                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                                <AlternatingRowStyle BackColor="#F7F7F7" />
                                            </asp:GridView>
                                        
                                        </ContentTemplate>
                                        
                                        </asp:UpdatePanel>
                                        
                                        
                                        
                               
                                            <asp:ObjectDataSource ID="odsPerformance" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetDataBy" 
                                                TypeName="dsBatchTableAdapters.BatchRouteDetailsWithCommentsTableAdapter">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="GridView1" Name="spcid" PropertyName="SelectedValue"
                                                        Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                            <br />
                                        </td>
                                    </tr>
                                  </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <cc1:ModalPopupExtender ID="mpeInsertUpdateSPC" runat="server" PopupControlID="pnlInsertEditSPCline"
                        TargetControlID="lnkhidden">
                    </cc1:ModalPopupExtender>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Panel ID="pnlInsertEditSPCline" runat="server" BackColor="#FFFFCC" BorderStyle="Double"
                        BorderWidth="1px" Width="600px">
                        <table class="style1">
                            <tr>
                                <td>
                                    Insert or update Ship Plan Com line
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DetailsView ID="dvEditInsert" runat="server" AutoGenerateRows="False" BackColor="White"
                                        BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="spcID"
                                        DataSourceID="odsSPCDetails" DefaultMode="Edit" GridLines="Horizontal" Height="50px"
                                        Width="100%">
                                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                                        <Fields>
                                            <asp:BoundField DataField="spcID" HeaderText="spcID" InsertVisible="False" ReadOnly="True"
                                                SortExpression="spcID" />
                                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" SortExpression="TPCOrderNo" />
                                            <asp:TemplateField HeaderText="ItemCode" SortExpression="ItemCode">
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="odsItem" 
                                                        DataTextField="ItemCode" DataValueField="ItemCode" 
                                                        SelectedValue='<%# Bind("ItemCode") %>'>
                                                    </asp:DropDownList>
                                                    <asp:ObjectDataSource ID="odsItem" runat="server" DeleteMethod="Delete" 
                                                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                                        SelectMethod="GetData" 
                                                        TypeName="RoutingsTableAdapters.LeaP_ItemMasterTableAdapter" 
                                                        UpdateMethod="Update">
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="Original_ItemCode" Type="String" />
                                                        </DeleteParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                                                            <asp:Parameter Name="ItemDescription" Type="String" />
                                                            <asp:Parameter Name="Original_ItemCode" Type="String" />
                                                        </UpdateParameters>
                                                        <InsertParameters>
                                                            <asp:Parameter Name="ItemCode" Type="String" />
                                                            <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                                                            <asp:Parameter Name="ItemDescription" Type="String" />
                                                        </InsertParameters>
                                                    </asp:ObjectDataSource>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="odsItem" 
                                                        DataTextField="ItemCode" DataValueField="ItemCode" 
                                                        SelectedValue='<%# Bind("ItemCode") %>'>
                                                        <asp:ListItem></asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:ObjectDataSource ID="odsItem" runat="server" DeleteMethod="Delete" 
                                                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                                                        SelectMethod="GetData" 
                                                        TypeName="RoutingsTableAdapters.LeaP_ItemMasterTableAdapter" 
                                                        UpdateMethod="Update">
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="Original_ItemCode" Type="String" />
                                                        </DeleteParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                                                            <asp:Parameter Name="ItemDescription" Type="String" />
                                                            <asp:Parameter Name="Original_ItemCode" Type="String" />
                                                        </UpdateParameters>
                                                        <InsertParameters>
                                                            <asp:Parameter Name="ItemCode" Type="String" />
                                                            <asp:Parameter Name="RoutingHeaderID" Type="Int32" />
                                                            <asp:Parameter Name="ItemDescription" Type="String" />
                                                        </InsertParameters>
                                                    </asp:ObjectDataSource>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ItemCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TPCOrderQuantity" HeaderText="TPCOrderQuantity" 
                                                SortExpression="TPCOrderQuantity" />
                                            <asp:BoundField DataField="TILFinalApprovalDate" HeaderText="TILFinalApprovalDate" 
                                                SortExpression="TILFinalApprovalDate" DataFormatString="{0:dd/MM/yyyy}" 
                                                HtmlEncode="False" />
                                            <asp:BoundField DataField="TILShippingMemoDate" 
                                                HeaderText="TILShippingMemoDate" SortExpression="TILShippingMemoDate" 
                                                DataFormatString="{0:dd/MM/yyyy}" />
                                            <asp:BoundField DataField="TPCConfirmedCollectionDate" 
                                                HeaderText="TPCConfirmedCollectionDate" 
                                                SortExpression="TPCConfirmedCollectionDate" 
                                                DataFormatString="{0:dd/MM/yyyy}" />
                                            <asp:BoundField DataField="AuditComment" 
                                                HeaderText="AuditComment" 
                                                SortExpression="AuditComment" />
                                            <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
                                        </Fields>
                                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                                        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                                        <AlternatingRowStyle BackColor="#F7F7F7" />
                                    </asp:DetailsView>
                                    <asp:ObjectDataSource ID="odsSPCDetails" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
                                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy" TypeName="ShipPlanComTableAdapters.LeaP_ShipPlanComTableAdapter"
                                        UpdateMethod="Update">
                                        <DeleteParameters>
                                            <asp:Parameter Name="Original_spcID" Type="Int32" />
                                        </DeleteParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="Shipped" Type="Boolean" />
                                            <asp:Parameter Name="Type" Type="String" />
                                            <asp:Parameter Name="TPCOrderNo" Type="String" />
                                            <asp:Parameter Name="TPCShippingInfo" Type="String" />
                                            <asp:Parameter Name="TILFinalApprovalDate" Type="DateTime" />
                                            <asp:Parameter Name="TILShippingMemoDate" Type="DateTime" />
                                            <asp:Parameter Name="TILProposedCollectionDate" Type="DateTime" />
                                            <asp:Parameter Name="TPCConfirmedCollectionDate" Type="DateTime" />
                                            <asp:Parameter Name="ItemCode" Type="String" />
                                            <asp:Parameter Name="TPCOrderQuantity" Type="Decimal" />
                                            <asp:Parameter Name="Destination" Type="String" />
                                            <asp:Parameter Name="TILUpdate" Type="DateTime" />
                                            <asp:Parameter Name="TPCUpdate" Type="DateTime" />
                                            <asp:Parameter Name="OriginalInputDate" Type="DateTime" />
                                            <asp:Parameter Name="LeaPStatus" Type="Int32" />
                                            <asp:Parameter Name="AuditChangeDate" Type="DateTime" />
                                            <asp:Parameter Name="AuditUser" Type="Int32" />
                                            <asp:Parameter Name="AuditComment" Type="String" />
                                            <asp:Parameter Name="Original_spcID" Type="Int32" />
                                        </UpdateParameters>
                                        <SelectParameters>
                                            <asp:Parameter Name="spcid" Type="Int32" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="Shipped" Type="Boolean" />
                                            <asp:Parameter Name="Type" Type="String" />
                                            <asp:Parameter Name="TPCOrderNo" Type="String" />
                                            <asp:Parameter Name="TPCShippingInfo" Type="String" />
                                            <asp:Parameter Name="TILFinalApprovalDate" Type="DateTime" />
                                            <asp:Parameter Name="TILShippingMemoDate" Type="DateTime" />
                                            <asp:Parameter Name="TILProposedCollectionDate" Type="DateTime" />
                                            <asp:Parameter Name="TPCConfirmedCollectionDate" Type="DateTime" />
                                            <asp:Parameter Name="ItemCode" Type="String" />
                                            <asp:Parameter Name="TPCOrderQuantity" Type="Decimal" />
                                            <asp:Parameter Name="Destination" Type="String" />
                                            <asp:Parameter Name="TILUpdate" Type="DateTime" />
                                            <asp:Parameter Name="TPCUpdate" Type="DateTime" />
                                            <asp:Parameter Name="OriginalInputDate" Type="DateTime" />
                                            <asp:Parameter Name="LeaPStatus" Type="Int32" />
                                            <asp:Parameter Name="AuditChangeDate" Type="DateTime" />
                                            <asp:Parameter Name="AuditUser" Type="Int32" />
                                            <asp:Parameter Name="AuditComment" Type="String" />
                                        </InsertParameters>
                                    </asp:ObjectDataSource>
                                </td>
                            </tr>
                     
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
            <td colspan="3">
            </td>
            </tr>
            <tr>
            <td colspan="3">
                <uc1:MessageControl ID="MessageControl1" runat="server" />
            </td>
            </tr>
        </table>
    </div>
</asp:Content>
