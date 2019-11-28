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
	<!-- AJAX -->
	
	<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
		margin: 20px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 70%;
        margin: 20;
        padding: 0;
      }
	th {
		padding: 15px;
		background-color: #7AE1E6;
		color: white;
		border-color: black;
		}
		
	td {
		color: black;
		padding: 5px;
	}
	tr:nth-child(even) {background-color: #d2d2d2;}
	/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
		margin: 20px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 70%;
        margin: 0;
        padding: 0;
      }
	  article {
		  float: left;
		  width: 64%;
	  }

    </style>

</head>

<body style="background-color: #AADAFF">

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
                <a id="a2" class="navbar-brand" href="https://web.ics.purdue.edu/~g1109699/index.php">
                	<span class="glyphicon glyphicon-cloud"></span> 
                	Cair Inc.
                </a>
            </div>
            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav">
                   
                    <li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/Solutions">Solutions</a>
                    </li>
                    <li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/Technology">Technology</a>
                    </li>
					<li class="active">
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/HistoricalData.php">Historical Data</a>
                    </li>
					<li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/MeetTheTeam">Meet The Team</a>
					</li>
                </ul>

            </div>
            <!-- /.navbar-collapse -->
        </div>
		
        <!-- /.container -->
    </nav>
	
	<div class="jumbotron feature" style="background-color:#AADAFF">
		
	
	<table id="mapTable" style="margin-left: 0px;margin-right: 0px;border-bottom-width: 2px">
		<tr>
			<th>
				<!-- <p> --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
				<a id="demo0" class="btn btn-default" value="CLT">Charlotte, NC</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo1" class="btn btn-default" value="IND">Indianapolis, IN</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo2" class="btn btn-default" value="LEX">Lexington, KY</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo3" class="btn btn-default" value="LAX">Los Angeles, CA</a>
				<!-- </p> -->
			</th>
			
			<th>
				<!-- <p> -->
				<a id="demo4" class="btn btn-default" value="LAF">West Lafayette, IN</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo5" class="btn btn-default" value="MEX">Mexico City</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo6" class="btn btn-default" value="NRT">Tokyo</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo7" class="btn btn-default" value="LHR">London</a>
				<!-- </p> -->
			</th>
		</tr>
		<!-- <tr>
			<form action="HistoricalData.php" method="post">
				<input type="submit" class="button" name="city" value="cityLondon">
			</form>
			</tr> -->
	</table>
	</div>
	
	<!-- Heading -->
        <div align="center" class="row">
            <div align="center" class="col-lg-12">
                <h1 align="center" class="page-header">Historical Data
                    <small>Visualize Quality</small>
                </h1>
                <p style="padding-left:20px;padding-right:20px;font-size:125%" align="center"> Our sensors, as seen on the map above, cover the expanse of the area that is designated to them. They work to ensure that no section of the city will be left undiscovered. Our clients can view their sensors individually on the table shown below.</p>
            </div>
        </div>
	
		<article id="map" style="height:700px"></article>
		<article style="float:left;width: 30%;">
		
			<?php 
			$servername = "mydb.itap.purdue.edu";
			$username = "g1109699";
			$password = "MySQL27";
			$dbname = "g1109699";

			// Create connection
			$conn = mysqli_connect($servername, $username, $password, $dbname);

			// Check connection
			if ($conn-> connect_error) {
				die("Connection failed: " . $conn->connect_error);
			}
			
		//	CLT:0	default shown (style='display:BLOCK...)
			$sql = "SELECT aq.S_ID, s.N_ID, ROUND(AVG(pm010),4) AS 'PM_1',
														  ROUND(AVG(pm025),4) AS 'PM_2.5',
														  ROUND(AVG(pm100),4) AS 'PM_10'
					FROM Air_Quality AS aq
					INNER JOIN Sensor AS s ON aq.S_ID = s.S_ID GROUP BY aq.S_ID";
					
			$result = mysqli_query($conn, $sql);
			
			echo "<table border='1' id='tabled0' align='center' style='display:block;width:447.725px;text-align:center;background-color:#D5D8DB'>
			<tr>
			<th>Sensor ID</th>
			<th>Network ID</th>
			<th>Mean PM<sub>1</sub></th>
			<th>Mean PM<sub>2.5</sub></th>
			<th>Mean PM<sub>10</sub></th>
			</tr>";
			
			while($row = mysqli_fetch_array($result))
			{
			echo "<tr>";
			echo "<td>" . $row['S_ID'] . "</td>";
			echo "<td>" . $row['N_ID'] . "</td>";
			echo "<td>" . $row['PM_1'] . "</td>";
			echo "<td>" . $row['PM_2.5'] . "</td>";
			echo "<td>" . $row['PM_10'] . "</td>";
			echo "</tr>";
			}
			echo "</table>";
			
		//	IND:1	default hidden (style='display:NONE...)
			$sql = "SELECT aq.S_ID, s.N_ID, ROUND(AVG(pm010),4) AS 'PM_1',
														  ROUND(AVG(pm025),4) AS 'PM_2.5',
														  ROUND(AVG(pm100),4) AS 'PM_10'
					FROM Air_Quality AS aq
					INNER JOIN Sensor as s ON aq.S_ID = s.S_ID GROUP BY aq.S_ID LIMIT 20";
					
			$result = mysqli_query($conn, $sql);
			
			echo "<table border='1' id='tabled1' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			<tr>
			<th>Sensor ID</th>
			<th>Network ID</th>
			<th>Mean PM<sub>1</sub></th>
			<th>Mean PM<sub>2.5</sub></th>
			<th>Mean PM<sub>10</sub></th>
			</tr>";
			
			while($row = mysqli_fetch_array($result))
			{
			echo "<tr>";
			echo "<td>" . $row['S_ID'] . "</td>";
			echo "<td>" . $row['N_ID'] . "</td>";
			echo "<td>" . $row['PM_1'] . "</td>";
			echo "<td>" . $row['PM_2.5'] . "</td>";
			echo "<td>" . $row['PM_10'] . "</td>";
			echo "</tr>";
			}
			echo "</table>";
			?>
		
		</article>
		<br style="clear:both">
	
	<script>
	
	document.getElementById("demo0").onclick = function(){
		initMap();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "block";
		t1.style.display = "none";
		t2.style.display = "none";
		t3.style.display = "none";
		t4.style.display = "none";
		t5.style.display = "none";
		t6.style.display = "none";
		t7.style.display = "none";
	}
	document.getElementById("demo1").onclick = function(){
		initMap1();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "block";
		t2.style.display = "none";
		t3.style.display = "none";
		t4.style.display = "none";
		t5.style.display = "none";
		t6.style.display = "none";
		t7.style.display = "none";
	}
	document.getElementById("demo2").onclick = function(){
		initMap2();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "none";
		t2.style.display = "block";
		t3.style.display = "none";
		t4.style.display = "none";
		t5.style.display = "none";
		t6.style.display = "none";
		t7.style.display = "none";
	}
	document.getElementById("demo3").onclick = function(){
		initMap3();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "none";
		t2.style.display = "none";
		t3.style.display = "block";
		t4.style.display = "none";
		t5.style.display = "none";
		t6.style.display = "none";
		t7.style.display = "none";
	}
	document.getElementById("demo4").onclick = function(){
		initMap4();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "none";
		t2.style.display = "none";
		t3.style.display = "none";
		t4.style.display = "block";
		t5.style.display = "none";
		t6.style.display = "none";
		t7.style.display = "none";
	}
	document.getElementById("demo5").onclick = function(){
		initMap5();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "none";
		t2.style.display = "none";
		t3.style.display = "none";
		t4.style.display = "none";
		t5.style.display = "block";
		t6.style.display = "none";
		t7.style.display = "none";
	}
	document.getElementById("demo6").onclick = function(){
		initMap6();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "none";
		t2.style.display = "none";
		t3.style.display = "none";
		t4.style.display = "none";
		t5.style.display = "none";
		t6.style.display = "block";
		t7.style.display = "none";
	}
	document.getElementById("demo7").onclick = function(){
		initMap7();
		var t0 = document.getElementById("tabled0");
		var t1 = document.getElementById("tabled1");
		var t2 = document.getElementById("tabled2");
		var t3 = document.getElementById("tabled3");
		var t4 = document.getElementById("tabled4");
		var t5 = document.getElementById("tabled5");
		var t6 = document.getElementById("tabled6");
		var t7 = document.getElementById("tabled7");
		t0.style.display = "none";
		t1.style.display = "none";
		t2.style.display = "none";
		t3.style.display = "none";
		t4.style.display = "none";
		t5.style.display = "none";
		t6.style.display = "none";
		t7.style.display = "block";
	}
	
	var customLabel = {
        fixed: {
          label: 'F'
        },
        mobile: {
          label: 'M'
        }
      };
	  
	  marker.addListener('click', function() {
  infoWindow.setContent(infowincontent);
  infoWindow.open(map, marker);
});

//Charlotte
function initMap() {
		var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(35.2271, -80.8431),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }
	
//Indianapolis
function initMap1() {
		var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(39.7684, -86.1581),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump1.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

//Lexington		
function initMap2() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(38.0406, -84.5037),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump2.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

//Los Angeles
function initMap3() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(34.0522, -118.2437),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump3.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

//West Lafayette
function initMap4() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(40.4259, -86.9081),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump4.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

//Mexico City
function initMap5() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(19.4326, -99.1332),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump5.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

//Tokyo
function initMap6() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(35.6762, 139.6503),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump6.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

//London
function initMap7() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(51.5074, -0.1278),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump7.php', function(data) {
            var xml = data.responseXML;
            var markers = xml.documentElement.getElementsByTagName('marker');
            Array.prototype.forEach.call(markers, function(markerElem) {
              var id = markerElem.getAttribute('id');
              var name = markerElem.getAttribute('name');
              var address = markerElem.getAttribute('address');
              var type = markerElem.getAttribute('type');
              var point = new google.maps.LatLng(
                  parseFloat(markerElem.getAttribute('lat')),
                  parseFloat(markerElem.getAttribute('lng')));

              var infowincontent = document.createElement('div');
              var strong = document.createElement('text');
              strong.textContent = "Sensor ID: " + id
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = "Sensor Type: " + type
              infowincontent.appendChild(text);
              var icon = customLabel[type] || {};
              var marker = new google.maps.Marker({
                map: map,
                position: point,
                label: icon.label
              });
              marker.addListener('click', function() {
                infoWindow.setContent(infowincontent);
                infoWindow.open(map, marker);
              });
            });
          });
        }

function downloadUrl(url,callback) {
 var request = window.ActiveXObject ?
     new ActiveXObject('Microsoft.XMLHTTP') :
     new XMLHttpRequest;

 request.onreadystatechange = function() {
   if (request.readyState == 4) {
     request.onreadystatechange = doNothing;
     callback(request, request.status);
   }
 };

 request.open('GET', url, true);
 request.send(null);
}


function doNothing() {}
    </script>
	
	<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfNAIKeP6ySNvYp2ohmGlpIroJs6aFlxA&callback=initMap">
    </script>

    <!-- Content -->
    <div class="container">

        
        
		<div>

		 <?php 
			// $servername = "mydb.itap.purdue.edu";
			// $username = "g1109699";
			// $password = "MySQL27";
			// $dbname = "g1109699";

			// // Create connection
			// $conn = mysqli_connect($servername, $username, $password, $dbname);

			// // Check connection
			// if ($conn-> connect_error) {
				// die("Connection failed: " . $conn->connect_error);
			// }
			
		// //	CLT:0
			// $sql = "SELECT Air_Quality.S_ID, Sensor.N_ID, ROUND(AVG(pm010),4) AS 'PM_1',
														  // ROUND(AVG(pm025),4) AS 'PM_2.5',
														  // ROUND(AVG(pm100),4) AS 'PM_10'
					// FROM Air_Quality INNER JOIN Sensor ON Air_Quality.S_ID = Sensor.S_ID GROUP BY Air_Quality.S_ID";
					
			// $result = mysqli_query($conn, $sql);
			
			// echo "<table border='1' id='tabled0' align='center' style='display:block;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// while($row = mysqli_fetch_array($result))
			// {
			// echo "<tr>";
			// echo "<td>" . $row['S_ID'] . "</td>";
			// echo "<td>" . $row['N_ID'] . "</td>";
			// echo "<td>" . $row['PM_1'] . "</td>";
			// echo "<td>" . $row['PM_2.5'] . "</td>";
			// echo "<td>" . $row['PM_10'] . "</td>";
			// echo "</tr>";
			// }
			// echo "</table>";
			
		// //	IND:1
			// $sql = "SELECT Air_Quality.S_ID, Sensor.N_ID, ROUND(AVG(pm010),4) AS 'PM_1',
														  // ROUND(AVG(pm025),4) AS 'PM_2.5',
														  // ROUND(AVG(pm100),4) AS 'PM_10'
					// FROM Air_Quality INNER JOIN Sensor ON Air_Quality.S_ID = Sensor.S_ID GROUP BY Air_Quality.S_ID";
					
			// $result = mysqli_query($conn, $sql);
			
			// echo "<table border='1' id='tabled1' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			// while($row = mysqli_fetch_array($result))
			// {
			// echo "<tr>";
			// echo "<td>" . $row['S_ID'] . "</td>";
			// echo "<td>" . $row['N_ID'] . "</td>";
			// echo "<td>" . $row['PM_1'] . "</td>";
			// echo "<td>" . $row['PM_2.5'] . "</td>";
			// echo "<td>" . $row['PM_10'] . "</td>";
			// echo "</tr>";
			// }
			// echo "</table>";
			
			// echo "<table border='1' id='tabled2' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// echo "<table border='1' id='tabled3' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// echo "<table border='1' id='tabled4' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// echo "<table border='1' id='tabled5' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// echo "<table border='1' id='tabled6' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// echo "<table border='1' id='tabled7' align='center' style='display:none;width:447.725px;text-align:center;background-color:#D5D8DB'>
			// <tr>
			// <th>Sensor ID</th>
			// <th>Network ID</th>
			// <th>Mean PM<sub>1</sub></th>
			// <th>Mean PM<sub>2.5</sub></th>
			// <th>Mean PM<sub>10</sub></th>
			// </tr>";
			
			// $conn->close();
			
		// ?>


		</div>
		
    <!-- button 
		<button id="btn2" onclick="hideTable()" align='center'>New Network</button><br></br>
	-->
	<br>
    </div>
    <!-- /.container -->
	
	<footer>
        
        <div class="small-print">
        	<div class="container">
        		<font color="#71c8f4"><p>Terms &amp; Conditions | Privacy Policy | <a href="https://twitter.com/cair_inc">Contact</a></p></font>
        		<p>Copyright &copy; Group 27 2019 </p>
        	</div>
        </div>
	</footer>
	
    <!-- jQuery 
    <script src="js/jquery-1.11.3.min.js"></script>
	-->

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport bug workaround -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
	
	<!-- Placeholder Images -->
	<script src="js/holder.min.js"></script>
	
</body>

</html>
