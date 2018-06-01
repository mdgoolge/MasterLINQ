using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _5_7
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ElementAt();
        }

        private void ElementAt()
        {
            int[] ints = new int[100];
            for (int i = 0; i < 100; i++)
            {
                ints[i] = i;
            }
            int value = ints.ElementAt(10);
            Response.Write("elementan 10:" + value.ToString() + "</br>");
        }
    }
}