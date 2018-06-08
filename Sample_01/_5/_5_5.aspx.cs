using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.MobileControls;
using System.Web.UI.WebControls;

namespace _5
{
    public partial class _5_5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //CountQuery();
            //SumQuery();
            //MaxQuery();
            //AggregateQuery(); 
            LongCountQuery();
        }
        void CountQuery()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }

            int cout = users.Count(u => u.ID > 3 && u.ID < 8);
            Response.Write("cout:" + cout.ToString() + "</br>");
        }
        void SumQuery()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }

            int Sum = users.Sum(u => u.ID);
            Response.Write("Sum:" + Sum.ToString() + "</br>");
        }
        void MaxQuery()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 10; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }

            int Max = users.Max(u => u.ID);
            Response.Write("Max:" + Max.ToString() + "</br>");
        }

        void AggregateQuery()
        {
            int[] ints = new int[100];
            for (int i = 0; i < 100; i++)
            {
                ints[i] = i;
            }
            int aggregate = ints.Aggregate((a, b) => a + b);
            Response.Write("aggregate:" + aggregate.ToString() + "</br>");
        }
        void LongCountQuery()
        {
            List<UserInfo> users = new List<UserInfo>();
            for (int i = 0; i < 1000000; i++)
            {
                users.Add(new UserInfo(i, "User0" + i.ToString(), "User0" + i.ToString() + "@web.com"));
            }

            long count = users.LongCount(u => u.ID > 3);
            Response.Write("longcout:" + count.ToString() + "</br>");
        }
    }
}