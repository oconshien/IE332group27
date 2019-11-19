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
	th {
		padding: 15px;
		background-color: #4CAF50;
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
                <a class="navbar-brand" href="https://web.ics.purdue.edu/~g1109699/index">
                	<span class="glyphicon glyphicon-grain"></span> 
                	Group 27
                </a>
            </div>
            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="https://web.ics.purdue.edu/~g1109699/index">Home</a>
                    </li>
                    <li>
                        <a href="https://web.ics.purdue.edu/~g1109699/Solutions">Solutions</a>
                    </li>
                    <li>
                        <a href="https://web.ics.purdue.edu/~g1109699/Technology">Technology</a>
                    </li>
					<li class="active">
                        <a href="https://web.ics.purdue.edu/~g1109699/HistoricalData">Historical Data</a>
                    </li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Meet the Team <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="about-us">
							<li><a href="#">Will Hicks</a></li>
							<li><a href="#">Jeff Finucane</a></li>
							<li><a href="#">Laura Roach</a></li>
							<li><a href="#">Truman Boggs</a></li>
							<li><a href="#">Jorge Valdez</a></li>
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

	<div id="map"></div>
	
	
	<script>
	
	var customLabel = {
        restaurant: {
          label: 'F'
        },
        bar: {
          label: 'M'
        }
      };
	  
	  marker.addListener('click', function() {
  infoWindow.setContent(infowincontent);
  infoWindow.open(map, marker);
});


	
// Initialize and add the map
function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: new google.maps.LatLng(-33.863276, 151.207977),
          zoom: 12
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
              var strong = document.createElement('strong');
              strong.textContent = name
              infowincontent.appendChild(strong);
              infowincontent.appendChild(document.createElement('br'));

              var text = document.createElement('text');
              text.textContent = address
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
		<div>
		
		<form action="ClientNames.php">
			<input type="submit" value="List Clients" />
		</form>
		
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

			$sql = "SELECT C_ID, company, cFirst FROM Client";

			$result = mysqli_query($conn, $sql);

			echo "<table border='1'>
			<tr>
			<th>Client ID</th>
			<th>Company</th>
			<th>First Name</th>
			</tr>";

			while($row = mysqli_fetch_array($result))
			{
			echo "<tr>";
			echo "<td>" . $row['C_ID'] . "</td>";
			echo "<td>" . $row['company'] . "</td>";
			echo "<td>" . $row['cFirst'] . "</td>";
			echo "</tr>";
			}
			echo "</table>" . "<br>";

			$conn->close();

		?>
		
		
		
		</div>
        <!-- Feature Row -->
        <div class="row">
            <article class="col-md-4 article-intro">
                <a href="#">
                    <img class="img-responsive img-rounded" src="holder.js/700x300" alt="">
                </a>
                <h3>
                    <a href="#">Efficiently nope</a>
                </h3>
                <p>Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits. Dramatically visualize customer directed convergence without revolutionary ROI.</p>
            </article>
            <article class="col-md-4 article-intro">
                <a href="#">
                    <img class="img-responsive img-rounded" src="holder.js/700x300" alt="">
                </a>
                <h3>
                    <a href="#">Completely Synergize</a>
                </h3>
                <p>Dramatically maintain clicks-and-mortar solutions without functional solutions. Efficiently unleash cross-media information without cross-media value. Quickly maximize timely deliverables for real-time schemas.</p>
            </article>

            <article class="col-md-4 article-intro">
                <a href="#">
                    <img class="img-responsive img-rounded" src="holder.js/700x300" alt="">
                </a>
                <h3>
                    <a href="#">Dynamically Procrastinate</a>
                </h3>
                <p>Professionally cultivate one-to-one customer service with robust ideas. Completely synergize resource taxing relationships via premier niche markets. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>
            </article>
        </div>
        <!-- /.row -->

    </div>
    <!-- /.container -->
	
	<footer>
		<div class="footer-blurb">
			<div class="container">
				<div class="row">
					<div class="col-sm-4 footer-blurb-item">
						<h3><span class="glyphicon glyphicon-fire"></span> Dynamically Procrastinate</h3>
						<p>Collaboratively administrate empowered markets via plug-and-play networks. Dynamically procrastinate B2C users after installed base benefits. Dramatically visualize customer directed convergence without revolutionary ROI.</p>
						<p><a class="btn btn-default" href="#">Procrastinate</a></p>
					</div>
					<div class="col-sm-4 footer-blurb-item">
						<h3><span class="glyphicon glyphicon-cloud-upload"></span> Efficiently Unleash</h3>
						<p>Dramatically maintain clicks-and-mortar solutions without functional solutions. Efficiently unleash cross-media information without cross-media value. Quickly maximize timely deliverables for real-time schemas. </p>
						<p><a class="btn btn-default" href="#">Unleash</a></p>
					</div>
					<div class="col-sm-4 footer-blurb-item">
						<h3><span class="glyphicon glyphicon-leaf"></span> Completely Synergize</h3>
						<p>Professionally cultivate one-to-one customer service with robust ideas. Completely synergize resource taxing relationships via premier niche markets. Dynamically innovate resource-leveling customer service for state of the art customer service.</p>
						<p><a class="btn btn-default" href="#">Synergize</a></p>
					</div>

				</div>
				<!-- /.row -->	
			</div>
        </div>
        
        <div class="small-print">
        	<div class="container">
        		<p><a href="#">Terms &amp; Conditions</a> | <a href="#">Privacy Policy</a> | <a href="#">Contact</a></p>
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