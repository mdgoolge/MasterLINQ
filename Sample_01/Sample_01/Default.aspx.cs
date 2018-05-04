using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sample_01
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //LINQQueryData();
                //Response.Write("<br/>");

                //OldQuery();
                //Response.Write("<br/>");

                //LINQQuery();
                //Response.Write("<br/>");

                _1_4_2.OldQurey(this);
            }
        }
        void LINQQueryData()
        {
            int[] datasource = new int[100];
            for (int i = 0; i < 100; i++)
            {
                datasource[i] = i;
            }

            var query = from i in datasource
                        where i < 10
                        select i;

            foreach (var item in query)
            {
                Response.Write(item.ToString() + "<br/>");
            }
        }
        void OldQuery()
        {
            string[] datasource = new string[100];
            for (int i = 0; i < 100; i++)
            {
                datasource[i] = "A" + i.ToString().PadLeft(2, '0');
            }

            ArrayList results = new ArrayList();
            foreach (string s in datasource)
            {
                int index = Int32.Parse(s.Substring(1));
                if (index % 2 == 0)
                {
                    results.Add(s);
                }
            }

            foreach (var item in results)
            {
                Response.Write(item + "<br/>");
            }
        }
        void LINQQuery()
        {
            string[] datasource = new string[100];
            for (int i = 0; i < 100; i++)
            {
                datasource[i] = "A" + i.ToString().PadLeft(2, '0');
            }

            var results = from s in datasource
                          let index = int.Parse(s.Substring(1))
                          where index % 2 == 0
                          select s;

            foreach (var item in results)
            {
                Response.Write(item + "<br/>");
            }
        }
    }
}