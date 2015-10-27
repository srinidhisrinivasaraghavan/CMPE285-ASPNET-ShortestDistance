using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HAS.Database;
using HAS.Models;



namespace HAS
{
    public partial class HomeNew : System.Web.UI.Page
    {    
        public int userId;
        public User user;
        public Medical medical;
        public static Hospital[] hs = new Hospital[9];
        DatabaseConnection dc = new DatabaseConnection();
        public String eContactC, nameC, addressC,medicalIdC,allergiesC,bloodGroupC,specialConditionC;
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
            if (!IsPostBack)
            {
                userId = (int)Session["userId"];
                user = dc.getContactDetails(userId);
                eContactC = user.eContact;
                nameC = user.name;
                addressC = user.address;
                medicalIdC = user.medicalId;

                medical = dc.getMedicalDetails(userId);
                allergiesC = medical.allergies;
                bloodGroupC = medical.bloodGroup;
                specialConditionC = medical.specialCondition;


                hs = dc.getHospitalDetails();
                
            }
        }
        protected void updateMedicalDetails(object sender, EventArgs e)
        {
           userId = (int)Session["userId"];
           dc.updateMedical(userId, allergies.Text, bloodGroup.Text, specialCondition.Text);
           Response.Redirect("HomeNew.aspx");
        }  
    }
}