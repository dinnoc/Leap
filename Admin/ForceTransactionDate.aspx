<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="ForceTransactionDate.aspx.vb" Inherits="Admin_ForceTransactionDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
        DataKeyNames="TransactionID" DataSourceID="odsTransacations" 
        DefaultMode="Insert" EnableModelValidation="True" Height="50px" Width="125px">
        <Fields>
            <asp:BoundField DataField="FromFile" HeaderText="FromFile" 
                SortExpression="FromFile" />
            <asp:TemplateField HeaderText="TransType" SortExpression="TransType">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TransType") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="odsTransTypes" DataTextField="WorkCentreDesc" 
                        DataValueField="WorkCentreCompleteTransaction">
                    </asp:DropDownList>
                    <asp:ObjectDataSource ID="odsTransTypes" runat="server" DeleteMethod="Delete" 
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="GetData" 
                        TypeName="RoutingsTableAdapters.LeaP_WorkCentreTableAdapter" 
                        UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="WorkCentreDesc" Type="String" />
                            <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="WorkCentreDesc" Type="String" />
                            <asp:Parameter Name="WorkCentreCompleteTransaction" Type="Int32" />
                            <asp:Parameter Name="Original_WorkCentreID" Type="Int32" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("TransType") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TransDate" HeaderText="TransDate (mm/dd/yyyy)"
                SortExpression="TransDate" />
            <asp:BoundField DataField="FileReadDate" HeaderText="FileReadDate (mm/dd/yyyy)" 
                SortExpression="FileReadDate" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                SortExpression="Quantity" />
            <asp:BoundField DataField="BatchID" HeaderText="BatchID" 
                SortExpression="BatchID" />
            <asp:BoundField DataField="ItemCode" HeaderText="ItemCode" 
                SortExpression="ItemCode" />
            <asp:BoundField DataField="BatchIDTrim" HeaderText="BatchIDTrim" 
                SortExpression="BatchIDTrim" />
            <asp:CommandField ShowInsertButton="True" />
        </Fields>
    </asp:DetailsView>
    <asp:ObjectDataSource ID="odsTransacations" runat="server" 
        DeleteMethod="Delete" InsertMethod="Insert" 
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="InterfaceScraperTableAdapters.LeaP_TransactionsTableAdapter" 
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_TransactionID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="FromFile" Type="String" />
            <asp:Parameter Name="TransType" Type="Int32" />
            <asp:Parameter Name="TransDate" Type="DateTime" />
            <asp:Parameter Name="FileReadDate" Type="DateTime" />
            <asp:Parameter Name="Quantity" Type="Decimal" />
            <asp:Parameter Name="BatchID" Type="String" />
            <asp:Parameter Name="ItemCode" Type="String" />
            <asp:Parameter Name="BatchIDTrim" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="FromFile" Type="String" />
            <asp:Parameter Name="TransType" Type="Int32" />
            <asp:Parameter Name="TransDate" Type="DateTime" />
            <asp:Parameter Name="FileReadDate" Type="DateTime" />
            <asp:Parameter Name="Quantity" Type="Decimal" />
            <asp:Parameter Name="BatchID" Type="String" />
            <asp:Parameter Name="ItemCode" Type="String" />
            <asp:Parameter Name="BatchIDTrim" Type="String" />
            <asp:Parameter Name="Original_TransactionID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

