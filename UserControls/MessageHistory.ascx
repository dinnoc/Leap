<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MessageHistory.ascx.vb" Inherits="UserControls_MessageHistory" %>
<style type="text/css">

        .style1
        {
            width: 100%;
        }
        .style5
        {
            font-size: medium;
        }
        .style4
        {
            font-size: x-small;
            color: #CCCCCC;
        }
        </style>
                    <asp:DataList ID="DataList1" runat="server" BorderStyle="Solid" 
                        DataKeyField="spcBatchID" DataSourceID="odsBatchComments" Width="600px">
                        <AlternatingItemStyle BackColor="#F7F7F7" />
                        <ItemStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
           
      <HeaderTemplate >
      
      Comments
      
      </HeaderTemplate>
         
                        <ItemTemplate>
                            <table class="style1">
                                <tr>
                                    <td width="100px">
                                        <asp:Label ID="WorkCentreDescLabel" runat="server" CssClass="style5" 
                                            Font-Bold="True" ForeColor="#3399FF" Text='<%# Eval("WorkCentreDesc") %>' />
                                        <br />
                                        <asp:Label ID="CommDateLabel" runat="server" CssClass="style5" 
                                            Font-Size="X-Small" Text='<%# Eval("CommDate") %>' />
                                        -<asp:Label ID="CommUserLabel" runat="server" CssClass="style5" 
                                            Font-Size="X-Small" Text='<%# Eval("CommUser") %>' />
                                                                   
                                     
                                    </td>
                                    <td valign="top">
                                        <asp:Label ID="WkCtrPerfCommentLabel" runat="server" 
                                            Text='<%# Eval("WkCtrPerfComment") %>' />
                                    </td>
                                    <td width="80px">
                                       <span class="style4">InterimApproval: </span>
                                        <asp:Label ID="InterimApprovalLabel" runat="server" CssClass="style4" 
                                            Text='<%# Eval("InterimApproval") %>' />
                                                                       
                                        <br class="style4" />
                                        <span class="style4">Urgent: </span> 
                                        <asp:Label ID="UrgentLabel" runat="server" CssClass="style4" 
                                            Text='<%# Eval("Urgent") %>' /><br class="style4" />
                                            
                                                  <span class="style4">FIO: </span>
                                        <asp:Label ID="FIOLabel" runat="server" CssClass="style4" 
                                            Text='<%# Eval("FIO") %>' />
                                    
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                      
                    </asp:DataList>
                    
                    <asp:ObjectDataSource ID="odsBatchComments" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                        TypeName="ShipPlanComTableAdapters.CommentsByBatchIDTableAdapter">
                        <SelectParameters>
                            <asp:Parameter Name="SPCBatchID" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                