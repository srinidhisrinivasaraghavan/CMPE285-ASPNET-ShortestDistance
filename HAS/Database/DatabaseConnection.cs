using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using HAS.Models;

namespace HAS.Database
{
    public class DatabaseConnection
    {
        public static String connnectionString = "Data Source=(LocalDB)\\v11.0;AttachDbFilename=C:\\Users\\Srinidhi\\Documents\\Visual Studio 2013\\Projects\\HAS\\HAS\\App_Data\\HAS.mdf;Integrated Security=True;" + "MultipleActiveResultSets = True";
        static SqlConnection con =new SqlConnection(connnectionString);
        SqlCommand cmd;
        public int checkIfUserPresent(String u,String p)
        {
            cmd= new SqlCommand("select * from Users where userName =@uName and password=@pWord", con);
            cmd.Parameters.AddWithValue("@uName", u);
            cmd.Parameters.AddWithValue("@pWord", p);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            con.Open();
            da.Fill(dt);
            SqlDataReader dr = cmd.ExecuteReader();
            dr.Read();
            if (dt.Rows.Count > 0 )
            {
                int uid = (int)dr["userId"];
                dr.Close();
                con.Close();
                return uid;
            }
            else
            {
                dr.Close();
                con.Close();
                return -1;
            }
        }
        public Boolean checkIfAlreadyPresent(String u,String p)
        {
            cmd = new SqlCommand("select * from Users where userName =@userName and password=@password", con);
            cmd.Parameters.AddWithValue("@username", u);
            cmd.Parameters.AddWithValue("@password", p);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            con.Open();
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
        public int registerUser(String u,String n,String p,String m,String e,String a,String addr)
        {
            int userId = getUserId();
            cmd = new SqlCommand("insert into Users values(@userId,@name,@userName,@password,@medicalId,@eContact,@aContact,@address)", con);
            cmd.Parameters.AddWithValue("@userId", userId);
            cmd.Parameters.AddWithValue("@username", u);
            cmd.Parameters.AddWithValue("@name", n);
            cmd.Parameters.AddWithValue("@password", p);
            cmd.Parameters.AddWithValue("@medicalId", m);
            cmd.Parameters.AddWithValue("@eContact", e);
            cmd.Parameters.AddWithValue("@aContact", a);
            cmd.Parameters.AddWithValue("@address", addr);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            return userId;
        }
        protected int getUserId()
        {

            System.Console.WriteLine("connection opened");
            cmd = new SqlCommand("select count(*) from Users", con);
            con.Open();
            int uid = (int)cmd.ExecuteScalar();
            con.Close();
            return ++uid;
        }
        public void updateMedical(int uid,String a,String b,String s)
        { 
            cmd = new SqlCommand();
            cmd.CommandText = "insert into medicalData values (@userId,@allergies,@bloodGroup,@specialCondition)";
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@userId", uid);
            cmd.Parameters.AddWithValue("@allergies", a);
            cmd.Parameters.AddWithValue("@bloodGroup", b);
            cmd.Parameters.AddWithValue("@specialCondition", s);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        public User getContactDetails(int u)
        {
            User user = new User();
            cmd = new SqlCommand("select name,eContact,address,medicalId from Users WHERE userId=@userId", con);
            cmd.Parameters.AddWithValue("@userId", u);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                user.eContact= dr["eContact"].ToString();
                user.address = dr["address"].ToString();
                user.name =dr["name"].ToString();
                user.medicalId= dr["medicalId"].ToString();
            }
            dr.Close();
            con.Close();
            return user;
        }
        public Medical getMedicalDetails(int u)
        {
            Medical medical = new Medical();
            cmd = new SqlCommand("select allergies,bloodGroup,specialCondition from medicalData WHERE userId=@userId", con);
            cmd.Parameters.AddWithValue("@userId", u);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                medical.allergies = dr["allergies"].ToString();
                medical.bloodGroup = dr["bloodGroup"].ToString();
                medical.specialCondition = dr["specialCondition"].ToString();

            }
            dr.Close();
            con.Close();
            return medical;
        }

        public Hospital[] getHospitalDetails()
        {
            Hospital[] hs = new Hospital[9];
            string sql = "select * from Hospital";
            cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            int i = 0;
            while (dr.Read())
            {
                hs[i] = new Hospital();
                hs[i].setName(dr["hName"].ToString());
                hs[i].setEmergency(dr["emergency"].ToString());
                hs[i].setParking(dr["parking"].ToString());
                hs[i].setRating(dr["rating"].ToString());
                hs[i].setServices(dr["services"].ToString());
                hs[i].setPhone(dr["phone"].ToString());
                i++;
            }
            dr.Close();
            con.Close();
            return hs;
        }

    }
}