using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using HAS.Database;

namespace HAS
{
    public partial class LoginNew : System.Web.UI.Page
    {
        
        public int userId;
        DatabaseConnection dc = new DatabaseConnection();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void login(object sender, EventArgs e)
        {
            int success = dc.checkIfUserPresent(uName.Text,pWord.Text);
            if (success==-1)
                Response.Redirect("LoginNew.aspx");
            else
            {
                Session.Add("userId", success);
                Response.Redirect("HomeNew.aspx");
            }
        }
        protected void register(object sender, EventArgs e)
        {

            Boolean isPresent = dc.checkIfAlreadyPresent(userName.Text, password.Text);
            if (isPresent)
            {
                Response.Redirect("LoginNew.aspx");
            }
            userId=dc.registerUser(userName.Text, name.Text, password.Text, medicalId.Text, eContact.Text, aContact.Text, address.Text);
            dc.updateMedical(userId,allergies.Text,bloodGroup.Text,specialCondition.Text);
            Session["userId"] = userId;
            Response.Redirect("HomeNew.aspx");
        }  
    }
}