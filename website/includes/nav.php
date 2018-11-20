<body class="fixed-nav sticky-footer bg-dark" id="page-top">
  <!-- Navigation-->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <a class="navbar-brand" href="/index.php">Home</a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Status">
          <a class="nav-link" href="/status/">
            <i class="fa fa-fw fa-dashboard"></i>
            <span class="nav-link-text">Status</span>
          </a>
        </li>
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Connect">
          <a class="nav-link" href="/connect/">
            <i class="fa fa-fw fa-plug"></i>
            <span class="nav-link-text">Connect</span>
           <div class="form-group connect-loading-spinner" style="float:right;display:none;">
           <i class="fa fa-spinner fa-spin" style="font-size:24px"></i>
            </div>
	  </a>
        </li>
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Disconnect">
          <a id="disconnect-link" class="nav-link" href="/disconnect/">
            <i class="fa fa-fw fa-unlink"></i>
            <span class="nav-link-text">Disconnect</span>
           <div class="form-group disconnect-loading-spinner" style="float:right;display:none;">
           <i class="fa fa-spinner fa-spin" style="font-size:24px"></i>
            </div>
          </a>
        </li>
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Info">
          <a class="nav-link" href="/info/">
            <i class="fa fa-fw fa-info"></i>
            <span class="nav-link-text">Information</span>
          </a>
        </li>
        <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Settings">
          <a class="nav-link" href="/settings/">
            <i class="fa fa-fw fa-cogs"></i>
            <span class="nav-link-text">Settings</span>
          </a>
        </li>
    </div>
    <div class="text-right float-right aligh-right">
       	<form action ="/power/" method="post" id="powerform">
	    <button type="submit" class="btn btn-danger" form="powerform" name="power" id="power" value="reboot">Reboot</button>
            <button type="submit" class="btn btn-danger" form="powerform" name="power" id="power" value="shutdown">Shutdown</button>
	</form>
    </div>

  </nav>



