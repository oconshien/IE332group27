<?php

require('SQLConn.php');

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$FirstName = htmlentities($_POST['FirstName']);
$LastName = htmlentities($_POST['LastName']);
$CompanyName = htmlentities($_POST['CompanyName']);
$cEmail = htmlentities($_POST['cEmail']);
$cAddress = htmlentities($_POST['cAddress']);
$cCity = htmlentities($_POST['cCity']);
$cPostalCode = htmlentities($_POST['cPostalCode']);
$cCountry = htmlentities($_POST['cCountry']);

$sql = "INSERT INTO Client (cFirst, cLast, company, email, address, city, postcode, country)
VALUES ('$FirstName','$LastName','$CompanyName','$cEmail','$cAddress','$cCity','$cPostalCode','$cCountry')";


if($conn->query($sql) === TRUE){
	header("Location: https://web.ics.purdue.edu/~g1109699/Solutions");
	exit;
}
else{
	echo "Error: " . $sql . "<br>" . $conn->error;
} 



?>