  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/index.php">Home</a>
        </li>
        <li class="breadcrumb-item active">Disconnect</li>
      </ol>
      <div class="row">
        <div class="col-12">
          <p>

<?php


        $connect = TunnelDisconnect();

        if( $connect ){
           echo "All openvpn processes have been terminated.";
        } else {
           echo "Something went wrong... Still Connected...";
        }

?>
</p>
        </div>
      </div>
    </div>
