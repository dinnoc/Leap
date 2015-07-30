<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BatchWorkCentreStatusPackAndBulk.aspx.vb" MasterPageFile ="~/LeaPBack.master"  Inherits="BatchWorkCentreStatus" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div>
    
        <table class="style1">
            <tr>
                <td>
                    <asp:CheckBox ID="cbShipped" runat="server" AutoPostBack="True" 
                        Text="Show Shipped Lots" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ScriptManager ID="ScriptManager2" runat="server">
                    </asp:ScriptManager>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" DataKeyNames="spcID" 
                        DataSourceID="odsBatchWorkCentre" BackColor="White" BorderColor="#DEDFDE" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" 
                        GridLines="Vertical">
                        <RowStyle BackColor="#F7F7DE" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                                SortExpression="TPCOrderNo" />
                            <asp:BoundField DataField="TPCOrderQuantity" HeaderText="TPCOrderQuantity" 
                                SortExpression="TPCOrderQuantity" />
                            <asp:BoundField DataField="TPCConfirmedCollectionDate" 
                                HeaderText="TPCConfirmedCollectionDate" 
                                SortExpression="TPCConfirmedCollectionDate" DataFormatString="{0:d}" 
                                HtmlEncode="False" >
                            </asp:BoundField>
                            <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                                SortExpression="ItemCode" />
                            <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                                SortExpression="ItemDescription" />
                            <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                                SortExpression="BatchNumber" />
                            <asp:BoundField DataField="status" HeaderText="status" 
                                SortExpression="status" >
                            </asp:BoundField>
                            <asp:BoundField DataField="IntermediateStatus" HeaderText="IntermediateStatus" 
                                SortExpression="IntermediateStatus" >
                            </asp:BoundField>
                            <asp:BoundField DataField="WorkCentreDesc" HeaderText="WorkCentreDesc" 
                                SortExpression="WorkCentreDesc" >
                            </asp:BoundField>
                            <asp:BoundField DataField="EndDate" HeaderText="EndDate" 
                                SortExpression="EndDate" DataFormatString="{0:d}" HtmlEncode="False" >
                            </asp:BoundField>
                            <asp:BoundField DataField="nextWorkCentre" HeaderText="nextWorkCentre" 
                                SortExpression="nextWorkCentre" >
                            </asp:BoundField>
                            <asp:BoundField DataField="nextEndDate" HeaderText="nextEndDate" 
                                SortExpression="nextEndDate" DataFormatString="{0:d}" HtmlEncode="False" >
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ObjectDataSource ID="odsBatchWorkCentre" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                        TypeName="dsBatchTableAdapters.BatchWorkCentreStatusPackBulkTableAdapter">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="100" Name="highestTranstype" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
    <div>
        <table class="style1">
            <tr>
                <td>

    <asp:LinkButton ID="lnkhidden" runat="server"></asp:LinkButton>
                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
                        PopupControlID="panel1" TargetControlID="lnkHidden">
                    </cc1:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="#FFFFCC" ScrollBars="Vertical" 
                        BorderStyle="Double" BorderWidth="4px" Height="600px" Width="1000px">
    
    
    <div>
  
        <asp:ObjectDataSource ID="odsPerformance" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="dsBatchTableAdapters.BatchRouteActualDetailsTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="spcid" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table class="style1">
            <tr>
                <td>
                    Ship Plan Com Order Details</td>
                <td align="right">
                    <asp:LinkButton ID="LinkButton1" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px">Close</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <div >
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="odsPerformance" BackColor="White" BorderColor="#E7E7FF" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                                SortExpression="TPCOrderNo" />
                            <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                                SortExpression="BatchNumber" />
                            <asp:BoundField DataField="StartDate" DataFormatString="{0:d}" 
                                HeaderText="StartDate" SortExpression="StartDate" />
                            <asp:BoundField DataField="WorkCentreDesc" HeaderText="WorkCentreDesc" 
                                SortExpression="WorkCentreDesc" />
                            <asp:BoundField DataField="EndDate" DataFormatString="{0:d}" 
                                HeaderText="EndDate" SortExpression="EndDate" />
                            <asp:BoundField DataField="TransDate" DataFormatString="{0:d}" 
                                HeaderText="TransDate" SortExpression="TransDate" />
                            <asp:BoundField DataField="BatchID" HeaderText="BatchID" 
                                SortExpression="BatchID" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                SortExpression="Quantity" />
                            <asp:BoundField DataField="WorkCentreID" HeaderText="WorkCentreID" 
                                SortExpression="WorkCentreID" />
                        </Columns>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
        
          </div>
    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <br />
                </td>
            </tr>
        </table>
    
    </div>
    
    </asp:Content>

