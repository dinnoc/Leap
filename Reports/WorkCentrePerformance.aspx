 <%@ Page Title="Work Centre Performance" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="WorkCentrePerformance.aspx.vb" Inherits="WorkCentrePerformance" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<%@ Register src="../UserControls/MessageControl.ascx" tagname="MessageControl" tagprefix="uc1" %>

<%@ Register src="../UserControls/MessageHistory.ascx" tagname="MessageHistory" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style4 {
            height: 57px;
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
                <asp:Label ID="lblTransType" runat="server" Visible="False"></asp:Label>
                <br />
                <asp:CheckBox ID="cbIncomplete" runat="server" Text="Show only incomplete" />
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
                <b>Total Batches</b><td>
                <b>
                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                </b>
            </td>
            <td>
                <b>Average Target Duration</b></td>
            <td>
                <asp:Label ID="lblAvgTarget" runat="server" style="font-weight: 700"></asp:Label>
            </td>
            <td>
                <b>CpK</b></td>
            <td>
                <asp:Label ID="lblCpK" runat="server" style="font-weight: 700"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <b>Batches on or before target</b><td>
                <b>
                <asp:Label ID="lblOK" runat="server"></asp:Label>
                </b>
            </td>
            <td>
                <b>Average Actual Duration </b></td>
            <td>
                <asp:Label ID="lblAverageActual" runat="server" style="font-weight: 700"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <b>Performance</b><td>
                <b>
                <asp:Label ID="lblPerformance" runat="server"></asp:Label>
                </b>
            </td>
            <td>
                <b>Standard Deviation Actual Duration</b></td>
            <td>
                <asp:Label ID="lblStdevActual" runat="server" style="font-weight: 700"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="6">
            <asp:UpdatePanel id = gvUpdate runat = server  UpdateMode =Conditional>
            <ContentTemplate >
                       
                 <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataSourceID="odsWCPerformance" Width="100%" 
                    
                     DataKeyNames="spcBatchID,BatchNumber,ExclCounter,RouteDuration,ActualMinusTarget" 
                     BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    GridLines="Horizontal">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                            SortExpression="TPCOrderNo" />
                        <asp:HyperLinkField DataNavigateUrlFields="BatchNumber" 
                            DataNavigateUrlFormatString="~/reports/batchview.aspx?Batchid={0}" 
                            DataTextField="BatchNumber" DataTextFormatString="{0}" HeaderText="Batch" />
                 
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
                        <asp:BoundField DataField="WkCtrPerfComment" HeaderText="WkCtrPerfComment" 
                            SortExpression="WkCtrPerfComment" />
                        <asp:BoundField DataField="CommDate" DataFormatString="{0:dd/MM/yyyy}" 
                            HeaderText="Date" SortExpression="CommDate">
                        <ItemStyle Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BlisterLine" HeaderText="BlisterLine" 
                            SortExpression="BlisterLine" />
                            
                             <asp:BoundField DataField="RouteDuration" HeaderText="Duration" 
                            SortExpression="RouteDuration" />
                            
                            
                            
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
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy" 
                    TypeName="dsBatchTableAdapters.WorkCentrePerformanceTableAdapter">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="workcentreID" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                        <asp:Parameter Name="transType" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>

            
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <uc1:MessageControl ID="MessageControl1" runat="server" />
                </td>
        </tr>
        <tr>
            <td colspan="6">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

