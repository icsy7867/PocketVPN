<?php

require_once "functions.php";

//run openvpn connect script
    if ( !VerifyTunnel("tun")) {
        //$connect = TunnelConnect("TorGuard.USA-ATLANTA.ovpn");
        $connect = TunnelConnect("TorGuard.USA-CHICAGO.ovpn");

	if( $connect ){
	   echo "Connected!";
	} else {
	   echo "Something went wrong...";
	}
    } else {
	echo "You are already connected";
    }
?>
