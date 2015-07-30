 <%@ Page Title="Work Centre Performance" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="QAQPMeeting.aspx.vb" Inherits="WorkCentrePerformance" %>

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
                <h4>QA QP Daily Meeting Report<asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </h4>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;<br />
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
            <td colspan="6">
            <asp:UpdatePanel id = gvUpdate runat = server  UpdateMode =Conditional>
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" DataSourceID="odsWCPerformance" GridLines="Vertical" 
                        DataKeyNames="BatchNumber,BatchTrimmed">
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" 
                                SortExpression="ItemDescription" />
                            <asp:HyperLinkField DataNavigateUrlFields="BatchNumber" 
                                DataNavigateUrlFormatString="~/reports/batchview.aspx?Batchid={0}" 
                                DataTextField="BatchNumber" HeaderText="Batch No" />
                            <asp:BoundField DataField="TILShippingMemoDate" 
                                DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ship Memo Date" 
                                HtmlEncode="False" SortExpression="TILShippingMemoDate" />
                            <asp:BoundField DataField="EndDate" DataFormatString="{0:dd/MM/yyyy}" 
                                HeaderText="Due Date" HtmlEncode="False" SortExpression="EndDate" />
                            <asp:BoundField DataField="WkCtrPerfComment" HeaderText="Comments" 
                                SortExpression="WkCtrPerfComment" />
                            <asp:BoundField DataField="CommDate" 
                                SortExpression="CommDate" >
                            <ItemStyle Font-Size="XX-Small" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BlisterLine" HeaderText="Blister Line" 
                                SortExpression="BlisterLine" />
                            <asp:TemplateField HeaderText="PR Count"></asp:TemplateField>
                              <asp:TemplateField HeaderText="BRTS QP Name"></asp:TemplateField>
                                   <asp:TemplateField HeaderText="BRTS QA Name"></asp:TemplateField>
                                           <asp:TemplateField HeaderText="BRTS QC Receipt"></asp:TemplateField>
                                          <asp:TemplateField HeaderText="BRTS QA Receipt"></asp:TemplateField>
                                         <asp:TemplateField HeaderText="BRTS QA Review"></asp:TemplateField>
                                      <asp:TemplateField HeaderText="BRTS Primary QP"></asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        
                <asp:ObjectDataSource ID="odsWCPerformance" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="dsBatchTableAdapters.QAQPReportTableAdapter">
                    <SelectParameters>
                        <asp:Parameter Name="startdate" Type="String" />
                        <asp:Parameter Name="enddate" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>

            
                QA Lead<asp:TextBox ID="txtQALead" runat="server" Width="35px">3</asp:TextBox>
                &nbsp;QP Lead<asp:TextBox ID="TextBox1" runat="server" Width="35px">5</asp:TextBox>
            
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

