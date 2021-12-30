<?php

require_once "functions.php";
//include 'functions.php';

echo "Tunnel Up: ";
$out = VerifyTunnel("tun234");
echo $out;
echo "<br>";



$output = shell_exec("ifconfig tun0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'"); 

echo "Empty?: ";
echo empty($output);
echo $output;
?>
