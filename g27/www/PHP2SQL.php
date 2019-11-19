<?php

require('SQLConn.php');

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$FirstName = htmlentities($_GET['FirstName']);
$LastName = htmlentities($_GET['LastName']);
$CompanyName = htmlentities($_GET['CompanyName']);
$cEmail = htmlentities($_GET['cEmail']);
$cPassword = htmlentities($_GET['cPassword']);
$cAddress = htmlentities($_GET['cAddress']);
$cCity = htmlentities($_GET['cCity']);
$cPostalCode = htmlentities($_GET['cPostalCode']);
$cCountry = htmlentities($_GET['cCountry']);

$sql = "INSERT INTO Client (cFirst, cLast, company, email, password, address, city, postcode, country)
VALUES ('$FirstName','$LastName','$CompanyName','$cEmail','$cPassword','$cAddress','$cCity','$cPostalCode','$cCountry')";


if($conn->query($sql) === TRUE){
	header("Location: https://web.ics.purdue.edu/~g1109699/Solutions.html");
	exit;
}
else{
	echo "Error: " . $sql . "<br>" . $conn->error;
} 



?>