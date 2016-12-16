<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="wf_QuanLySV.aspx.cs" Inherits="KetNoiDuLieuSQL.wf_QuanLySV" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style2 {
            height: 23px;
        }
        .auto-style3 {
        }
        .auto-style5 {
            width: 311px;
        }
        .auto-style6 {
            width: 123px;
        }
        .auto-style7 {
            width: 123px;
            height: 30px;
        }
        .auto-style8 {
            width: 311px;
            height: 30px;
        }
        .auto-style9 {
            height: 30px;
        }
        .auto-style10 {
            width: 123px;
            height: 42px;
        }
        .auto-style11 {
            width: 311px;
            height: 42px;
        }
        .auto-style12 {
            width: 123px;
            height: 41px;
        }
        .auto-style13 {
            width: 311px;
            height: 41px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table style="width: 100%;">
            <tr>
                <td class="auto-style2" colspan="3"></td>
            </tr>
            <tr>
                <td class="auto-style10">
                    <asp:Label ID="Label2" runat="server" Text="Mã số SV:"></asp:Label>
                </td>
                <td class="auto-style11">
                    <asp:TextBox ID="txtMaSV" runat="server"></asp:TextBox>
                    <br />
                    <br />
                </td>
                <td rowspan="3">
                    <asp:Image ID="Image1" runat="server" Height="81px" ImageUrl="~/Image/defaultImage.png" Width="150px" />
                    <br />
                    <asp:FileUpload ID="FileUpload1" ClientIDMode="Static" runat="server" />
                    </td>
            </tr>
            <tr>
                <td class="auto-style12">
                    <asp:Label ID="Label3" runat="server" Text="Họ và Tên:"></asp:Label>
                </td>
                <td class="auto-style13">
                    <asp:TextBox ID="txtHoTen" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Label ID="Label4" runat="server" Text="Ngày sinh:"></asp:Label>
                </td>
                <td class="auto-style5">
                    <asp:TextBox ID="txtNgaySinh" runat="server"></asp:TextBox>
                     
                    <asp:ImageButton ID="ImageCal" runat="server" Height="22px" ImageUrl="~/icolich.jpg" OnClick="ImageCal_Click" Width="27px" />
                    <asp:Calendar ID="Calendar1" runat="server" Height="16px" OnSelectionChanged="Calendar1_SelectionChanged" SelectedDate="1990-01-01" Visible="False" Width="192px"></asp:Calendar>
                     
                </td>
            </tr>
            <tr>
                <td class="auto-style7">
                </td>
                <td class="auto-style8">
                    <asp:Button ID="Button1" runat="server" OnClick="btnThem_Click" Text="Thêm" />
                </td>
                <td class="auto-style9">
                    <asp:CheckBox ID="cbPreview" runat="server" Text="Preview" />
                </td>
            </tr>
            <tr>
                <td class="auto-style3" colspan="3">
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="589px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDeleting="GridView1_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="MaSV" HeaderText="Mã Sinh Viên" />
                            <asp:BoundField DataField="HoTen" HeaderText="Họ và Tên" />
                            <asp:BoundField DataField="NgaySinh" DataFormatString="{0:dd/MM/yy}" HeaderText="Ngày Sinh" />
                            <asp:CommandField ShowSelectButton="True" ShowDeleteButton="True" />
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [SINHVIEN] WHERE [MaSV] = @MaSV" InsertCommand="INSERT INTO [SINHVIEN] ([HoTen], [MaSV], [NgaySinh]) VALUES (@HoTen, @MaSV, @NgaySinh)" SelectCommand="SELECT [HoTen], [MaSV], [NgaySinh] FROM [SINHVIEN]" UpdateCommand="UPDATE [SINHVIEN] SET [HoTen] = @HoTen, [NgaySinh] = @NgaySinh WHERE [MaSV] = @MaSV">
                        <DeleteParameters>
                            <asp:Parameter Name="MaSV" Type="String" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="HoTen" Type="String" />
                            <asp:Parameter Name="MaSV" Type="String" />
                            <asp:Parameter DbType="Date" Name="NgaySinh" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="HoTen" Type="String" />
                            <asp:Parameter DbType="Date" Name="NgaySinh" />
                            <asp:Parameter Name="MaSV" Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
