  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="index.php">Home</a>
        </li>
        <li class="breadcrumb-item active">Connect</li>
      </ol>
      <div class="row">
        <div class="col-12">
          <p>

<?php

$external_test = PingTest();
if ( !$external_test ){
        echo "Warning! External Connection not detected.  Please verify ethernet cable is connected.";
}

		  
if(isset($_POST['files'])) { $files = $_POST['files']; } else { $data_error = true;}
if(isset($_POST['OldIP'])) { $OldIP = $_POST['OldIP']; } else { $data_error = true;}
if( isset($_POST['files']) ){
	$connect = TunnelConnect("$files");
	sleep(2);
	$PubIP = GetPublicIP();
	if ($connect){ 
		echo "Successfully Connected!  For more information, please check the Status or Information pages. <br><br>";
		echo "<div class='container col-md-3 bg-info rounded'>
			<strong>Old IP:</strong> $OldIP <br>
			<strong>New IP:</strong> $PubIP <br>";
		}
}

    if ( !VerifyTunnel("tun") ) {
		$PubIP = GetPublicIP();
		$list = ListVPNFiles();
		echo '
	 		 <form id="connect" role="form" method="post" action="/connect/">
			 <div class="form-group col-4">
                        	<label for="files" class="control-label">VPN Files</label>
                        	<select name="files" form="connect">';

			 foreach ($list as $server) {
                    	     echo "<option value='$server'>$server</option>";
                	 }
			echo "<input type='hidden' value='$PubIP' name='OldIP' />";
			echo '
				</select>
				</form><br><br>
                        	<button id="form-submit" type="submit" class="btn btn-primary btn-block">Connect</button>
                	</div>';
			echo "Current Public IP Address: <strong>$PubIP</strong>";

    } if ( VerifyTunnel("tun") && !(isset($_POST['files'])) ) {
        echo "
	      <div class='container col-md-5 bg-light rounded'>
	          You are already connected<br><br>
	          <a href='/status/'><button type='button' class='btn btn-info'>View Status</button></a>
	      </div>
	";
    } if ( (isset($_POST['files']) && !VerifyTunnel("tun")) ) {
	echo "<br>Something went wrong... Try disconnecting from the menu";
    }
?>
</p>
        </div>
      </div>
    </div>
