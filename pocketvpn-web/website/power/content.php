  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/index.php">Home</a>
        </li>
        <li class="breadcrumb-item active">Power</li>
      </ol>
      <div class="row">
        <div class="col-12">
          <p>

<?php
if(isset($_POST['power'])) { $power = $_POST['power'];	} else { $data_error = true;}
//echo $power;

if( isset($_POST['power']) ) {
	if( $power == "reboot" ) {
		echo "Rebooting...";
		power("reboot");
	} elseif ( $power == "shutdown" ) {
		echo "Shutting Down...";
		power("shutdown");
	} else {
		echo "Something went wrong...";
	}

} else {
	echo "Value not set!  Please click either <u>Reboot</u> or <u>Shutdown</u> on the top right.";
}






?>
</p>
        </div>
      </div>
    </div>
