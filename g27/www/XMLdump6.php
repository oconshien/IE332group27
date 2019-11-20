<?php
// require("SQLConn.php");

$servername="mydb.itap.purdue.edu";
$username=	"g1109699";
$password=	"MySQL27";
$database=	"g1109699";

// echo $database ."<br>";

function parseToXML($htmlStr)
{
$xmlStr=str_replace('<','&lt;',$htmlStr);
$xmlStr=str_replace('>','&gt;',$xmlStr);
$xmlStr=str_replace('"','&quot;',$xmlStr);
$xmlStr=str_replace("'",'&#39;',$xmlStr);
$xmlStr=str_replace("&",'&amp;',$xmlStr);
return $xmlStr;
}

// Opens a connection to a MySQL server
$connection = mysqli_connect($servername, $username, $password, $database);
if (!$connection) {
// if ($connection) {
  die('Not connected : ' . mysqli_error());
}
// Select all the rows in the markers table
$q1 = "SELECT * FROM Sensor WHERE Sensor.N_ID='7'";
$result = mysqli_query($connection, $q1);
if (!$result) {
  die('Invalid query: ' . mysqli_error());
}
// $r1 = mysqli_fetch_array($result);
// echo $r1['name'] ."<br>";

header("Content-type: text/xml");

// Start XML file, echo parent node
echo "<?xml version='1.0' ?>";
echo '<markers>';
$ind=0;
				// echo "?xml version='1.0' ?" ."<br>";
				// echo "markers" ."<br>";
				// echo "\$ind=" . $ind ."<br>";
// Iterate through the rows, printing XML nodes for each
while ($row = @mysqli_fetch_assoc($result)){
  // Add to XML document node
  echo '<marker ';
  echo 'id="' . $row['S_ID'] . '" ';
  echo 'lat="' . $row['lat'] . '" ';
  echo 'lng="' . $row['lon'] . '" ';
  echo 'type="' . $row['type'] . '" ';
  echo '/>';
  $ind = $ind + 1;
				// echo "\$ind=" . $ind ."<br>";
}

// End XML file
echo '</markers>';
?>