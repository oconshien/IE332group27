<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>Project Website</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS: You can use this stylesheet to override any Bootstrap styles and/or apply your own styles -->
    <link href="css/custom.css" rel="stylesheet">
	
	<!-- Many users already have downloaded jQuery from Google or Microsoft when visiting another site. As a result, it will be loaded from cache when they visit your site, which leads to faster loading time. Also, most CDN's will make sure that once a user requests a file from it, it will be served from the server closest to them, which also leads to faster loading time.
	Google CDN:	-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

	<style>
	
		th {
			padding: 5px;
		}
	
	</style>
</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Logo and responsive toggle -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="https://web.ics.purdue.edu/~g1109699/index.php">
                	<span class="glyphicon glyphicon-cloud"></span> 
                	Cair Inc.
                </a>
            </div>
            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li  class="active">
                        <a href="https://web.ics.purdue.edu/~g1109699/Solutions.php">Solutions</a>
                    </li>
                    <li>
                        <a href="https://web.ics.purdue.edu/~g1109699/Technology">Technology</a>
                    </li>
					<li>
                        <a href="https://web.ics.purdue.edu/~g1109699/HistoricalData">Historical Data</a>
                    </li>
					<li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/MeetTheTeam">Meet The Team</a>
					</li>
                </ul>

				

            </div>

				

            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

	<div class="jumbotron feature">
		<div class="container">
			
		</div>
	</div>

    <!-- Content -->
    <div class="container">

        <!-- Heading -->
        <div class="row">
            <div  align=center class="col-lg-12">
                <h1 id="SolHead" class="page-header" align=center style="border: 0px solid black;border-bottom-width: 2px;width: 40%;">Client Info
                </h1>
				<h1 align=center>
					<small id="SolSec">Let us help you find the perfect solution</small>
                </h1>
				<p style="padding-left:8%;padding-right:8%;font-size:125%;color: #474747;">Explore the options and packages that we have to offer at Cair Inc. Each one of our solutions is tailored to our clients needs and wants.</p>
            </div>
        </div>
        <!-- /.row -->
	
	<div>
		<div id="myDIV2" class="jumbotron feature" style="color:black;">	
			<form style="text-align:center;color:black;" name="ClientInfo" method="POST" action="PHP2SQL.php" onsubmit="return checkForm(this);">
				<table style="color:black;" align=center>	
					<tr>
						<th>
							<strong>First Name: </strong>
						</th>
						<th>
							<input type="text" size="32" name="FirstName" class="input">
						</th>
					</tr>
					<tr>
						<th>
							<strong>Last Name: </strong>
						</th>
						<th>
						<input type="text" size="32" name="LastName" class="input">
						</th>
					<tr>	
					</tr>
					<tr>	
						<th>
							<strong>Email: </strong>
						</th>
						<th>
							<input type="email" size="32" name="cEmail" class="input">
						</th>
					</tr>
					<tr>	
						<th>
							<strong>Company: </strong>
						</th>
						<th>
							<input type="text" size="32" name="CompanyName" class="input">
						</th>
					</tr>
					<tr>	
						<th>
							<strong>Address: </strong>
						</th>
						<th>
							<input type="text" size="32" name="cAddress" class="input">
						</th>
					</tr>
					<tr>	
						<th>
							<strong>City: </strong>
						</th>
						<th>
							<input type="text" size="32" name="cCity" class="input">
						</th>
					</tr>
					<tr>	
						<th>
							<strong>Postal Code: </strong>
						</th>
						<th>
							<input type="text" size="32" name="cPostalCode" class="input">
						</th>
					</tr>
					<tr>	
						<th>
						<strong>Country: </strong>
						</th>
						<th>
							<select style="width:241px" type="text" name="cCountry" class="input" placeholder="Country">
							<option value="" style="color:gray" selected>Select Country</option>
							<option value="AF">Afghanistan</option>
							<option value="AX">Åland Islands</option>
							<option value="AL">Albania</option>
							<option value="DZ">Algeria</option>
							<option value="AS">American Samoa</option>
							<option value="AD">Andorra</option>
							<option value="AO">Angola</option>
							<option value="AI">Anguilla</option>
							<option value="AQ">Antarctica</option>
							<option value="AG">Antigua and Barbuda</option>
							<option value="AR">Argentina</option>
							<option value="AM">Armenia</option>
							<option value="AW">Aruba</option>
							<option value="AU">Australia</option>
							<option value="AT">Austria</option>
							<option value="AZ">Azerbaijan</option>
							<option value="BS">Bahamas</option>
							<option value="BH">Bahrain</option>
							<option value="BD">Bangladesh</option>
							<option value="BB">Barbados</option>
							<option value="BY">Belarus</option>
							<option value="BE">Belgium</option>
							<option value="BZ">Belize</option>
							<option value="BJ">Benin</option>
							<option value="BM">Bermuda</option>
							<option value="BT">Bhutan</option>
							<option value="BO">Bolivia, Plurinational State of</option>
							<option value="BQ">Bonaire, Sint Eustatius and Saba</option>
							<option value="BA">Bosnia and Herzegovina</option>
							<option value="BW">Botswana</option>
							<option value="BV">Bouvet Island</option>
							<option value="BR">Brazil</option>
							<option value="IO">British Indian Ocean Territory</option>
							<option value="BN">Brunei Darussalam</option>
							<option value="BG">Bulgaria</option>
							<option value="BF">Burkina Faso</option>
							<option value="BI">Burundi</option>
							<option value="KH">Cambodia</option>
							<option value="CM">Cameroon</option>
							<option value="CA">Canada</option>
							<option value="CV">Cape Verde</option>
							<option value="KY">Cayman Islands</option>
							<option value="CF">Central African Republic</option>
							<option value="TD">Chad</option>
							<option value="CL">Chile</option>
							<option value="CN">China</option>
							<option value="CX">Christmas Island</option>
							<option value="CC">Cocos (Keeling) Islands</option>
							<option value="CO">Colombia</option>
							<option value="KM">Comoros</option>
							<option value="CG">Congo</option>
							<option value="CD">Congo, the Democratic Republic of the</option>
							<option value="CK">Cook Islands</option>
							<option value="CR">Costa Rica</option>
							<option value="CI">Côte d'Ivoire</option>
							<option value="HR">Croatia</option>
							<option value="CU">Cuba</option>
							<option value="CW">Curaçao</option>
							<option value="CY">Cyprus</option>
							<option value="CZ">Czech Republic</option>
							<option value="DK">Denmark</option>
							<option value="DJ">Djibouti</option>
							<option value="DM">Dominica</option>
							<option value="DO">Dominican Republic</option>
							<option value="EC">Ecuador</option>
							<option value="EG">Egypt</option>
							<option value="SV">El Salvador</option>
							<option value="GQ">Equatorial Guinea</option>
							<option value="ER">Eritrea</option>
							<option value="EE">Estonia</option>
							<option value="ET">Ethiopia</option>
							<option value="FK">Falkland Islands (Malvinas)</option>
							<option value="FO">Faroe Islands</option>
							<option value="FJ">Fiji</option>
							<option value="FI">Finland</option>
							<option value="FR">France</option>
							<option value="GF">French Guiana</option>
							<option value="PF">French Polynesia</option>
							<option value="TF">French Southern Territories</option>
							<option value="GA">Gabon</option>
							<option value="GM">Gambia</option>
							<option value="GE">Georgia</option>
							<option value="DE">Germany</option>
							<option value="GH">Ghana</option>
							<option value="GI">Gibraltar</option>
							<option value="GR">Greece</option>
							<option value="GL">Greenland</option>
							<option value="GD">Grenada</option>
							<option value="GP">Guadeloupe</option>
							<option value="GU">Guam</option>
							<option value="GT">Guatemala</option>
							<option value="GG">Guernsey</option>
							<option value="GN">Guinea</option>
							<option value="GW">Guinea-Bissau</option>
							<option value="GY">Guyana</option>
							<option value="HT">Haiti</option>
							<option value="HM">Heard Island and McDonald Islands</option>
							<option value="VA">Holy See (Vatican City State)</option>
							<option value="HN">Honduras</option>
							<option value="HK">Hong Kong</option>
							<option value="HU">Hungary</option>
							<option value="IS">Iceland</option>
							<option value="IN">India</option>
							<option value="ID">Indonesia</option>
							<option value="IR">Iran, Islamic Republic of</option>
							<option value="IQ">Iraq</option>
							<option value="IE">Ireland</option>
							<option value="IM">Isle of Man</option>
							<option value="IL">Israel</option>
							<option value="IT">Italy</option>
							<option value="JM">Jamaica</option>
							<option value="JP">Japan</option>
							<option value="JE">Jersey</option>
							<option value="JO">Jordan</option>
							<option value="KZ">Kazakhstan</option>
							<option value="KE">Kenya</option>
							<option value="KI">Kiribati</option>
							<option value="KP">Korea, Democratic People's Republic of</option>
							<option value="KR">Korea, Republic of</option>
							<option value="KW">Kuwait</option>
							<option value="KG">Kyrgyzstan</option>
							<option value="LA">Lao People's Democratic Republic</option>
							<option value="LV">Latvia</option>
							<option value="LB">Lebanon</option>
							<option value="LS">Lesotho</option>
							<option value="LR">Liberia</option>
							<option value="LY">Libya</option>
							<option value="LI">Liechtenstein</option>
							<option value="LT">Lithuania</option>
							<option value="LU">Luxembourg</option>
							<option value="MO">Macao</option>
							<option value="MK">Macedonia, the former Yugoslav Republic of</option>
							<option value="MG">Madagascar</option>
							<option value="MW">Malawi</option>
							<option value="MY">Malaysia</option>
							<option value="MV">Maldives</option>
							<option value="ML">Mali</option>
							<option value="MT">Malta</option>
							<option value="MH">Marshall Islands</option>
							<option value="MQ">Martinique</option>
							<option value="MR">Mauritania</option>
							<option value="MU">Mauritius</option>
							<option value="YT">Mayotte</option>
							<option value="MX">Mexico</option>
							<option value="FM">Micronesia, Federated States of</option>
							<option value="MD">Moldova, Republic of</option>
							<option value="MC">Monaco</option>
							<option value="MN">Mongolia</option>
							<option value="ME">Montenegro</option>
							<option value="MS">Montserrat</option>
							<option value="MA">Morocco</option>
							<option value="MZ">Mozambique</option>
							<option value="MM">Myanmar</option>
							<option value="NA">Namibia</option>
							<option value="NR">Nauru</option>
							<option value="NP">Nepal</option>
							<option value="NL">Netherlands</option>
							<option value="NC">New Caledonia</option>
							<option value="NZ">New Zealand</option>
							<option value="NI">Nicaragua</option>
							<option value="NE">Niger</option>
							<option value="NG">Nigeria</option>
							<option value="NU">Niue</option>
							<option value="NF">Norfolk Island</option>
							<option value="MP">Northern Mariana Islands</option>
							<option value="NO">Norway</option>
							<option value="OM">Oman</option>
							<option value="PK">Pakistan</option>
							<option value="PW">Palau</option>
							<option value="PS">Palestinian Territory, Occupied</option>
							<option value="PA">Panama</option>
							<option value="PG">Papua New Guinea</option>
							<option value="PY">Paraguay</option>
							<option value="PE">Peru</option>
							<option value="PH">Philippines</option>
							<option value="PN">Pitcairn</option>
							<option value="PL">Poland</option>
							<option value="PT">Portugal</option>
							<option value="PR">Puerto Rico</option>
							<option value="QA">Qatar</option>
							<option value="RE">Réunion</option>
							<option value="RO">Romania</option>
							<option value="RU">Russian Federation</option>
							<option value="RW">Rwanda</option>
							<option value="BL">Saint Barthélemy</option>
							<option value="SH">Saint Helena, Ascension and Tristan da Cunha</option>
							<option value="KN">Saint Kitts and Nevis</option>
							<option value="LC">Saint Lucia</option>
							<option value="MF">Saint Martin (French part)</option>
							<option value="PM">Saint Pierre and Miquelon</option>
							<option value="VC">Saint Vincent and the Grenadines</option>
							<option value="WS">Samoa</option>
							<option value="SM">San Marino</option>
							<option value="ST">Sao Tome and Principe</option>
							<option value="SA">Saudi Arabia</option>
							<option value="SN">Senegal</option>
							<option value="RS">Serbia</option>
							<option value="SC">Seychelles</option>
							<option value="SL">Sierra Leone</option>
							<option value="SG">Singapore</option>
							<option value="SX">Sint Maarten (Dutch part)</option>
							<option value="SK">Slovakia</option>
							<option value="SI">Slovenia</option>
							<option value="SB">Solomon Islands</option>
							<option value="SO">Somalia</option>
							<option value="ZA">South Africa</option>
							<option value="GS">South Georgia and the South Sandwich Islands</option>
							<option value="SS">South Sudan</option>
							<option value="ES">Spain</option>
							<option value="LK">Sri Lanka</option>
							<option value="SD">Sudan</option>
							<option value="SR">Suriname</option>
							<option value="SJ">Svalbard and Jan Mayen</option>
							<option value="SZ">Swaziland</option>
							<option value="SE">Sweden</option>
							<option value="CH">Switzerland</option>
							<option value="SY">Syrian Arab Republic</option>
							<option value="TW">Taiwan, Province of China</option>
							<option value="TJ">Tajikistan</option>
							<option value="TZ">Tanzania, United Republic of</option>
							<option value="TH">Thailand</option>
							<option value="TL">Timor-Leste</option>
							<option value="TG">Togo</option>
							<option value="TK">Tokelau</option>
							<option value="TO">Tonga</option>
							<option value="TT">Trinidad and Tobago</option>
							<option value="TN">Tunisia</option>
							<option value="TR">Turkey</option>
							<option value="TM">Turkmenistan</option>
							<option value="TC">Turks and Caicos Islands</option>
							<option value="TV">Tuvalu</option>
							<option value="UG">Uganda</option>
							<option value="UA">Ukraine</option>
							<option value="AE">United Arab Emirates</option>
							<option value="GB">United Kingdom</option>
							<option value="US">United States</option>
							<option value="UM">United States Minor Outlying Islands</option>
							<option value="UY">Uruguay</option>
							<option value="UZ">Uzbekistan</option>
							<option value="VU">Vanuatu</option>
							<option value="VE">Venezuela, Bolivarian Republic of</option>
							<option value="VN">Viet Nam</option>
							<option value="VG">Virgin Islands, British</option>
							<option value="VI">Virgin Islands, U.S.</option>
							<option value="WF">Wallis and Futuna</option>
							<option value="EH">Western Sahara</option>
							<option value="YE">Yemen</option>
							<option value="ZM">Zambia</option>
							<option value="ZW">Zimbabwe</option>
						</select>
						</th>
					</tr>
				
				</table>	<br><br>
					<input type="submit" style="color:black;" value="Create Account"></p>	
			</form>
		</div>
        <!-- Feature Row -->
		
		<div id="myDIV" style="display:none" class="jumbotron feature">
		
			<form style="text-align:center;color:black;" name="netReq" method="POST" action="netReqtoSQL.php" onsubmit="return checkReq(this);">
			<table style="color:black;" align=center>
				<tr>
					<th>
						<strong>Email: </strong><br><font size="1" color="gray">(use the email associated <br> with your account)</font>
					</th>
					<th>
						<input type="email" size="32" name="email" class="input">
					</th>
				</tr>			
				<tr>
					<th>
						<strong>Budget: </strong>
					</th>
					<th>
						<input type="text" size="32" name="budget" class="input">
					</th>
				</tr>
				<tr>
					<th>
						<strong>Radius of Network: </strong><br><font size="1.5" color="gray">(Meters)</font><br>
					</th>
					<th>
						<input type="text" size="32" name="geoRadius" class="input">
					</th>
				<tr>	
				</tr>
				<tr>	
					<th>
						<strong>Simulation Start Date: </strong>
					</th>
					<th>
						<input style="color:gray;" type="date" size="32" name="date" class="input">
					</th>
				</tr>
				<tr>	
					<th>
						<strong>Length of Simulation </strong><br><font size="1.5" color="gray">(Days)</font><br>
					</th>
					<th>
						<input type="text" size="32" name="numDays" class="input">
					</th>
				</tr>
				<tr>	
					<th>
						<strong>Focus: </strong><br><font size="1" color="gray">(Air quality you would <br> like to focus on)</font>
					</th>
					<th>
						<input type="radio" size="32" name="AirPref" value="good" class="input"> Good</input>
						<input type="radio" size="32" name="AirPref" value="bad" class="input"> Bad</input>
					</th>
				</tr>
				<tr>	
					<th>
						<strong>City: </strong>
					</th>
					<th>
						<input type="text" size="32" name="city" class="input">
					</th>
				</tr>
				
				</table>	<br><br>
						<input type="submit" style="color:black;" value="Initialize Network"></p>
			</form>
		</div>
	</div>
	
	<button id="btn1" style="width: 200px;" onclick="hideNetReq()">Already have an Account</button><br></br>	

    </div>
	
	<footer>

        <div class="small-print">
        	<div class="container">
        		<font color="#71c8f4"><p>Terms &amp; Conditions | Privacy Policy | <a href="https://twitter.com/cair_inc">Contact</a></p></font>
        		<p>Copyright &copy; Group 27 2019 </p>
        	</div>
        </div>
	</footer>	

	<script>

	function hideNetReq() {
		var x = document.getElementById("myDIV");
		var y = document.getElementById("myDIV2");
		
		if (x.style.display === "none") {
			x.style.display = "block";
			y.style.display = "none";
			document.getElementById("btn1").innerHTML = "Account Form";
			document.getElementById("SolHead").innerHTML = "Network Info";
			document.getElementById("SolSec").innerHTML = "Let's find a solution that fits your needs";
		} else {
			x.style.display = "none";
			y.style.display = "block";
			document.getElementById("btn1").innerHTML = "Already have an Account";
			document.getElementById("SolHead").innerHTML = "Client Info";
			document.getElementById("SolSec").innerHTML = "Let us help you find the perfect solution";
		}
	}

	function checkForm(form)
	{
	
		var FirstName = document.forms["ClientInfo"]["FirstName"]
		var LastName = document.forms["ClientInfo"]["LastName"]
		var CompanyName = document.forms["ClientInfo"]["CompanyName"]
		var cEmail = document.forms["ClientInfo"]["cEmail"]
		var cPassword = document.forms["ClientInfo"]["cPassword"]
		var cAddress = document.forms["ClientInfo"]["cAddress"]
		var cCity = document.forms["ClientInfo"]["cCity"]
		var cPostalCode = document.forms["ClientInfo"]["cPostalCode"]
		var cCountry = document.forms["ClientInfo"]["cCountry"]
		
		if(!isNaN(FirstName.value)) {
			alert("Please input a valid first name.");
			form.FirstName.focus();
			return false;
		}
		
		if(!isNaN(form.LastName.value)) {
			alert("Please input a valid last name.");
			form.LastName.focus();
			return false;
		}
		
		if(!isNaN(form.CompanyName.value)) {
			alert("Please input a valid Company name.");
			form.CompanyName.focus();
			return false;
		}
		
		if(!isNaN(form.cAddress.value)) {
			alert("Please input a valid address.");
			form.cAddress.focus();
			return false;
		}
		
		if(!isNaN(form.cCity.value)) {
			alert("Please input a valid city.");
			form.cCity.focus();
			return false;
		}
		
		if(isNaN(form.cPostalCode.value)) {
			alert("Please input a valid postal code");
			form.cPostalCode.focus();
			return false;
		}
		
		if(!isNaN(form.cCountry.value)) {
			alert("Please input a valid country name.");
			form.cCountry.focus();
			return false;
		}
		
		alert('Thank you for signing up with Cair Inc! You can now create a network by clicking "Already have an Account"');
		
		
	}
	
	function checkReq(form)
	{
		var budget = document.forms["netReq"]["budget"]
		var geoRadius = document.forms["netReq"]["geoRadius"]
		var date = document.forms["netReq"]["date"]
		var numDays = document.forms["netReq"]["numDays"]
		var AirPref = document.forms["netReq"]["AirPref"]
		var city = document.forms["netReq"]["city"]
		
		var geoRadiusAlert = "Please input a valid radius for your network.\n"
		var geoRadiusDivBy20 = "\n-\tMust be divisible by 20."
		var geoRadiusLower = "\n-\tLower limit is 500 meters."
		var geoRadiusUpper = "\n-\tUpper limit is 15000 meters."

		if(isNaN(form.budget.value)) {
			alert("Please input a valid budget.");
			form.budget.focus();
			return false;
		}
		
		if(!(form.geoRadius.value % 20 === 0 && form.geoRadius.value >= 500 && form.geoRadius.value <= 15000)) {
			if(!(form.geoRadius.value % 20 === 0)) {
				geoRadiusAlert += geoRadiusDivBy20;
			}
			if(!(form.geoRadius.value >= 500)) {
				geoRadiusAlert += geoRadiusLower;
			}
			if(!(form.geoRadius.value <= 15000)) {
				geoRadiusAlert += geoRadiusUpper;
			}
			alert("Please input a valid radius for your network." + geoRadiusAlert);
			form.geoRadius.focus();
			return false;
		}
		
		if(!isNaN(form.date.value)) {
			alert("Please input a valid date.");
			form.date.focus();
			return false;
		}
		
		if(isNaN(form.numDays.value)) {
			alert("Please input a valid amount of days to run the simulation.");
			form.numDays.focus();
			return false;
		}
		
		if(!isNaN(form.city.value)) {
			alert("Please input a valid city to base the sensor network in.");
			form.city.focus();
			return false;
		}
		
		alert('Thank you for creating a network! Please send your zoning .csv file to zoning@cairinc.com. Once we receive that, we will get back to you within 5 business days.');
		
	}

	</script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport bug workaround -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
	
	<!-- Placeholder Images -->
	<script src="js/holder.min.js"></script>
	
</body>

</html>