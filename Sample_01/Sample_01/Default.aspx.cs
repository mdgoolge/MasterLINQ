using System;
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
                LINQQueryData();
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

            foreach (var item in query )
            {
                Response.Write(item.ToString() + "<br/>");
            }
        }
    }
}