using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HAS
{
    public class Hospital
    {
        String name, rating, parking, services, emergency, phone;
        public String getName()
        {
            return name;
        }
        public void setName(String n)
        {
            name = n;
        }

        public void setRating(String r)
        {
            rating = r;
        }
        public String getRating()
        {
            return rating;
        }

        public void setParking(String p)
        {
            parking = p;
        }

        public String getParking()
        {
            return parking;
        }

        public void setServices(String s)
        {
            services = s;
        }
        public String getServices()
        {
            return services;
        }
        public void setPhone(String p)
        {
            phone = p;
        }
        public String getPhone()
        {
            return phone;
        }
        public void setEmergency(String e)
        {
            emergency = e;
        }
        public String getEmergency()
        {
            return emergency;
        }
       
    }
    
}