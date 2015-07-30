<%@ Page Title="" Language="VB" MasterPageFile="~/leapback.master" AutoEventWireup="false" CodeFile="TestAndShipExcelData.aspx.vb" Inherits="Reports_TestAndShipExcelData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="2">
                <h3>
                    Test and Ship Excel Report</h3>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblStart" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="txtStart" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtEnd" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:Label ID="lblEnd" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="odsTestAndShip" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="BatchNumber" HeaderText="BatchNumber" 
                            SortExpression="BatchNumber" />
                        <asp:BoundField DataField="BatchTrimmed" HeaderText="BatchTrimmed" 
                            SortExpression="BatchTrimmed" />
                        <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                            SortExpression="ItemCode" />
                        <asp:BoundField DataField="TPCOrderNo" HeaderText="TPCOrderNo" 
                            SortExpression="TPCOrderNo" />
                        <asp:BoundField DataField="FirstMandecDate" HeaderText="FirstMandecDate" 
                            ReadOnly="True" SortExpression="FirstMandecDate" 
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="FinalQCTestDate" HeaderText="FinalQCTestDate" 
                            SortExpression="FinalQCTestDate" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="FinalApprovalDate" HeaderText="FinalApprovalDate" 
                            SortExpression="FinalApprovalDate" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="TPCConfirmedCollectionDate" 
                            HeaderText="TPCConfirmedCollectionDate" 
                            SortExpression="TPCConfirmedCollectionDate" 
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="AuditComment" HeaderText="AuditComment" 
                            SortExpression="AuditComment" />
                        <asp:BoundField DataField="QC_Comment" HeaderText="QC_Comment" 
                            SortExpression="QC_Comment" />
                        <asp:BoundField DataField="Comment_date" HeaderText="Comment_date" 
                            SortExpression="Comment_date" />
                        <asp:BoundField DataField="FirstLimsApprovalDate" 
                            HeaderText="FirstLimsApprovalDate" ReadOnly="True" 
                            SortExpression="FirstLimsApprovalDate" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="spcBatchID" HeaderText="spcBatchID" 
                            SortExpression="spcBatchID" />
                        <asp:BoundField DataField="QCTestStartDate" HeaderText="QCTestStartDate" 
                            SortExpression="QCTestStartDate" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="BatchReviewComment" HeaderText="BatchReviewComment" 
                            SortExpression="BatchReviewComment" />
                        <asp:BoundField DataField="batchReviewComm_date" 
                            HeaderText="batchReviewComm_date" SortExpression="batchReviewComm_date" />
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="odsTestAndShip" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsBatchTableAdapters.TestAndShipExcelTableAdapter">
                    <SelectParameters>
                        <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

