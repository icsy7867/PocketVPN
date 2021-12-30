<?php

function VerifyTunnel($tunstring) {
	$output = "";
        $output = shell_exec("/sbin/ip -f inet addr show tun0 | grep -Po 'inet \K[\d.]+'");
        $findme   = 'does not exist';
	$pos = strpos($output, $findme);

	//make sure ifconfig is not empty as well!
    	if ($pos === false && (!empty($output)) ){
        	return 1;
    	} else {
        	return 0;
    	}
}

function TunnelStatus() {
	exec("/sbin/ip addr show tun0", $output);
	//echo $output;
	return $output;
}
function HostapdSettings() {
	exec("cat /etc/hostapd/hostapd.conf", $output);
	//echo $output;
	return $output;
}

function GetTemp() {
	$output = array();
	$output[] = shell_exec("cat /sys/class/thermal/thermal_zone0/temp");
	$output[] = shell_exec("cat /sys/class/thermal/thermal_zone1/temp");
	return $output;
}

function APStatus() {
	$output = shell_exec("systemctl status hostapd | grep active");
	return $output;
}

function TunnelConnect($server) {
	$output = shell_exec("sudo -b ./../openvpn/connect.sh $server  > ../openvpn/openvpn_connect.log 2>&1 &> /dev/null 2>&1 &");
	$count  = 0;
	while ( !VerifyTunnel("tun") ) { 
		usleep(500000);
		$count++;
			if ( $count == 28 ) { break; } 
	}
	usleep(200000);
	return VerifyTunnel("tun");
}

function TunnelDisconnect() {
	$output = shell_exec("sudo -b ./../openvpn/disconnect.sh > ../openvpn/openvpn_connect.log 2>&1 &> /dev/null 2>&1 &");
	$count  = 0;
	while ( VerifyTunnel("tun") ) { 
		usleep(500000);
		$count++;
			if ( $count == 20 ) { break; } 
	}
	usleep(900000);
	return !(VerifyTunnel("tun"));
}

function power($option) {
	if($option == "reboot" ) {
		$output = shell_exec("sudo -b ./../scripts/power.sh 0");
	} elseif( $option == "shutdown" ) {
		$output = shell_exec("sudo -b ./../scripts/power.sh 1");
	}
}

function WebPasswordChange($pass) {
	$output = shell_exec("sudo /usr/bin/htpasswd -b /httpaccess/.htpasswd admin $pass");
	return $output;
}

function ListVPNFiles() {
	$dir = '/var/www/html/openvpn/config';
	$files = scandir($dir);

	//remove the . and .. directory list
	array_shift($files);
	array_shift($files);
	return $files;

}
function PingTest() {
        $output = shell_exec("sudo /bin/ping -4 -q -c 1 -W 1 google.com >/dev/null && echo 'Success'");
        if ( $output ){
          return 1;
        } else {
          return 0;
        }
}

function GetPublicIP() {
	usleep(100000);
        $externalContent = file_get_contents("http://ipecho.net/plain");
        $externalIp = $externalContent;
	if ( $externalIp ){
            return $externalIp;
	} else {
	    return "Error getting IP";
	}
}



?>
