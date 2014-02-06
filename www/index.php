<?php

require_once('./base.inc');
require_once(BASE . '/../config.inc');

/* autoconnect if already opened session */
if(isset($_SESSION['user_id']) && $_SESSION['user_id'] != '') {
	$user = New User();
	if($user->db_load(array('user_id', '=', $_SESSION['user_id']))) {
		header('Location: planning.php');
		exit;
	}
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