using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KetNoiDuLieuSQL
{
    public partial class wf_QuanLySV : System.Web.UI.Page
    {
        DataTable table;
        SqlConnection con;
        string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        byte[] imgByte = new byte[0];
        void loadData()
        {
            table = new DataTable();
            con = new SqlConnection(cs);
            SqlDataAdapter adt = new SqlDataAdapter("select * from SINHVIEN", con);
            adt.FillSchema(table, SchemaType.Source);
            adt.Fill(table);
            if (table.Rows.Count > 0)
            {
                GridView1.DataSource = table;
                GridView1.DataBind();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData();
        }
        protected void btnThem_Click(object sender, EventArgs e)
        {
            if(txtMaSV.Text.Length == 0 || txtHoTen.Text.Length ==0 || txtNgaySinh.Text.Length ==0)
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Lỗi chưa nhập đủ thông tin!!')", true);
            try
            {
                    SqlCommand cm = new SqlCommand("insert into SINHVIEN values ('" + txtMaSV.Text + "',N'" + txtHoTen.Text + "',@date,@Image)", con);
                    if (FileUpload1.FileName.Length > 0)
                    {
                        HttpPostedFile postedFile = FileUpload1.PostedFile;
                        string fileName = Path.GetFileName(postedFile.FileName);
                        string fileExtension = Path.GetExtension(fileName);
                        if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == "png")
                        {
                            Stream stream = postedFile.InputStream;
                            BinaryReader binaryReader = new BinaryReader(stream);
                            imgByte = binaryReader.ReadBytes((int)stream.Length);
                        }
                        SqlParameter img = new SqlParameter("@Image", imgByte);
                        cm.Parameters.Add(img);
                    }
                    else
                    {
                        cm.CommandText = "insert into SINHVIEN values ('" + txtMaSV.Text + "',N'" + txtHoTen.Text + "',@date,null)";
                    }
                    cm.Parameters.Add(new SqlParameter("@date",Calendar1.SelectedDate));
                    con.Open();
                    cm.ExecuteNonQuery();
                    con.Close();
                    loadData();
            }
            catch (Exception f)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Lỗi nhập thông tin sai!!')", true);
            }
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int r = GridView1.SelectedIndex;
            GridViewRow s = GridView1.Rows[r];
            string a = s.Cells[0].Text;

            if (cbPreview.Checked)
            {
                DataRow row = table.Rows.Find(a);
                if (row != null && row[3].ToString()!= "")
                {
                    byte[] by = (byte[])row["HinhAnh"];
                    string strbase64 = Convert.ToBase64String(by);

                    Image1.ImageUrl = "Data:Image/jpg;base64," + strbase64;
                }
                else
                {
                    Image1.ImageUrl = @"~\Image\defaultImage.png";
                }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int r = e.RowIndex;
            GridViewRow s = GridView1.Rows[r];
            string a = s.Cells[0].Text;

            con.Open();
            SqlCommand cm = new SqlCommand("delete from SINHVIEN where MaSV = '" + a + "'",con);
            cm.ExecuteNonQuery();
            con.Close();
            loadData();
        }

        protected void ImageCal_Click(object sender, ImageClickEventArgs e)
        {
            Calendar1.Visible = true;
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            txtNgaySinh.Text = Calendar1.SelectedDate.ToShortDateString();
            Calendar1.Visible = false;
        }
    }
}
