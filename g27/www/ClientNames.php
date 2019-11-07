<?php
$servername = "mydb.itap.purdue.edu";
$username = "g1109699";
$password = "MySQL27";
$dbname = "g1109699";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT C_ID, company, cFirst FROM Client";

$result = $conn->query($sql);

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
echo "</table>";

// if ($result->num_rows > 0) {
    // output data of each row
    // while($row = $result->fetch_assoc()) {
        // echo "<br> Client Number: " . $row["C_ID"]. " - ". $row["company"]. "<br>";
    // }
// } else {
    // echo "0 results";
// }

$conn->close();

?>
