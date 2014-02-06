<?php

require('./base.inc');
require(BASE . '/../config.inc');

$smarty = new MySmarty();

$smarty->assign('xajax', $xajax->getJavascript("", BASE . "/js/xajax.js"));

$smarty->display('install_index.tpl');

?>