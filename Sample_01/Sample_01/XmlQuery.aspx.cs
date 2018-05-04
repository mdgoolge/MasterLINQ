using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

namespace Sample_01
{
    public partial class XmlQuery : System.Web.UI.Page
    {
        private string xmlString =
           "<Books>"
             + "<Book ID=\"101\">"
                + "<No>00001</No>"
                + "<Name>Book 0001</Name>"
                + "<Price>100</Price>"
                + "<Remark>This is a book 00001.</Remark>"
              + "</Book>"
              + "<Book ID=\"102\">"
                + "<No>00002</No>"
                + "<Name>Book 0002</Name>"
                + "<Price>200</Price>"
                + "<Remark>This is a book 00002.</Remark>"
              + "</Book>"
              + "<Book ID=\"103\">"
                + "<No>0006</No>"
                + "<Name>Book 0006</Name>"
                + "<Price>600</Price>"
                + "<Remark>This is a book 0006.</Remark>"
              + "</Book>"
            + "</Books>";

        protected void Page_Load(object sender, EventArgs e)
        {
            OldQuery();
            LINQQuery();
        }
        private void OldQuery()
        {   ///导入XML文件
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xmlString);
            ///创建查询XML文件的XPath
            string xpath = "/Books/Book";
            ///查询Book元素
            XmlNodeList nodes = xmlDoc.SelectNodes(xpath);
            foreach (XmlNode node in nodes)
            {   ///查询值为“Book 0002”的元素
                foreach (XmlNode sn in node.ChildNodes)
                {   ///如果元素的值为“Book 0002”，则输出其父级元素的属性
                    if (sn.InnerXml == "Book 0002")
                    {
                        Response.Write(node.LocalName + node.Attributes["ID"].Value + "<br />");
                    }
                }
            }
        }

        private void LINQQuery()
        {   ///导入XML文件
            XElement xmlDoc = XElement.Parse(xmlString);
            ///创建查询，并获取名称为“Book 0002”的元素
            var results = from e in xmlDoc.Elements("Book")
                          where (string)e.Element("Name") == "Book 0002"
                          select e;
            ///输出查询结果
            foreach (var xe in results)
            {
                Response.Write(xe.Name.LocalName + xe.Attribute("ID").Value + "<br />");
            }
        }
    }
}