  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/index.php">Home</a>
        </li>
        <li class="breadcrumb-item active">Settings</li>
      </ol>
      <div class="row">
        <div class="col-12">
<strong>
<?php
//get post if it exists
//error_reporting(E_ALL);
//ini_set('display_errors',1);
 if(isset($_POST['username'])) { $username = $_POST['username']; } else { $data_error = true;}
 if(isset($_POST['password'])) { $password = $_POST['password']; } else { $data_error = true;}
 if(isset($_POST['WebPassword'])) { $WebPassword = $_POST['WebPassword']; } else { $data_error = true;}
 if(isset($_POST['WebPassword2'])) { $WebPassword2 = $_POST['WebPassword2']; } else { $data_error = true;}


    if( isset($_POST['username']) && isset($_POST['password']) ) {
	$handle = fopen("../openvpn/auth", "w");
	$data = $username . PHP_EOL . $password;
	$write = fwrite($handle, $data);

	if( $write ) {
	    echo "Password file updated!";
	} else {
	    echo "Something went wrong, password file was not updated";
	}
    }

    if ( isset($_POST['WebPassword']) ){
	if( $WebPassword == $WebPassword2) {
	    WebPasswordChange($WebPassword);
	    echo "Password updated - Please refresh the page and enter the new password."; 
	} else {
	    echo "Error: Verify Passwords Matched";
	}
    }

//check for ovpn file
if( isset($_POST['uploadit']) ) {
    if(isset($_FILES['file']['name'])) {$file = $_FILES['file']['name'];}
    if(isset($_FILES['file']['tmp_name'])) {$file_loc = $_FILES['file']['tmp_name'];}
    if(isset($_FILES['file']['size'])) {$file_size = $_FILES['file']['size'];}
    if(isset($_FILES['file']['type'])) {$file_type = $_FILES['file']['type'];}
    if(isset($_POST['name'])) {$name = $_POST['name'];}
    $target_dir = "../openvpn/config/";
    $target_file = $target_dir . $file;
    //ensure no space/whitespace
    $target_file = preg_replace('/\s+/', '', $target_file);
    $target_file = str_replace(' ', '', $target_file);

    //Verify form is submitted correctly - Will change below if error
    $uploadOK = 1;

//failure tests

//get extension
$ext = pathinfo($target_file, PATHINFO_EXTENSION);

if ($ext != "ovpn") {
        $file_type_err = "Please upload ovpn files only!";
        $uploadOK = 0;
	echo $file_type_err;
    }


    if (file_exists($target_file)) {
        $file_exists_err = "This file already exists!";
        $uploadOK = 0;
	echo $file_exists_err;
    }
if ($uploadOK == 1) {
        //echo "$file $notes, $file_loc, $target_file";
        if( move_uploaded_file($file_loc, $target_file) ) {
            //File uploaded and moved with success - Upload info to DB.
            //$submit_query = "INSERT INTO dbo.LoanAgreement VALUES ('$file', '$file_type', '$file_size', '$name', '$
            //$submit_result = mssql_query($submit_query) or die ('Error Connecting');
            //mssql_free_result($submit_result);
            $confirm = "Your file has been uploaded succesfully!";
	    echo $confirm;
        } else {
            $confirm = "Sorry, there was an error uploading your file.";
	    echo $confirm;
        }

}


}

//check for ovpn_delete
if( isset($_POST['deleteit']) ) {
    if(isset($_POST['ovpn_delete'])) {$ovpn_delete = $_POST['ovpn_delete'];}
    $del_path = "/var/www/html/openvpn/config/";
    $del_file = $del_path . $ovpn_delete;
    $delete = unlink($del_file);
    	if ( $delete ){
	    echo "File deleted Successfully!";
	} else {
	    echo "There was a problem deleting your file";
	}
}

?>
</strong>
	<div class="container p-3 mb-2 bg-info text-black rounded">
	    <h4>Update VPN  Username and Password</h4>
	      <form id="userupdate" role="form" method="post" action="/settings/">
		<div class="form-group col-4">
               		<label for="username" class="control-label">Username</label>
                        <input type="text" name="username" id="username" class="form-control" required>

               		<label for="Password" class="control-label">Password</label>
                        <input type="password" name="password" id="password" class="form-control" required>
			<br>
	                <button type="submit" form="userupdate" class="btn btn-primary btn-block">Update</button>
		</div>
	      </form>
	</div>
	  <br>
	<div class="container p-3 mb-2 bg-info text-black rounded">
            <h4>Update Webaccess Admin Password</h4>
              <form id="webaccess" role="form" method="post" action="/settings/">
                <div class="form-group col-4">

                        <label for="WebPassword" class="control-label">Password</label>
                        <input type="password" name="WebPassword" id="WebPassword" class="form-control" required>
                        <label for="WebPassword2" class="control-label">Re-type Password</label>
                        <input type="password" name="WebPassword2" id="WebPassword2" class="form-control" required>
                        <br>
                        <button type="submit" form="webaccess" class="btn btn-primary btn-block">Update</button>
                </div>
              </form>
	</div> 
	<br>
        <div class="container p-3 mb-2 bg-info text-black rounded">
            <h4>Upload new OpenVPN (.ovpn) file</h4>
	    Please include all <b>CA</b>, <b>TLS AUTH</b> and <b>Cert</b> files inline with the ovpn file.<br>
	    Alternatively, you can include the paths, but please ensure CA and TLS certs<br>
	    have been uploaded to the correct locations.<br><br>
              <form id="ovpnupload" role="form" method="post" action="/settings/" enctype="multipart/form-data">
                <div class="form-group col-4">
		        <input id="file" name="file" type="file" accept=".ovpn" required>
                        <br><br>
                        <button type="submit" name="uploadit" form="ovpnupload" class="btn btn-primary btn-block">Upload</button>
                </div>
              </form>
        </div>
	<br>
        <div class="container p-3 mb-2 bg-info text-black rounded">
            <h4>DeleteOpenVPN (.ovpn) file</h4>
              <form id="ovpndelete" role="form" method="post" action="/settings/">
                <div class="form-group col-4">
			<select name="ovpn_delete">
  			  <?php
				$list = ListVPNFiles();
				foreach ($list as $server) {
                                    echo "<option value='$server'>$server</option>";
                                }
			  ?>
			</select>
                        <br><br>
                        <button type="submit" name="deleteit" form="ovpndelete" class="btn btn-danger btn-block">Delete</button>
                </div>
              </form>
        </div>


       </div>
     </div>
   </div>
