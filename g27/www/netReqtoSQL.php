<?php

require('SQLConn.php');

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
$email = htmlentities($_POST['email']);
$budget = htmlentities($_POST['budget']);
$geoRadius = htmlentities($_POST['geoRadius']);
$date = htmlentities($_POST['date']);
$numDays = htmlentities($_POST['numDays']);
$airPref = htmlentities($_POST['AirPref']);
$cityType = htmlentities($_POST['cityType']);

$address = htmlentities($_POST['city']);

$geocode_stats = file_get_contents("https://maps.googleapis.com/maps/api/geocode/json?address=".$address. "&sensor=false&key=AIzaSyCfNAIKeP6ySNvYp2ohmGlpIroJs6aFlxA");

$output_deals = json_decode($geocode_stats);
$latLng = $output_deals->results[0]->geometry->location;

$lat = $latLng->lat;
$lng = $latLng->lng;



$sql = "INSERT INTO Quote (email, budget, geoRadius, date, numDays, airPref, citylat, citylon)
VALUES ('$email','$budget','$geoRadius','$date','$numDays','$airPref','$lat', '$lng')";

if($conn->query($sql) === TRUE){
	header("Location: https://web.ics.purdue.edu/~g1109699/Solutions");
	exit;
}
else{
	echo "Error: " . $sql . "<br>" . $conn->error;
} 



?>