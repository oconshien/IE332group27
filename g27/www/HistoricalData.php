<!DOCTYPE html>
<!-- Template by Quackit.com -->
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
	<script>
	$(document).ready(function()	{
		$('.button').click(function()	{
			alert("City: " + $(this).val());
		$('.btn btn-default').click(function()	{
			var clickBtnValue = $(this).val();
			var ajaxurl = 'HistAjax.php',
				data = {'action': clickBtnValue};
			$.post(ajaxurl, data, function (response) {
					alert("ajax worked");
			});
		});
	};
	</script>
	<script>
	function showUser(str) {
		if(str == "") {
			document.getElementById("txtHint").innerHTML = "";
			return;
		} else {
			if (window.XMLHttpRequest) {
				// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {
				// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					document.getElementById("txtHint").innerHTML = this.responseText;
				}
			};
			xmlhttp.open("GET","getuser.php?q="+str,true);
			xmlhttp.send();
		}
	}
	</script>
	
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
    </style>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

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
                	Group 27
                </a>
            </div>
            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/index.php">Home</a>
                    </li>
                    <li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/Solutions">Solutions</a>
                    </li>
                    <li>
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/Technology">Technology</a>
                    </li>
					<li class="active">
                        <a id="a2" href="https://web.ics.purdue.edu/~g1109699/HistoricalData.php">Historical Data</a>
                    </li>
					<li class="dropdown">
						<a id="a2" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Meet the Team <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="about-us">
							<li><a href="https://web.ics.purdue.edu/~g1109699/hicks88Page">Will Hicks</a></li>
							<li><a href="https://web.ics.purdue.edu/~g1109699/jfinucanePage">Jeff Finucane</a></li>
							<li><a href="https://web.ics.purdue.edu/~g1109699/lroachPage">Laura Roach</a></li>
							<li><a href="https://web.ics.purdue.edu/~g1109699/tboggsPage">Truman Boggs</a></li>
							<li><a href="https://web.ics.purdue.edu/~g1109699/jvaldezPage">Jorge Valdez</a></li>
							<li><a href="https://web.ics.purdue.edu/~g1109699/gharoldPage">Giovanni Harold</a></li>
						</ul>
					</li>
                </ul>

            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

	<div class="jumbotron feature">
		<div class="container">
		</div>
	</div>
	
	<button type="button" class="btn btn-default" value="cityname">TEST</button>

	<form>
		<select name="users" onchange="showUser(this.value)">
			<option value="">Select a person:</option>
			<option value="1">Peter Griffin</option>
			<option value="2">Lois Griffin</option>
			<option value="3">Joseph Swanson</option>
			<option value="4">Glenn Quagmire</option>
		</select>
	</form>

<br>
<div id="txtHint"><b>Person info will be listed here...</b></div>

	
	<table id="mapTable">
		<tr>
			<th>
				<!-- <p> -->
				<a id="demo0" class="btn btn-default" value="sydney">Sydney</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo1" class="btn btn-default" value="chicago">Chicago</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo2" class="btn btn-default" value="london">London</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo3" class="btn btn-default">Tokyo</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo4" class="btn btn-default">Paris</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo5" class="btn btn-default">Rome</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo6" class="btn btn-default">Dubai</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo7" class="btn btn-default">Cape Town</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo8" class="btn btn-default">Los Angeles</a>
				<!-- </p> -->
			</th>
			<th>
				<!-- <p> -->
				<a id="demo9" class="btn btn-default">West Lafayette</a>
				<!-- </p> -->
			</th>
		</tr>
		<!-- <tr>
			<form action="HistoricalData.php" method="post">
				<input type="submit" class="button" name="city" value="cityLondon">
			</form>
			</tr> -->
	</table>
	
		<div id="map"></div>
	
	<script>
	
	document.getElementById("demo0").onclick = function(){
		initMap();
	}
	document.getElementById("demo1").onclick = function(){
		initMap1();
	}
	document.getElementById("demo2").onclick = function(){
		initMap2();
	}
	document.getElementById("demo3").onclick = function(){
		initMap3();
	}
	document.getElementById("demo4").onclick = function(){
		initMap4();
	}
	document.getElementById("demo5").onclick = function(){
		initMap5();
	}
	document.getElementById("demo6").onclick = function(){
		initMap6();
	}
	document.getElementById("demo7").onclick = function(){
		initMap7();
	}
	document.getElementById("demo8").onclick = function(){
		initMap8();
	}
	document.getElementById("demo9").onclick = function(){
		initMap9();
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

//Sydney
function initMap() {
		var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(-33.863276, 151.207977),
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
	
// Chicago Initialize and add the map
function initMap1() {
		var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(41.869361, -87.660712),
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
//London		
function initMap2() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(51.507489, -0.127957),
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
//Tokyo	
function initMap3() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(35.680553, 139.769253),
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
//Paris
function initMap4() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(48.8566, 2.3522),
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
//Rome
function initMap5() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(41.9028, 12.4964),
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
//Dubai
function initMap6() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(25.2048, 55.2708),
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
//Cape Town
function initMap7() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(-33.9249, 18.4241),
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
//Los Angeles
function initMap8() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(34.0522, -118.2437),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump8.php', function(data) {
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
function initMap9() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(40.4259, -86.9081),
          zoom: 11
        });
        var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdump9.php', function(data) {
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

        <!-- Heading -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Historical Data
                    <small>Visualize Quality</small>
                </h1>
                <p>Proactively envisioned multimedia based expertise and cross-media growth strategies. Seamlessly visualize quality intellectual capital without superior collaboration and idea-sharing. Holistically pontificate installed base portals after maintainable products.</p>
            </div>
        </div>
        <!-- /.row -->
		<div id="analydiv" class="row">
			<table id="analytable" border='1'>
				<tr id="analytr">
					<th id="analyth">analytics...</th>
				</tr>
				<!-- ANALYTICS FROM SQL THRU PHP/AJAX SHOULD DISPLAY HERE -->
			</table>	
		</div>
		<div>
		
		<form action="ClientNames.php">
			<input type="submit" value="List Clients" />
		</form><br>

		<?php /*
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
			
			$sql = "SELECT S_ID, N_ID, type, lon, lat FROM Sensor";

			$result = mysqli_query($conn, $sql);

			echo "<table border='1'>
			<tr>
			<th>Sensor ID</th>
			<th>Network ID</th>
			<th>Sensor Type</th>
			<th>Longitude</th>
			<th>Latitude</th>
			</tr>";

			while($row = mysqli_fetch_array($result))
			{
			echo "<tr>";
			echo "<td>" . $row['S_ID'] . "</td>";
			echo "<td>" . $row['N_ID'] . "</td>";
			echo "<td>" . $row['type'] . "</td>";
			echo "<td>" . $row['lon'] . "</td>";
			echo "<td>" . $row['lat'] . "</td>";
			echo "</tr>";
			}
			echo "</table>" . "<br>";			
			
			$conn->close();
			*/
		?>


		</div>

    </div>
    <!-- /.container -->
	
	<footer>
        
        <div class="small-print">
        	<div class="container">
        		<p><a href="#">Terms &amp; Conditions</a> | <a href="#">Privacy Policy</a> | <a href="mailto:czarneckirya@gmail.com">Contact</a></p>
        		<p>Copyright &copy; Group 27 2019 </p>
        	</div>
        </div>
	</footer>

	
    <!-- jQuery -->
    <script src="js/jquery-1.11.3.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	
	<!-- IE10 viewport bug workaround -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
	
	<!-- Placeholder Images -->
	<script src="js/holder.min.js"></script>
	
</body>

</html>
