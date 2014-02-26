<?php

require_once('./base.inc');
require_once(BASE . '/../config.inc');

// Hook:Maestrano
// Load Maestrano
require BASE . '/../maestrano/app/init/base.php';
$maestrano = MaestranoService::getInstance();
// Require authentication straight away if intranet
// mode enabled
if ($maestrano->isSsoIntranetEnabled()) {
  if (!$maestrano->getSsoSession()->isValid()) {
    header("Location: " . $maestrano->getSsoInitUrl());
    exit;
  }
}

/* autoconnect if already opened session */
if(isset($_SESSION['user_id']) && $_SESSION['user_id'] != '') {
	$user = New User();
	if($user->db_load(array('user_id', '=', $_SESSION['user_id']))) {
		header('Location: planning.php');
		exit;
	}
}

// Hook:Maestrano
// Redirect to SSO login
if ($maestrano->isSsoEnabled()) {
  header("Location: " . $maestrano->getSsoInitUrl());
  exit;
}

$smarty = new MySmarty();

$version = new Version();
$smarty->assign('planningVersion', $version->getVersion());

$smarty->assign('checkPhpVersion', $version->checkPhpVersion());

$version->checkWritable();

$version->upgradeVersion();

$smarty->assign('xajax', $xajax->getJavascript("", "js/xajax.js"));

$smarty->display('www_index.tpl');

?>