using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace Sample_01
{
    public class _1_4_2
    {
        public static  void OldQurey(Page p)
        {
            string connectionString=System.Configuration.ConfigurationManager.ConnectionStrings["LinqDBConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            string strcmd = "select * from userinfo";
            SqlCommand cmd = new SqlCommand(strcmd, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                if (dr["Username"].ToString().Length>10)
                {
                    p.Response.Write(dr["Username"].ToString() + "<br/>");
                }
            }
            dr.Close();
            con.Close();
        }
        public static void LINQQuery(Page p)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LinqDBConnectionString"].ConnectionString;
            LinqDBDataContext db=new LinqDBDataContext(connectionString );
            var results=from u in db.UserInfo
                        where u.Username.Length>10
                        select u;
            foreach (var u in results)
	{
                p.Response.Write(u.Username+"<br/>");
	}
        }
    }
}