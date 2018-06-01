using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace _5_6
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //DistinctQuery(); 
            //ExceptQuery(); 
            //IntersectQuery(); 
            UnionQuery();
        }

        void DistinctQuery()
        {
            List<string> datasource = new List<string>();
            datasource.Add("A");
            datasource.Add("B");
            datasource.Add("B");
            datasource.Add("C");
            datasource.Add("D");
            datasource.Add("D");
            datasource.Add("E");

            var values = datasource.Distinct();
            OutputSetInfo(datasource, "集合A");
            OutputSetInfo(values.ToList<string>(), "去重复后");
            Response.Write("<br/>");

        }
        void OutputSetInfo(List<string> list, string name)
        {
            Response.Write(name + "={");
            for (int i = 0; i < list.Count ; i++)
            {
                if (i<list.Count-1)
                {
                    Response.Write(list[i] + ",");
                }
                else
                {
                    Response.Write(list[i]);
                }
            }
            Response.Write("}<br/>");
        }
        void ExceptQuery()
        {
            List<string> dsA = new List<string>();
            List<string> dsB = new List<string>();
            dsA.Add("A");
            dsA.Add("B");
            dsA.Add("B");
            dsA.Add("C");
            dsA.Add("D");
            dsA.Add("D");
            dsA.Add("E");

            dsB.Add("A");
            dsB.Add("C");
            dsB.Add("C");
            dsB.Add("F");
            dsB.Add("H");

            var values = dsA.Except(dsB);

            OutputSetInfo(dsA, "a");
            OutputSetInfo(dsB, "b");
            OutputSetInfo(values.ToList<string>(), "a-b");

            Response.Write("<br/>");
        }
        void IntersectQuery()
        {
            List<string> dsA = new List<string>();
            List<string> dsB = new List<string>();
            dsA.Add("A");
            dsA.Add("B");
            dsA.Add("B");
            dsA.Add("C");
            dsA.Add("D");
            dsA.Add("D");
            dsA.Add("E");

            dsB.Add("A");
            dsB.Add("C");
            dsB.Add("C");
            dsB.Add("F");
            dsB.Add("H");

            var values = dsA.Intersect (dsB);

            OutputSetInfo(dsA, "a");
            OutputSetInfo(dsB, "b");
            OutputSetInfo(values.ToList<string>(), "a&b");

            Response.Write("<br/>");
        }
        void UnionQuery()
        {
            List<string> dsA = new List<string>();
            List<string> dsB = new List<string>();
            dsA.Add("A");
            dsA.Add("B");
            dsA.Add("B");
            dsA.Add("C");
            dsA.Add("D");
            dsA.Add("D");
            dsA.Add("E");

            dsB.Add("A");
            dsB.Add("C");
            dsB.Add("C");
            dsB.Add("F");
            dsB.Add("H");

            var values = dsA.Union (dsB);

            OutputSetInfo(dsA, "a");
            OutputSetInfo(dsB, "b");
            OutputSetInfo(values.ToList<string>(), "a|b");

            Response.Write("<br/>");
        }
    }
}