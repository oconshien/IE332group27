<html>

<body>

<?php
# to display errors to output
error_reporting(E_ALL);


function test_input($data) {
# format the data appropriately
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

# do this for security reasons
$A1pct=$A2pct=$A3pct=$A1base=$A2base=$A3base=$A1act=$A2act=$A3act="";
$Q1pct=$Q2pct=$Q3pct=$Q1base=$Q2base=$Q3base=$Q1act=$Q2act=$Q3act="";
$E1pct=$E2pct=$E3pct=$E1base=$E2base=$E3base=$E1act=$E2act=$E3act="";
$Ppct=$Pbase=$Pact=$Bpct=$Bbase=$Bact="";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
   $A1pct = test_input($_POST["A1pct"]);
   $A2pct = test_input($_POST["A2pct"]);
   $A3pct = test_input($_POST["A3pct"]);
   $A1base = test_input($_POST["A1base"]);
   $A2base = test_input($_POST["A2base"]);
   $A3base = test_input($_POST["A3base"]);
   $A1act = test_input($_POST["A1act"]);
   $A2act = test_input($_POST["A2act"]);
   $A3act = test_input($_POST["A3act"]);

   $Q1pct = test_input($_POST["Q1pct"]);
   $Q2pct = test_input($_POST["Q2pct"]);
   $Q3pct = test_input($_POST["Q3pct"]);
   $Q1base = test_input($_POST["Q1base"]);
   $Q2base = test_input($_POST["Q2base"]);
   $Q3base = test_input($_POST["Q3base"]);
   $Q1act = test_input($_POST["Q1act"]);
   $Q2act = test_input($_POST["Q2act"]);
   $Q3act = test_input($_POST["Q3act"]);

   $E1pct = test_input($_POST["E1pct"]);
   $E2pct = test_input($_POST["E2pct"]);
   $E3pct = test_input($_POST["E3pct"]);
   $E1base = test_input($_POST["E1base"]);
   $E2base = test_input($_POST["E2base"]);
   $E3base = test_input($_POST["E3base"]);
   $E1act = test_input($_POST["E1act"]);
   $E2act = test_input($_POST["E2act"]);
   $E3act = test_input($_POST["E3act"]);

   $Pact = test_input($_POST["Pact"]);
   $Pbase = test_input($_POST["Pbase"]);
   $Ppct = test_input($_POST["Ppct"]);

   $Bact = test_input($_POST["Bact"]);
   $Bbase = test_input($_POST["Bbase"]);
   $Bpct = test_input($_POST["Bpct"]);

   $final_pct = ($A1pct*$A1act/$A1base + $A2pct*$A2act/$A2base + $A3pct*$A3act/$A3base) + 
                ($Q1pct*$Q1act/$Q1base + $Q2pct*$Q2act/$Q2base + $Q3pct*$Q3act/$Q3base) + 
                ($E1pct*$E1act/$E1base + $E2pct*$E2act/$E2base + $E3pct*$E3act/$E3base) +       
                 $Ppct*$Pact/$Pbase + $Bpct*$Bact/$Bbase;

   $final_ltr = "NA";
   if ( $final_pct>=90 ) {
      $final_ltr = "A";
   } elseif ( $final_pct>=80 ) {
      $final_ltr = "B";
   } elseif ( $final_pct>=70 ) {
      $final_ltr = "C";
   } elseif ( $final_pct>=60 ) {
      $final_ltr = "D";
   } elseif ($final_pct>=0 ) {
      $final_ltr = "F";
   }

print  $Bpct*$Bact/$Bbase;

   if ( $final_ltr=="NA" ) {
      print "<img height=200 src='invalid.jpg'>";
      print "<b>An error occurred and final percent was not valid!</b>";
   } else {
      print "<img height=300 src='graded.png'><br>";
      print "Final pct=<b>$final_pct</b>, which is a grade of <b>$final_ltr</b>.";
   }   
}
?>

</body>
</html>
