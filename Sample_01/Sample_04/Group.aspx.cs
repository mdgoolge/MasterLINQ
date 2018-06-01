using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sample_04
{
    public partial class Group : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GroupQuery();
        }
        private void GroupQuery()
        {   ///构建数据源
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 1; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }
            ///根据用户的Username的值进行分组
            var values = from u in users
                         group u by Int32.Parse(u.Username.Substring(u.Username.Length - 2)) % 2 == 0;
            ///显示查询结果
            foreach (var v in values)
            {
                foreach (UserInfo u in v)
                {
                    Response.Write(u.Username + "</br>");
                }
            }
        }

        private void GroupOtherQuery()
        {   ///构建数据源
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 1; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }
            ///根据用户的Username的值进行分组
            var values = from u in users
                         group u by Int32.Parse(u.Username.Substring(u.Username.Length - 2)) % 2 == 0 into g
                         where g.Count() >= 5
                         select g;
            ///显示查询结果
            foreach (var v in values)
            {
                foreach (UserInfo u in v)
                {
                    Response.Write(u.Username + "</br>");
                }
            }
        }
    }
}