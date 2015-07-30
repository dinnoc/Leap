 <%@ Page Title="Work Centre Performance" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="WorkCentrePerformance.aspx.vb" Inherits="WorkCentrePerformance" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<%@ Register src="../UserControls/MessageControl.ascx" tagname="MessageControl" tagprefix="uc1" %>

<%@ Register src="../UserControls/MessageHistory.ascx" tagname="MessageHistory" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style4 {
            height: 57px;
        }
        .style5
        {
            height: 250px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="6" class="style4">
                <h4>Work Centre Performance<asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </h4>
            </td>
        </tr>
        <tr>
            <td>
                Work Centre:                 
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="odsWorkCentre" DataTextField="WorkCentreDesc" 
                    DataValueField="WorkCentreID">
                </asp:DropDownList>
                <asp:ObjectDataSource ID="odsWorkCentre" runat="server" DeleteMethod="Delete" 
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
            <td>
                Start Date</td>
            <td>
                <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
           
                <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                    TargetControlID="txtStartDate">
                </cc1:CalendarExtender>
           
            </td>
            <td>
                End Date</td>
            <td>
               
                   
                        <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
                    
                
           
                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" 
                    TargetControlID="txtEndDate">
                </cc1:CalendarExtender>
           
            </td>
            <td>
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" />
            </td>
        </tr>
        <tr>
            <td>
               Total Batches<td>
                <b>
                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                </b>
            </td>
            <td>
                <b>Batches on or before target</b></td>
            <td>
                <b>
                <asp:Label ID="lblOK" runat="server"></asp:Label>
                </b>
            </td>
            <td>
                <b>Performance</b></td>
            <td>
                <b>
                <asp:Label ID="lblPerformance" runat="server"></asp:Label>
                </b>
            </td>
        </tr>
        <tr>
            <td colspan="6" class="style5">
            <asp:UpdatePanel id = gvUpdate runat = server  UpdateMode =Conditional>
            <ContentTemplate >
                       
                 <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataSourceID="odsWCPerformance" Width="100%" 
                    DataKeyNames="spcBatchID,BatchNumber,ExclCounter" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    GridLines="Horizontal">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                            SortExpression="TPCOrderNo" />
                        <asp:ButtonField CommandName="gvBatch" DataTextField="BatchNumber" 
                            Text="Button" HeaderText="Batch Number" SortExpression="BatchNumber" />
                        <asp:BoundField DataField="SPCItem" HeaderText="SPCItem" 
                            SortExpression="SPCItem" ReadOnly="True" />
                        <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                            SortExpression="ItemDescription" />
                        <asp:BoundField DataField="TILShippingMemoDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Ship Memo" SortExpression="TILShippingMemoDate" />
                        <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Target Date" SortExpression="EndDate" />
                        <asp:BoundField DataField="TransDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Actual Date" SortExpression="TransDate" />
                        <asp:BoundField DataField="ItemCode" HeaderText="Actual ItemCode" 
                            SortExpression="ItemCode" />
                        <asp:BoundField DataField="ActualMinusTarget" HeaderText="ActualMinusTarget" 
                            ReadOnly="True" SortExpression="ActualMinusTarget" />
                        <asp:ButtonField CommandName="Exception" ShowHeader="True" Text="Exception">
                        <ItemStyle Font-Size="XX-Small" ForeColor="Green" />
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="AddComment" Text="Comment" >
                        <ItemStyle Font-Size="X-Small" ForeColor="Red" />
                        </asp:ButtonField>
                        <asp:BoundField DataField="WkCtrPerfComment" HeaderText="WkCtrPerfComment" 
                            SortExpression="WkCtrPerfComment" />
                        <asp:BoundField DataField="CommDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Date" SortExpression="CommDate">
                        <ItemStyle Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BlisterLine" HeaderText="BlisterLine" 
                            SortExpression="BlisterLine" />
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                
                   </ContentTemplate>
            </asp:UpdatePanel>
        
                <asp:ObjectDataSource ID="odsWCPerformance" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsBatchTableAdapters.WorkCentrePerformanceTableAdapter">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="workcentreID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <cc1:ModalPopupExtender ID="mpeBatch" runat="server" PopupControlID="pnlBatch" 
                    TargetControlID="lnkHidden">
                </cc1:ModalPopupExtender>
                <asp:LinkButton ID="lnkHidden" runat="server"></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td colspan="6">
    <asp:Panel ID="pnlBatch" runat="server" BackColor="#FFFFCC" ScrollBars="Vertical" 
                        BorderStyle="Double" BorderWidth="4px" Height="600px" Width="1250px">
    
    
    <div>
  <asp:UpdatePanel id= "upBatchDetails" runat = server UpdateMode =Conditional >
  <ContentTemplate >
  
  
  

        <asp:ObjectDataSource ID="odsPerformance" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy" 
            TypeName="dsBatchTableAdapters.BatchRouteActualDetailsTableAdapter">
            <SelectParameters>
                <asp:Parameter Name="spcbatchID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table class="style1">
            <tr>
                <td>
                    Ship Plan Com Order Details</td>
                <td align="right">
                    <asp:LinkButton ID="lnkClose" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px">Close</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <div >
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="odsPerformance" BackColor="White" BorderColor="#E7E7FF" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        GridLines="Horizontal" Width="100%">
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                                SortExpression="TPCOrderNo" />
                            <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                                SortExpression="BatchNumber" />
                            <asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="StartDate" SortExpression="StartDate" />
                            <asp:BoundField DataField="WorkCentreDesc" HeaderText="WorkCentreDesc" 
                                SortExpression="WorkCentreDesc" />
                            <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="EndDate" SortExpression="EndDate" />
                            <asp:BoundField DataField="TransDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="TransDate" SortExpression="TransDate" />
                            <asp:BoundField DataField="BatchID" HeaderText="BatchID" 
                                SortExpression="BatchID" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                SortExpression="Quantity" />
                            <asp:BoundField DataField="WorkCentreID" HeaderText="WorkCentreID" 
                                SortExpression="WorkCentreID" />
                            <asp:BoundField DataField="WkCtrPerfComment" HeaderText="Comments" 
                                SortExpression="WkCtrPerfComment" />
                            <asp:BoundField DataField="CommDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="CommDate" SortExpression="CommDate">
                                <ItemStyle Font-Size="X-Small" />
                            </asp:BoundField>
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
            <tr>
                <td colspan="2">
                <div>
                    <uc2:MessageHistory ID="MessageHistory1" runat="server" />
                </div>
                </td>
            </tr>
        </table>
        
          </div>
          
            </ContentTemplate>
  
  </asp:UpdatePanel>
                </asp:Panel>
                </td>
        </tr>
        <tr>
            <td colspan="6">
                <uc1:MessageControl ID="MessageControl1" runat="server" />
                </td>
        </tr>
        <tr>
            <td colspan="6">
                <cc1:ModalPopupExtender ID="mpeComment" runat="server" PopupControlID="pnlAddComment" 
                    TargetControlID="lnkHidden">
                </cc1:ModalPopupExtender>
                </td>
        </tr>
        <tr>
            <td colspan="6">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

