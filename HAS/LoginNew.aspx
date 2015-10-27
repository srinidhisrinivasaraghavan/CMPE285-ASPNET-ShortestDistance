<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginNew.aspx.cs" Inherits="HAS.LoginNew" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <!--Import materialize.css-->
        <!-- <link type="text/css" rel="stylesheet" href="stylesheets/materialize.min.css"  media="screen,projection"/> -->
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Login Page</title>

        <!--  Scripts-->
        <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script src="javascripts/materialize.js"></script>  

        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.96.0/css/materialize.min.css">
        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.96.0/js/materialize.min.js"></script>
    </head>
    <body>
        
        
        <nav class="grey darken-3" role="navigation">
            <div class="nav-wrapper container">
                <a id="logo-container" href="#" class="brand-logo">Welcome to HAS</a>
                <ul class="right hide-on-med-and-down">
                    <li><a onclick="toggleSignUp(this)">Sign Up</a></li>
                </ul>

                <ul id="nav-mobile" class="side-nav" style="left: -250px;">
                    <li><a onclick="toggleSignUp(this)">Sign Up</a></li>
                </ul>
                <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="mdi-navigation-menu"></i></a>
            </div>
        </nav>


        <div class="container">
            <div class="section">
                <div class="row">
                    <form  class="col l12" runat="server">
                    <div id="signInDiv">
                        
                            <h4>Sign In</h4>
                            <div class=" col l12 s12">    
                                <p class=" #424242 grey-text text-darken-3 flow-text">Welcome to Hospital Accessibility System, the bridge between the Care provider and the Care Reciever. Please Sign-in or Sign-up to connect to the Hospitals. For on-the-go accessibility please download our mobile App (curently only available in Android Platform).</p>
                            </div>

                            <div class="input-field col s12"> 
                                <asp:TextBox ID="uName" runat="server" />     
                               <!-- <input id="uName" type="text" class="validate"> -->
                                <label for="uName">User Name</label>
                            </div>
                            <div class="input-field col s12">    
                                <asp:TextBox ID="pWord" Type="password" runat="server" /> 
                                <!-- <input id="pWord" type="password" class="validate"> -->
                                <label for="pWord">Password</label>
                            </div>
                            <div class="input-field col s12 center">          
                                <asp:Button ID="LoginButton" class="btn waves-effect waves-light  grey darken-3" runat="server" Text="Sign In" onclick="login" />
                            </div>    
                        
                    </div>

                    <div id="signUpDiv">
                     
                            <h4>Sign Up</h4>
                            <div class="input-field col s12">    
                                <asp:TextBox ID="name" runat="server" />
                                <label for="name"> Name</label>
                            </div>
                        
                            <div class="input-field col s12">    
                                <asp:TextBox ID="userName" runat="server" />
                                <label for="userName">User Name</label>
                            </div>



                            <div class="input-field col s12">    
                                <asp:TextBox ID="password" runat="server" />
                                <label for="password">Password</label>
                                <!-- <i><img class="circle" src="../public/images/help.jpg" height="20px" weight="20px" onmouseover="showDvHelp();" onmouseout='hideDvHelp();'/> -->
                                <div id="dvHelp" style="display:none; float:right; width:225px"></div>
                                <progress id="pBarPasswordStrength" style="display:none" max="100" value="0"></progress>
                                <label id="lblPasswordStrength" style="float:right"></label></i>
                            </div> 
<!-- 
                            <div class="input-field col s12">    
                                <input id="confirmPassword" type="password" class="validate">
                                <label for="confirmPassword">Confirm Password</label>
                            </div> -->

                            <div class="input-field col s12">    
                                <asp:TextBox ID="medicalId" runat="server" />
                                <label for="medicalId">Medical ID</label>
                            </div>

                            <div class="input-field col s12">    
                                <asp:TextBox ID="eContact" runat="server" />
                                <label for="eContact">Emergency Contact Number</label>
                            </div>

                            <div class="input-field col s12">    
                                <asp:TextBox ID="aContact" runat="server" />
                                <label for="aContact">Alternate Contact Number</label>
                            </div>

                            <div class="input-field col s12">    
                                <asp:TextBox ID="address" runat="server" />
                                <label for="address">Address</label>
                            </div>

                        <div class="input-field col s12">    
                                <asp:TextBox ID="bloodGroup" runat="server" />
                                <label for="bloodGroup">Blood Group</label>
                            </div>

                        <div class="input-field col s12">    
                                <asp:TextBox ID="allergies" runat="server" />
                                <label for="allergies">Allergies</label>
                            </div>

                        <div class="input-field col s12">    
                                <asp:TextBox ID="specialCondition" runat="server" />
                                <label for="specialCondition">Special Condition</label>
                            </div>

                            <div class="input-field col s12 center"><!-- 
    <button class="btn waves-effect waves-light  grey darken-3" type="submit" name="action">Sign Up
    </button> -->
                                <asp:Button ID="RegisterButton" class="btn waves-effect waves-light  grey darken-3" runat="server" Text="Register" onclick="register" />
                           
                                  </div>
                      
                </div>
                        </form>

            </div>

            <!--   Icon Section   -->
        </div>
        <br><br>

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
            $('#signUpDiv').hide();
        });

       
        function toggleSignUp(element){
            $('#signInDiv').toggle(); 
            $('#signUpDiv').toggle();
            console.log($(element).html());
            if(($(element).html()) == 'Sign Up'){
                console.log('true');
                $(element).html('Sign In');
            }
            else{
                $(element).html('Sign Up');
            }
        }
    </script>
      

    </body>
</html>