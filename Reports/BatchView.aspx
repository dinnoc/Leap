<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="BatchView.aspx.vb" Inherits="Reports_BatchView" %>

<%@ Register src="../UserControls/MessageControl.ascx" tagname="MessageControl" tagprefix="uc1" %>

<%@ Register src="../UserControls/MessageHistory.ascx" tagname="MessageHistory" tagprefix="uc2" %>

<%@ Register src="../UserControls/TrackWiseList.ascx" tagname="TrackWiseList" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: x-small;
            color: #CCCCCC;
        }
        .style5
        {
            font-size: medium;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode =Conditional >
    <ContentTemplate >


    <table class="style1">
        <tr>
            <td>
                <h4>
                    Batch View<asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </h4>
            </td>
        </tr>
        <tr>
            <td>
                Select Batch Number:<asp:TextBox ID="txtBatch" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="Button1" runat="server" Text="Button" />
                <asp:ObjectDataSource ID="odsBatches" runat="server" DeleteMethod="Delete" 
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetDataByBatchNumber" 
                    TypeName="ShipPlanComTableAdapters.LeaP_spcBatchesTableAdapter" 
                    UpdateMethod="Update">
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
                        <asp:ControlParameter ControlID="txtBatch" Name="batchnumber" 
                            PropertyName="Text" Type="String" />
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
        </tr>
        <tr>
            <td>
                <asp:DataList ID="DataList2" runat="server" DataKeyField="BatchNumber" 
                    DataSourceID="odsBatches" RepeatColumns="10" RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" 
                            CommandArgument='<%# Eval("spcBatchID", "{0}") %>' 
                            Text='<%# Eval("BatchNumber", "{0}") %>'></asp:LinkButton>
                        ,
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblBatch" runat="server" ForeColor="White"></asp:Label>
                <br />
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                    CellPadding="3" DataSourceID="odsBatchDetails" GridLines="Horizontal" 
                    Height="50px" Width="500px">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <Fields>
                        <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                            SortExpression="BatchNumber" />
                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                            SortExpression="ItemCode" />
                        <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                            SortExpression="ItemDescription" />
                    </Fields>
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                       <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
           <HeaderTemplate> Batch Details</HeaderTemplate>           
                </asp:DetailsView>
                <asp:ObjectDataSource ID="odsBatchDetails" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="RoutingsTableAdapters.BatchDetailsTableAdapter">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblBatch" Name="spcbatchid" 
                            PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td>
    
    <div>
  
        <asp:ObjectDataSource ID="odsPerformance" runat="server" 
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
            TypeName="dsBatchTableAdapters.BatchRouteDetailsWithCommentsTableAdapter">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblBatch" Name="spcbatchID" 
                    PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <br />
        Leap Transaction Search<table class="style1">
            <tr>
                <td colspan="2">
                <div >
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="odsPerformance" BackColor="White" BorderColor="#E7E7FF" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        GridLines="Horizontal" Width="100%" 
                        DataKeyNames="WorkCentreID,BatchNumber">
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
                            <asp:BoundField DataField="WkCtrPerfComment" HeaderText="Comments" 
                                SortExpression="WkCtrPerfComment" />
                            <asp:BoundField DataField="CommDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="CommDate" SortExpression="CommDate">
                                <ItemStyle Font-Size="X-Small" />
                            </asp:BoundField>
                            <asp:ButtonField CommandName="AddComment" Text="Comment">
                            <ItemStyle Font-Size="X-Small" />
                            </asp:ButtonField>
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
              
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td valign="top" width="50%">
                    Leap Comment Search</td>
                <td style="text-align: left" valign="top">
                    Trackwise PR Search (this is not validated, for GMP queries please use the 
                    trackwise interface)</td>
            </tr>
            <tr>
                <td valign="top" width="50%" rowspan="2">
                    <uc2:MessageHistory ID="MessageHistory1" runat="server" />
                </td>
                <td style="text-align: left" valign="top">
                    <uc3:TrackWiseList ID="TrackWiseList1" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="text-align: left" valign="top">
                    BRTS Data<br />
                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" DataSourceID="odsBRTS" EnableModelValidation="True" 
                        GridLines="Horizontal">
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <Columns>
                            <asp:BoundField DataField="lot" HeaderText="lot" ReadOnly="True" 
                                SortExpression="lot" />
                            <asp:BoundField DataField="description" HeaderText="description" 
                                ReadOnly="True" SortExpression="description" />
                            <asp:BoundField DataField="qp_name" HeaderText="qp_name" ReadOnly="True" 
                                SortExpression="qp_name" />
                            <asp:BoundField DataField="qa_name" HeaderText="qa_name" ReadOnly="True" 
                                SortExpression="qa_name" />
                        </Columns>
                        <EmptyDataTemplate>
                            There is no BRTS data tod
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="odsBRTS" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetLikeBatchData" 
                        TypeName="ODBCTableAdapters.BRTSBatchDataTableAdapter">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtBatch" DefaultValue="1" Name="pelem_id" 
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </td>
            </tr>
        </table>
        
          </div>
   
                </td>
        </tr>
        <tr>
            <td>
                <uc1:MessageControl ID="MessageControl1" runat="server" />
            </td>
        </tr>
    </table>
    
        
    
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

