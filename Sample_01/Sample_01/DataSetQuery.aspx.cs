using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sample_01
{
    public partial class DataSetQuery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OldQurey();
            LINQQuery();
        }
         DataSet GetDataSet()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LinqDBConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            string strcmd = "select * from userinfo";
            SqlDataAdapter da = new SqlDataAdapter(strcmd, con);
            con.Open();
            DataSet ds = new DataSet();
            da.Fill(ds, "UserInfo");
            con.Close();
            return ds;
        }
        public  void OldQurey()
        {

            DataSet ds = GetDataSet();
            foreach (DataRow row in ds.Tables["UserInfo"].Rows)
            {
                if (row["UserName"].ToString().Length > 10)
                {
                    Response.Write(row["UserName"].ToString() + "<br/>");
                }
            }
        }
        public  void LINQQuery( )
        {
            DataSet ds = GetDataSet();
            var results = from u in ds.Tables["UserInfo"].AsEnumerable()
                          where u.Field<string>("UserName").Length > 10
                          select u;
            foreach (var u in results)
            {
                Response.Write(u.Field<string>("UserName").ToString() + "<br/>");
            }
        }
    }
}