  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/index.php">Home</a>
        </li>
        <li class="breadcrumb-item active">Status</li>
      </ol>
      <div class="row">
        <div class="col-12">

		<div class="container bg-info rounded">
		<?php
        		if ( VerifyTunnel("tun") ){
                		echo "<strong>Currently Connected using:</strong> <br>";
                		$content = file('../openvpn/openvpn_connect.log');
                                echo "<strong>$content[0]</strong><br><br>";
				$TunStat =  TunnelStatus();
				foreach ( $TunStat as $value){ echo "$value <br>"; }
        		} else {
                		echo "<strong>Not currently connected. </strong>";
        		}
		?>
		</div>
		<br>
		<div class="container bg-light rounded">
		    <strong>Available OVPN Files: </strong>
			<?php
				$list = ListVPNFiles();
				foreach ($list as $server) {
        			    echo "<br>$server";
				}
			?>

		 </div>

       </div>
     </div>
   </div>
