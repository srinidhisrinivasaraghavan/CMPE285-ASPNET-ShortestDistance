<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomeNew.aspx.cs" Inherits="HAS.HomeNew" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <!--Import materialize.css-->
       <!--  <link type="text/css" rel="stylesheet" href="stylesheets/materialize.min.css"  media="screen,projection"/> -->
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Home Page</title>
        <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">


        <!--  Scripts-->
       <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>-->
        <script src="javascripts/materialize.js"></script>  

        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.96.0/css/materialize.min.css">
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.96.0/js/materialize.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        

         <style>


      #showHospitalDiv {
        height:500px;
        width:800px;

      }
        #findNearestHospitalDiv {
        height:500px;
        width:800px;

      }
         #haversineDiv {
        height:500px;
        width:800px;

      }
    </style>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
        <script>
            var map;
            var locations;
      function initialize() {
        var mapCanvas = document.getElementById('showHospitalDiv');
        var mapOptions = {
            center: new google.maps.LatLng(37.3894, -122.0819),
          zoom: 12,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
       locations = [
['Childrens Recovery Center of Northern California - Campbell ', 37.2597000000, -121.9476000000],
['Santa Clara Valley Medical Center - San Jose', 37.3127695000, -121.9326500000],
['El Camino Hospital - Mountain View', 37.3690000000, -122.0800000000],
['Good Samaritan Hospital-San Jose', 37.2511920000, -121.9468210000],
[' Kaiser Fnd Hosp - San Jose', 37.2401133000, -121.8010205000],
['Kaiser Permanente P.H.F - Santa Clara', 37.3363342000, -121.9974591000],
[' Mission Oaks Hospital - Los Gatos ', 37.2441667000, -121.9483333000],
['O connor Hospital - San Jose - San Jose', 37.3279554000, -121.9382142000],
['Regional Medical of San Jose', 37.3617800, -121.8491700]

       ];
        map = new google.maps.Map(mapCanvas, mapOptions);
        var infowindow = new google.maps.InfoWindow({});
        var marker,contentString,infoWindow;
   
        for (var i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                map: map,
                
            });
           
            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    var content='<div class = "MarkerPopUp" style="width: 200px;"><div class = "MarkerContext">'+'<p><center>'+locations[i][0]+'</center>'+'<br>'+' '+'</p>'+'</div></div>';
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }
            
        
      
      }              
      
      google.maps.event.addDomListener(window, 'load', initialize);
//      google.maps.event.trigger(map, 'resize');

      
      var directionsDisplay;
      var directionsService = new google.maps.DirectionsService();
      var map2;
      var pos;

      function initialize2() {
          directionsDisplay = new google.maps.DirectionsRenderer();
          var mapOptions = {
              zoom: 0
          };
          map2 = new google.maps.Map(document.getElementById('findNearestHospitalDiv'),
              mapOptions);
  
          directionsDisplay.setMap(map2);

          // Try HTML5 geolocation
          if(navigator.geolocation) {
              navigator.geolocation.getCurrentPosition(function(position) {
                  pos = new google.maps.LatLng(position.coords.latitude,
                                                     position.coords.longitude);
                  console.log(pos);

                  var infowindow = new google.maps.InfoWindow({
                      map: map2,
                      position: pos,
                      content: 'Location found.'
                  });

                  map2.setCenter(pos);
              }, function() {
                  handleNoGeolocation(true);
              });
          } else {
              // Browser doesn't support Geolocation
              handleNoGeolocation(false);
          }
      }

      function handleNoGeolocation(errorFlag) {
          if (errorFlag) {
              var content = 'Error: The Geolocation service failed.';
          } else {
              var content = 'Error: Your browser doesn\'t support geolocation.';
          }

          var options = {
              map: map2,
              position: new google.maps.LatLng(60, 105)
              
          };

          var infowindow = new google.maps.InfoWindow(options);
          map2.setCenter(options.position);
      }



      var distances=[];
      function distance1() {
         
          var i,endMin;
          for ( i = 0; i < locations.length; i++) {

              end = new google.maps.LatLng(locations[i][1], locations[i][2]);

              var request1 = {
                  origin: pos,
                  destination: end,
                  travelMode: google.maps.TravelMode.DRIVING
                  
              };
              

              directionsService.route(request1, function (response, status) {
                  if (status == google.maps.DirectionsStatus.OK) {
                     // var time=response.routes[0].legs[0].DirectionsRenderer.
                      var temp = response.routes[0].legs[0].distance.value / 1000;
                      var time = response.routes[0].legs[0].duration.value / 60;
                      var dest = response.routes[0].legs[0].end_address;
                      console.log(dest);
                      
                      if (distances.length == 0) {
                          min = time;
                          endMin = end;
                          dest = response.routes[0].legs[0].end_address;
                      }
                      else if (time < min)
                      {
                          min = time;
                          endMin = end;
                          dest = response.routes[0].legs[0].end_address;

                      }

                      distances.push(time);
                      
                      if (distances.length == locations.length) {
                        console.log("min time in distance function " + min + " endMin " + endMin +"dest "+dest);
                        calcRoute(endMin);

                      }
                      
                      
                  }
                  else {
                     console.log(status);
                     console.log("crazy");
                 }

              });
             
          }
      
      }

     







          function calcRoute(endMin) {
              // var start = document.getEleme9ntById('start').value;
              //var end = new google.maps.LatLng(37.3690000000, -122.0800000000);
             // console.log("inside calculate");
              this.end = endMin;
             
              var request = {
                  origin: pos,
                  destination: end,
                  travelMode: google.maps.TravelMode.DRIVING
                 
              };
              console.log("*******************"+pos+"*******"+endMin)
              //console.log(request);
              directionsService.route(request, function (response, status) {
                  if (status == google.maps.DirectionsStatus.OK) {
                      
                      console.log("time in route function "+response.routes[0].legs[0].duration.value / 60);

                      directionsDisplay.setDirections(response);
                      console.log("printed");
                  }
                  else {
                      console.log("status wrong" + status);
                  }
              });
          }




      
          google.maps.event.addDomListener(window, 'click', function () { map2.setZoom(13); map2.setCenter(pos); });
          google.maps.event.addDomListener(window, 'load', initialize2);

          function toRad (x) {
              return x * Math.PI / 180;
          }

          var directionsDisplay2 = new google.maps.DirectionsRenderer();;
          var directionsService2 = new google.maps.DirectionsService();
          function calcRoute2(endMin) {
              
              this.end = endMin;

              var request = {
                  origin: pos,
                  destination: end,
                  travelMode: google.maps.TravelMode.DRIVING

              };
             
             
              directionsService2.route(request, function (response, status) {
                  if (status == google.maps.DirectionsStatus.OK) {

                      console.log("time in route function " + response.routes[0].legs[0].duration.value / 60);

                      directionsDisplay2.setDirections(response);
                     
                  }
                  else {
                      console.log("status wrong" + status);
                  }
              });
          }


          var map3, pos1, posLat, posLon;
  
          function initialize3() {
              var mapCanvas = document.getElementById('haversineDiv');
              var mapOptions = {
                  center: new google.maps.LatLng(37.3894, -122.0819),
                  zoom: 12,
                  mapTypeId: google.maps.MapTypeId.ROADMAP
              }
              map3 = new google.maps.Map(mapCanvas, mapOptions);
              
              directionsDisplay2.setMap(map3);

              if (navigator.geolocation) {
                  navigator.geolocation.getCurrentPosition(function (position) {
                      pos1 = new google.maps.LatLng(position.coords.latitude,
                                                         position.coords.longitude);
                      posLat = position.coords.latitude;
                      posLon = position.coords.longitude;
                      console.log("pos1" + posLat + "           " + posLon);
                      

                      var infowindow = new google.maps.InfoWindow({
                          map: map3,
                          position: pos1,
                          content: 'Location found.'
                      });

                      map3.setCenter(pos1);
                  }, function () {
                     // handleNoGeolocation(true);
                  });
              } 
          }
          google.maps.event.addDomListener(window, 'click', function () { map3.setZoom(13); map3.setCenter(pos); });
          google.maps.event.addDomListener(window, 'load', initialize3);

          var hDistances=[];   
          function haversine() {
              console.log("reacihng haversine");
              var lat1 = posLat;
              var lon1 = posLon;
              console.log("lat1 " + lat1 + "lon1 " + lon1);
              var R = 6371;
              for (i = 0; i < locations.length; i++) {
                  var lat2 = locations[i][1];
                  var lon2 = locations[i][2];
                  console.log("lon2 " + lon2 + "lat2 " + lat2);



                  var x1 = lat2 - lat1;
                  var dLat = toRad(x1);
                  var x2 = lon2 - lon1;
                  var dLon = toRad(x2);
                  var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                              Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
                              Math.sin(dLon / 2) * Math.sin(dLon / 2);
                  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                  var temp1 = R * c;
                  console.log("dist" + temp1);

                  if (hDistances.length == 0) {
                      min1 = temp1;
                      minLat = lat2;
                      minLon = lon2;

                  }
                  else if (temp1 < min1) {
                      min1 = temp1;
                      minLat = lat2;
                      minLon = lon2;

                  }
                  hDistances.push(temp1);
                  if (hDistances.length == locations.length) {
                      console.log("min dist in haver distance function " + min1);
                      endMin1 = new google.maps.LatLng(minLat, minLon);
                      console.log("endMin1 "+endMin1)
                      calcRoute2(endMin1);

                  }




              }
          }











    </script>

   
    </head>
    <body>

        <nav class="grey darken-3" role="navigation">
            <div class="nav-wrapper container" >
                <a id="logo-container" href="#" class="brand-logo">Welcome to HAS</a>
                <ul class="right hide-on-med-and-down">
                    
                        
                        <li><a onclick="logout(this)">Log out</a></li> 
                </ul>

               <!--  <ul id="nav-mobile" class="side-nav" style="left: -250px;">
                    <li><a onclick="toggleSignUp(this)">Sign Up</a></li>
                </ul> -->
                <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="mdi-navigation-menu"></i></a>
            </div>
        </nav>
<div class="parallax-container">
            <div class="parallax"><img src="https://licensing.jamendo.com/images/heroes/licensing/in-store-wellness-hospital.jpg?version=3"></div>
        </div> 
<div class="row">

            <div class="col l2 s12">
                <ul class="grey darken-3 collapsible collapsible-accordion">
                    <li class="bold"><a  class="collapsible-header waves-effect  waves-green grey-text text-darken-3" onclick="toggleaboutHasDiv(this)">About HAS</a></li>
                    <li class="bold"><a class="collapsible-header  waves-effect waves-green grey-text text-darken-3" onclick="togglehospitalDetailsDiv(this)">Hospitals Details</a> </li>                   
                    <li class="bold"><a class="collapsible-header  waves-effect waves-green grey-text text-darken-3" onclick="toggleshowHospitalDiv(this)">Show Hospitals in Map</a> </li>
                    <li class="bold"><a class="collapsible-header  waves-effect waves-green grey-text text-darken-3" >Find Nearest Hospital</a>
                    <div class="collapsible-body">
                        <ul>
                            <li ><a  class="collapsible-header waves-effect  waves-green grey-text text-darken-3" onclick="togglefindNearestHospitalDiv(this)">Trust Google</a></li>
                            <li ><a  class="collapsible-header waves-effect  waves-green grey-text text-darken-3" onclick="togglehaversineDiv(this)">Try Us !!</a></li>
                        </ul>
                    </div></li>
                    <li class="bold"><a  class=" collapsible-header waves-effect waves-green grey-text text-darken-3" onclick="togglemedicalDetailsDiv(this)">Medical Details</a></li>
                    <li class="bold"><a  class=" collapsible-header waves-effect waves-green grey-text text-darken-3" onclick="togglecontactDetailsDiv(this)">Contact Details</a></li>   
                    <li class="bold"><a onclick="togglecontactUsDiv(this)" class=" collapsible-header waves-effect waves-green grey-text text-darken-3">Contact Us</a></li>  
                </ul>
        </div>

<div class="col l10 s12">
        <div class="container">
            <div class="section">
                <div class="row">
                    <div id="contactUsDiv">

                            <table class="bordered hoverable "> 
                                <thead>
                                  <tr>
                                      <th data-field="id">Name</th>
                                      <th data-field="name">Email ID</th>
                                      <th data-field="phone">Phone Number</th>
                                  </tr>
                                </thead>

                                <tbody>
                                  <tr>
                                    <td>Akilesh Mani</td>
                                    <td>akilesh.mani@sjsu.edu</td>
                                    <td>334455667</td>
                                  </tr>
                                  <tr>
                                    <td>Srinidhi Srinivasa Raghavan</td>
                                    <td>srinidhi.srinivasaraghavan@sjsu.edu</td>
                                    <td>334455667</td>
                                  </tr>
                                  <tr>
                                    <td>Sreenivasan Gajapathy</td>
                                    <td>sreenivasan.gajapathy@sjsu.edu</td>
                                    <td>334455667</td>
                                  </tr>
                                  <tr>
                                    <td>Tania Chanda</td>
                                    <td>tania.chanda@sjsu.edu</td>
                                    <td>334455667</td>
                                  </tr>
                                </tbody>
                            </table>
                    </div>

                    <div id="aboutHasDiv">

                        <div class=" col l12 s12">    
                                <p class=" #424242 grey-text text-darken-3 flow-text">Welcome to Hospital Accessibility System, the bridge between the Care provider and the Care Reciever. Please Sign-in or Sign-up to connect to the Hospitals. For on-the-go accessibility please download our mobile App (curently only available in Android Platform). The information presented here will guide you through the hospital and directs you to available resources and facilities to help you plan your visit.</p>
                        </div>

                    </div>

                    <div id="hospitalDetailsDiv">
                        <table class="bordered hoverable "> 
                                <thead>
                                  <tr>
                                      <th data-field="id">Name</th>
                                      <th data-field="name">Phone Number</th>
                                      <th data-field="phone">Parking</th>
                                      <th data-field="phone">Rating</th>
                                      <th data-field="phone">Emergency</th>
                                      <th data-field="phone">Speciality Services</th>

                                  </tr>

                                    
                                </thead>


                                <tbody>
                                     <% for (int i=0; i<hs.Length; i++) {%>
                                  <tr>
                                      <td><%=hs[i].getName() %></td>
                                      <td><%=hs[i].getPhone() %></td>
                                      <td><%=hs[i].getParking() %></td>
                                      <td><%=hs[i].getRating() %></td>
                                      <td><%=hs[i].getEmergency() %></td>
                                      <td><%=hs[i].getServices() %></td>
                                  </tr> 
                                   <%} %>
                                        
                                </tbody>
                        </table>

            


                    </div> 

                    <div id="showHospitalDiv">
                    
                    </div>
                    <div id="findNearestHospitalDiv" >

                    </div>
                    <div id="haversineDiv" >

                    </div>
                    <div id="medicalDetailsDiv">
                        <table class="bordered hoverable " id= "medicalD"> 
                                <thead>
                                  <tr>
                                      <th data-field="id">Name</th>
                                      <th data-field="name">Medical ID</th>
                                      <th data-field="phone">Blood Group</th>
                                      <th data-field="phone">Allergies</th>
                                      
                                      <th data-field="phone">Special Condition</th>

                                  </tr>
                                  
                                </thead>

                                <tbody>
                                    <tr>
                                      <td data-field="name"><%=nameC%></td>
                                      <td data-field="medicalId"><%=medicalIdC %></td>
                                      <td data-field="bloodGroup"><%=bloodGroupC %></td>
                                      <td data-field="allergies"><%=allergiesC%></td>
                                      
                                      <td data-field="specialCondition"><%=specialConditionC%></td>

                                  </tr>
                                </tbody>
                        </table>


                        <!-- Modal Structure -->
                        <div id="medicalDetailsModal" class="modal fade" role="dialog"  aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <div class="modal-header">
                                        <h4 class="modal-title center"  id="itemDetails-header">Medical Details</h4>
                                    </div>

                                    <div class="modal-body">
                                        <div class="container-fluid">
                                            <div class="row">
                                                <form class="col-lg-12 col-md-12 col-sm-12" runat="server">
                                                    
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <span class="">Medical Id</span>
                                                            
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <asp:TextBox ID="medicalId" runat="server" />
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <span class="">Blood Group</span>
                                                           
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <asp:TextBox ID="bloodGroup" runat="server" />
                                                        </div>
                                                    </div>
                                                
                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <span class="">Allergies</span>
                                                           
                                                        </div>
                                                        <div class="col-sm-10">
                                                            <asp:TextBox ID="allergies" runat="server" />

                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-sm-2">
                                                            <span class="">Special Condition </span>
                                                            
                                                        </div>
                                                        <div class="col-sm-10">
                                                           <asp:TextBox ID="specialCondition" runat="server" />
                                                        </div>
                                                        
                                                    </div>
                                                     <div class="modal-footer">
                                                    <asp:Button ID="UpdateButton" class="waves-effect waves-light btn blue lighten-1" runat="server" Text="update" onclick="updateMedicalDetails" />
                                         
                                                    <a class="waves-effect waves-light btn black lighten-3" data-dismiss="modal" aria-label="Close">Close</a>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                   
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>


                    </div>

                    <div id="contactDetailsDiv">
                        <table class="bordered hoverable "> 
                                <thead>
                                  <tr>
                                      <th data-field="id">Name</th>
                                      <th data-field="name">Address</th>
                                      <th data-field="phone">Emergency contact number</th>
                                  </tr>

                              
                                </thead>

                                <tbody>
                                  
                 <!--                  Do not remove! Dynamically adding data. -->
                                    <tr>
                                      <td data-field="id"><%=nameC %></td>
                                      <td data-field="name"><%=addressC %></td>
                                      <td data-field="phone"><%=eContactC %></td>
                                  </tr>
                                 
                                </tbody>
                            </table>
                           

                        

                    </div>


            </div>
               

            <!--   Icon Section   -->
        </div>
        <br><br>

        </div>
    </div>

</div>
<div class="parallax-container">
            <div class="parallax"><img src="http://washington.providence.org/~/media/images/providence/global/hero%20panel/hero%20images/wa_spokane_sacredheartchildrenshospital_hospital_home_hero.jpg/?h=394&w=934"></div>
</div>
    <footer class="page-footer grey darken-3">

        <div class="container">
            <div class="row">
                <div class="col l8">
                   <!--  <h5 class="white-text">TEAM 02</h5> -->
                    <p class="grey-text text-lighten-4">We are a team of college students working on this project like it's our full time job. Any amount would help support and continue development on this project and is greatly appreciated.</p>
                </div>
                <div class="col l4">
                    <h5 class="white-text">TEAM 02</h5>
                 <!--    <h6 class="white-text">Team Members</h6> -->
                  <!--   <p class="grey-text text-lighten-4">Akilesh Mani, Srinidhi Srinivasa Raghavan, Sreenivasan Gajapathy, Tania Chanda. </p> -->

                    <ul>
                        <li><a class="white-text" href="#!">Akilesh Mani</a></li>
                        <li><a class="white-text" href="#!">Srinidhi Srinivasa Raghavan</a></li>
                        <li><a class="white-text" href="#!">Sreenivasan Gajapathy</a></li>
                        <li><a class="white-text" href="#!">Tania Chanda</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </footer>



    <script>
        $(document).ready(function(){
            // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
            $('#contactUsDiv').hide();
            //$('#aboutHasDiv').show();
            $('#showHospitalDiv').hide();
            $('#medicalDetailsDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#findNearestHospitalDiv').hide();
            $('.parallax').parallax(); //added this line
            $("#hospitalDetailsDiv").hide();//here
            $('#haversineDiv').hide();

        });

        function togglecontactUsDiv(element){
            $('#contactUsDiv').toggle(); 
            $('#medicalDetailsDiv').hide();
            $('#haversineDiv').hide();
            $('#aboutHasDiv').hide();
            $('#showHospitalDiv').hide();
            $('#contactDetailsDiv').hide();
            $("#hospitalDetailsDiv").hide();//here
            $('#findNearestHospitalDiv').hide();
            // $('#signUpDiv').toggle();
            console.log($(element).html());
           
        }

        function toggleaboutHasDiv(element){
            $('#aboutHasDiv').toggle(); 
            $('#showHospitalDiv').hide();
            $('#medicalDetailsDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#findNearestHospitalDiv').hide();
            $("#hospitalDetailsDiv").hide();//here
            // $('#signUpDiv').toggle();
            $('#haversineDiv').hide();
            $('#contactUsDiv').hide();
           
        }

        function toggleshowHospitalDiv(element){
            $('#showHospitalDiv').toggle(); 
            $('#contactUsDiv').hide(); 
            $('#aboutHasDiv').hide();   
            $('#medicalDetailsDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#findNearestHospitalDiv').hide();
            $("#hospitalDetailsDiv").hide();//here
            $('#haversineDiv').hide();
            //console.log("cant show map");
            $('#showHospitalDiv').mouseover(function () { google.maps.event.trigger(map, "resize"); });
           
        }
        function togglefindNearestHospitalDiv(element) {
            $('#findNearestHospitalDiv').toggle();
            $('#contactUsDiv').hide();
            $('#aboutHasDiv').hide();
            $('#medicalDetailsDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#showHospitalDiv').hide();
            $("#hospitalDetailsDiv").hide();//here
            $('#haversineDiv').hide();
            //console.log("cant show map");
            $('#findNearestHospitalDiv').mouseover(function () { google.maps.event.trigger(map2, "resize"); });
            $('#findNearestHospitalDiv').click(distance1());

        }

        function togglehaversineDiv(element) {
            $('#haversineDiv').toggle();
            $('#contactUsDiv').hide();
            $('#aboutHasDiv').hide();
            $('#medicalDetailsDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#showHospitalDiv').hide();
            $("#hospitalDetailsDiv").hide();
            $('#findNearestHospitalDiv').hide();
            $('#haversineDiv').mouseover(function () { google.maps.event.trigger(map3, "resize"); });
            $('#haversineDiv').click(haversine());

        }

        function togglemedicalDetailsDiv(element){
            $('#medicalDetailsDiv').toggle(); 
            $('#contactUsDiv').hide(); 
            $('#aboutHasDiv').hide();
            $('#showHospitalDiv').hide(); 
            $('#haversineDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#findNearestHospitalDiv').hide();
            $("#hospitalDetailsDiv").hide();//here
            // $('#medicalDetailsModal').modal('show');
        }

        function togglehospitalDetailsDiv(element) {
            $("#hospitalDetailsDiv").toggle();
            $('#contactUsDiv').hide();
            $('#medicalDetailsDiv').hide();
            $('#aboutHasDiv').hide();
            $('#showHospitalDiv').hide();
            $('#contactDetailsDiv').hide();
            $('#haversineDiv').hide();
            //console.log($(element).html());

        }
       
        function togglecontactDetailsDiv(element){
            $('#contactDetailsDiv').toggle(); 
            $('#medicalDetailsDiv').hide(); 
            $('#contactUsDiv').hide(); 
            $('#aboutHasDiv').hide();
            $('#showHospitalDiv').hide();
            $("#hospitalDetailsDiv").hide();//here
            $('#findNearestHospitalDiv').hide();
            $('#haversineDiv').hide();
        }
        function openModal() {
            console.log("reaching to open");
            //$('#medicalDetailsModal').show();
            $('#medicalDetailsModal').show();
            console.log("reaching to end");
        }
        function closeModal() {
            $('#medicalDetailsDiv').find('#medicalDetailsModal').hide();
        }

        
        function logout()
        {
          
            self.location="LoginNew.aspx";
        }
     
    </script>

    </body>
</html>
