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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	
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

</head>

<body style="background-color:#AADAFF;">

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
                	Group 27
                </a>
            </div>
            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="https://web.ics.purdue.edu/~g1109699/index.php">Home</a>
                    </li>
                    <li>
                        <a href="https://web.ics.purdue.edu/~g1109699/Solutions">Solutions</a>
                    </li>
                    <li>
                        <a href="https://web.ics.purdue.edu/~g1109699/Technology">Technology</a>
                    </li>
					<li>
                        <a href="https://web.ics.purdue.edu/~g1109699/HistoricalData">Historical Data</a>
                    </li>
					
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Meet the Team <span class="caret"></span></a>
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
			<h1><span class="glyphicon glyphicon-cloud"></span> Cair Inc</h1>
			<p>Our goal is to help our clients have quality business and quality a</p>
			<form action="Solutions">
			<input type="submit" value="How Can We Help You?" />
		</form>
		</div>
	</div>
	

    <!-- Content -->
		<div align="center">
		<table align="center" id="mapTable2">
		<tr>
		<th color="black">
			latitude: <input style="color:black" type="number" name="lat" id="lat2"></input>
		</th>
		<th color="black">
			longitude: <input style="color:black" type="number" name="lon" id="lon2"></input>
		</th>
		<th>
			<button style="color:black" onclick="initMap2(document.getElementById('lat2').value,document.getElementById('lon2').value)">see map</button>
		</th>
		</tr>
		</table>
		</div>
		

		
		<div id="map"></div>
		
		<script>
		
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
		
		//-33.8688
		
		function initMap() {
		    
			
			var map = new google.maps.Map(document.getElementById('map'), {
				center: new google.maps.LatLng(0,0),
				zoom: 1
			});
			
			var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdumpALL.php', function(data) {
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
		
		function initMap2(x,y) {
		    
			
			var map = new google.maps.Map(document.getElementById('map'), {
				center: new google.maps.LatLng(x,y),
				zoom: 11
			});
			
			var infoWindow = new google.maps.InfoWindow;

downloadUrl('https://web.ics.purdue.edu/~g1109699/XMLdumpALL.php$N_ID=2', function(data) {
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

	<footer>
        
        <div class="small-print">
        	<div class="container">
        		<font color="#71c8f4"><p>Terms &amp; Conditions | Privacy Policy | <a href="https://twitter.com/cair_inc">Contact</a></p></font>
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
