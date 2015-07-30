<%@ Page Title="" Language="VB" MasterPageFile="~/LeaPBack.master" AutoEventWireup="false" CodeFile="TestAndShip.aspx.vb" Inherits="TestAndShip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="style1">
        <tr>
            <td colspan="10">
                <h4>
                    Test & Ship</h4>
            </td>
        </tr>
        <tr>
            <td>
                First Week</td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>6</asp:ListItem>
                    <asp:ListItem>7</asp:ListItem>
                    <asp:ListItem>8</asp:ListItem>
                    <asp:ListItem>9</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                    <asp:ListItem>13</asp:ListItem>
                    <asp:ListItem>14</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                MPS Year</td>
            <td>
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True">
                    <asp:ListItem>2011</asp:ListItem>
                    <asp:ListItem>2012</asp:ListItem>
                    <asp:ListItem>2013</asp:ListItem>
                    <asp:ListItem>2014</asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="10">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" DataSourceID="odsTestAndShip">
                    <Columns>
                        <asp:BoundField DataField="TabletPress" HeaderText="Tablet Press" 
                            SortExpression="TabletPress" />
                        <asp:BoundField DataField="Granulator" HeaderText="Granulator" 
                            SortExpression="Granulator" />
                        <asp:BoundField DataField="BatchTrimmed" HeaderText="Bulk Batch" 
                            SortExpression="BatchTrimmed" />
                        <asp:BoundField DataField="MPSDate" HeaderText="MPS Date" 
                            SortExpression="MPSDate" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="mpsweek" HeaderText="MPS Week" 
                            SortExpression="mpsweek" />
                        <asp:BoundField DataField="minDisp" HeaderText="Dispense Actual" 
                            SortExpression="minDisp" DataFormatString="{0:d}" ReadOnly="True" />
                        <asp:BoundField DataField="intBatch" HeaderText="Intermediate Status" 
                            SortExpression="intBatch" />
                        <asp:BoundField DataField="maxMandec" 
                            HeaderText="Bulk Mandec Actual" SortExpression="maxMandec" 
                            DataFormatString="{0:d}" ReadOnly="True" />
                        <asp:BoundField DataField="MandecBatch" HeaderText="MandecBatch" 
                            SortExpression="MandecBatch" />
                        <asp:BoundField DataField="shipmemodate" DataFormatString="{0:d}" 
                            HeaderText="Shipping Memo Date" SortExpression="shipmemodate" />
                        <asp:BoundField DataField="DispBatch" HeaderText="Dispense Batch" 
                            SortExpression="DispBatch" >
                        <ItemStyle ForeColor="Silver" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MandecBatch" HeaderText="Bulk Mandec Actual Batch" 
                            SortExpression="MandecBatch">
                        <ItemStyle ForeColor="Silver" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MandecTarget" HeaderText="Bulk Mandec Target Batch" 
                            SortExpression="MandecTarget">
                        <ItemStyle ForeColor="Silver" />
                        </asp:BoundField>
                        <asp:BoundField DataField="WorkCentreID" HeaderText="WorkCentreID" 
                            SortExpression="WorkCentreID">
                        <ItemStyle ForeColor="Silver" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="odsTestAndShip" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                    TypeName="TestAndShipTableAdapters.TestAndShipTableAdapter">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="MpsWeek" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownList2" Name="MPSYear" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

