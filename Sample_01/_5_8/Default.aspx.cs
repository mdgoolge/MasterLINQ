using System;
using System.Collections;
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
            AsQueryable();
            Cast();
            ToDictionary(); ToLookup();
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
            foreach (var item in values)
            {
                Response.Write(item.Username + ",");
            }
            Response.Write("<br/>");
        }
        void AsQueryable()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 10; i++)
            {
                users.Add(new UserInfo(i % 2, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }
            var values = from u in users.AsQueryable<UserInfo>()
                         where u.Username.IndexOf("01") > -1
                         select u;
            Response.Write("AsQueryable 的操作结果：");
            foreach (var item in values)
            {
                Response.Write(item.Username + ",");
            }
            Response.Write("<br/>");
        }
        void Cast()
        {
            ArrayList ints = new ArrayList();
            for (int i = 0; i < 100; i++)
            {
                ints.Add(i.ToString());
            }
            var values = from i in ints.Cast<string>()
                         where i.IndexOf("2") > -1
                         select i;
            Response.Write("Cast 的操作结果：");
            foreach (var item in values)
            {
                Response.Write(item + ",");
            }
            Response.Write("<br/>");
        }
        void ToDictionary()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }
            var values = from u in users
                         where u.ID < 7
                         select u;
            Dictionary<int, UserInfo> dic = values.ToDictionary(u => u.ID);
            Response.Write("ToDictionary 的操作结果：");
            foreach (var item in dic)
            {
                Response.Write(item.Value.Username + ",");
            }
            Response.Write("<br/>");
        }
        void ToLookup()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 1; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }
            var values = from u in users
                         where u.ID < 7
                         select u;

            ILookup<int, UserInfo> lookup = values.ToLookup(u => u.ID);

            Response.Write("ToLookup 的操作结果：");
            foreach (var lu in lookup)
            {
                foreach (var v in lu)
                {
                    Response.Write(v.Username + ",");
                }

            }
            Response.Write("<br/>");
        }
    }
}