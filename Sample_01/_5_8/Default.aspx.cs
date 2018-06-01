using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _5_8
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AsEnumerableQuery();
        }
        void AsEnumerableQuery()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 10; i++)
            {
                users.Add(new UserInfo(i % 2, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }
            var values = from u in users.AsEnumerable<UserInfo>()
                         where u.Username.IndexOf("05") > -1
                         select u;
            Response.Write("AsEnumerable 的操作结果：");
            foreach (var item in values )
            {
                Response.Write(item.Username + ",");
            }
            Response.Write("<br/>");
        }
    }
}