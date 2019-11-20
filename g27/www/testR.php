<?php
require('SQLConn.php');

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// TODO: need to sanitize input

$param_n = htmlentities($_GET['n']);
$param_mean = htmlentities($_GET['mean']);
$param_sd = htmlentities($_GET['sd']);
echo $param_n . "<br>";
echo $param_mean . "<br>";
echo $param_sd . "<br>";
echo "strftime:\t" . strftime("%Y-%b-%d\t%H:%M:%S") . "<br>";

// execute R script from shell
exec("Rscript testRnorm.R $param_n $param_mean $param_sd", $exec_out);
print_r($exec_out);
echo "<br>";
var_dump($exec_out);
echo "<br>";

// return image tag
$nocache = rand();
echo("<table style='width:100%'><tr>");
echo("<th><img src='testRhistpng.png' /></th>");
echo("<th><iframe src='testRhistsink.txt' style='width:70%; height:500px'></iframe></th></tr>");
echo("<tr><th><iframe src='testRhistpdf.pdf' width='500' height='500')></iframe></th>");
echo("<th><embed src='testRhistpdf.pdf' width='500' height='500' /></th>");
echo("</tr></table>");

// $sql = "INSERT INTO Quote (email, budget, geoRadius, date, numDays, airPref, citylat, citylon)
// VALUES ('$email','$budget','$geoRadius','$date','$numDays','$airPref','$lat', '$lng')";

// if($conn->query($sql) === TRUE){
	// header("Location: https://web.ics.purdue.edu/~g1109699/Solutions.html");
	// exit;
// }
// else{
	// echo "Error: " . $sql . "<br>" . $conn->error;
// } 

?>