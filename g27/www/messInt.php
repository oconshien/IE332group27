<?php

require('SQLConn.php');

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$budget = htmlentities($_GET['budget']);
$geoRadius = htmlentities($_GET['geoRadius']);
$date = htmlentities($_GET['date']);
$numDays = htmlentities($_GET['numDays']);
$AirPref = htmlentities($_GET['AirPref']);
$cityType = htmlentities($_GET['cityType']);

$sql = "INSERT INTO Quote (budget, geoRadius, date, numDays, AirPref, cityType)
VALUES ('$budget','$geoRadius','$date','$numDays','$AirPref','$cityType')";

$query = "SELECT * FROM Quote ORDER BY Q_ID DESC LIMIT 1";

$result = $conn->query($query);

if($conn->query($sql) === TRUE){
	//header("Location: https://web.ics.purdue.edu/~g1109699/Solutions.html");
	//exit;
}
else{
	echo "Error: " . $sql . "<br>" . $conn->error;
} 

$conn->close;
$conn = new mysqli($servername, $username, $password, $dbname);

if ($result->num_rows > 0){
    // output data of each row
	$row = $result->fetch_assoc(); 
	echo "<br> id: ". $row["Q_ID"] . "<br>";
	//header("Location: https://web.ics.purdue.edu/~g1109699/Solutions.html");
	//exit;
} else {
    echo "0 results";
}



$conn->close;

?>