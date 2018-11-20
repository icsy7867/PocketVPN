  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/index.php">Home</a>
        </li>
        <li class="breadcrumb-item active">Connect</li>
      </ol>
      <div class="row">
        <div class="col-12">
		<div class="container p-3 mb-2 bg-info text-black rounded">
		<h3>Latest Openvpn Connection Log</h3>
		<?php
			$log = fopen("../openvpn/openvpn_connect.log", "r");

			if ($log) {
    	    			while (($line = fgets($log)) !== false) {
					echo "$line <br>";
    	    			}
	    			fclose($log);
			} else {
    	 			echo "error opening the file.";
			}
		?>
		</div>
		<br>
		<div class="container p-3 mb-2 bg-info text-black rounded">
	                <h3>Public IP Address</h3>
	 		<?php
				echo GetPublicIP();
			?>
                </div>

		<br>
		<div class="container p-3 mb-2 bg-info text-black rounded">
	                <h3>Device Temperatures</h3>
			The temperature should remain under <u>70</u><br><br>
	 		<?php
				$temp = GetTemp();

				echo "Sensor 1 - <b>";
				echo $temp[0]/1000;
				echo"</b> Degrees Celsius <br>";

				echo "Sensor 2 - <b>";
				echo $temp[1]/1000;
				echo"</b> Degrees Celsius";
			?>
                </div>
		<br>

		<div class="container p-3 mb-2 bg-info text-black rounded">
	                <h3>WiFi AP Status</h3>
	 		<?php
				echo APStatus();
			?>
                </div>
		<br>
		<div class="container p-3 mb-2 bg-info text-black rounded">
	                <h3> hostapd conf file</h3>
	 		<?php
				$hostapd = HostapdSettings();
				foreach ( $hostapd as $value) { echo "$value <br>"; }
			?>
                </div>

        </div>
      </div>
    </div>
