<?php

// Database Parameters
$cfgHostname = 'localhost';
$cfgDatabase = 'soplanning';
$cfgUsername = 'root';
$cfgPassword = 'root';
$cfgSqlType = 'mysql'; // for postgresql : psql

// LDAP vars
$ldapLogin = false;
$ldapUrl = "ldap://ldap.yourCompany.com";
$ldapBase = "ou=people,dc=society,dc=com";
$ldapFilter = "(&(objectClass=OpenLDAPperson)(uid={login}))";

// custom variables
define('COMPIL_DIR', BASE . '/../smarty/templates_c/'); // templates compil directory, must have read/write access

// number of results per page
define('NB_RESULT_PER_PAGE', 30);

// define how many items to display in the filter menus in the planning
define('FILTER_NB_USERS_PER_COLUMN', '14');
define('FILTER_NB_PROJECTS_PER_COLUMN', '14');

define('DEBUG', false);  // put TRUE for debug
define('DEV_MAIL', 'yourmail@domain.com');


// ----------------------------------------------------------------------------
// DO NOT MODIFY ANYTHING AFTER THIS LINE
// ----------------------------------------------------------------------------

//error_reporting(E_ALL ^ E_NOTICE);
error_reporting(E_ALL | E_STRICT);

define('CRLF', "\n");

// Initialize Debug Log
$debugLog = array();

// Load DB Wrapper
require BASE . '/../includes/db_wrapper.inc';

// Load Classes
function __autoload($nomClasse) {
	if($nomClasse == 'PHPMailer') {
		require BASE . '/../phpmailer/class.phpmailer.php';
	} else {
		require BASE . '/../includes/class_' . strtolower($nomClasse) . '.inc';
	}
}

// Librairies
require BASE . '/../includes/lib.inc';
require BASE . '/../includes/xajax_common.inc';

date_default_timezone_set('Europe/Paris');

// Connect to Database
if (isset($cfgSqlType)) {
    if(db_connect($cfgHostname, $cfgUsername, $cfgPassword, $cfgDatabase, $cfgSqlType) == FALSE) {
        die('Database connection failed. Please, verify parameters');
    }
    db_select_db($cfgDatabase);
    // Ouverture de la session
    session_start();
}

$cfgAvailableLanguages = array(
	'fr'         => array('fr([-_][[:alpha:]]{2})?|french', 'fr'),
	'it'         => array('it([-_][[:alpha:]]{2})?|italian', 'it'),
	'en'         => array('en([-_][[:alpha:]]{2})?|english', 'en'),
	'nl'         => array('nl([-_][[:alpha:]]{2})?|nederlands', 'nl'),
	'de'         => array('de([-_][[:alpha:]]{2})?|german', 'de'),
	'es'         => array('es([-_][[:alpha:]]{2})?|spanish', 'es'),
	'pt'         => array('pt([-_][[:alpha:]]{2})?|portuguese', 'pt')
);

$langueDefaut = 'en';
$lang = $langueDefaut;
if(isset($_GET) && !empty($_GET['language']) && in_array($_GET['language'], array('fr', 'en', 'it', 'nl', 'de', 'pt', 'es'))){
	$_SESSION['language'] = $_GET['language'];
	$lang = $_GET['language'];
} elseif (isset($_SESSION['language']) && in_array($_SESSION['language'], array('fr', 'en', 'it', 'nl', 'de', 'pt', 'es'))) {
	$lang = $_SESSION['language'];
} else {
	$_SESSION['language'] = detectLanguage($langueDefaut);
	$lang = detectLanguage($langueDefaut);
}

setlocale(LC_ALL, $lang . '_' . strtoupper($lang), $lang . '_' . strtoupper($lang) . '.ISO8859-1', $lang . '_' . strtoupper($lang) . '.ISO-8859-1', $lang . '_' . strtoupper($lang) . '.UTF-8', $lang . '_' . strtoupper($lang) . '.UTF8', $lang);

// chargement des données de config générale
$result = db_query("show tables from $cfgDatabase like 'planning_config'");
if(db_num_rows($result) == 0) {
	// hack special pour installation de la table config (non présente avant systeme auto-upgrade)
	$version = new Version();
	$version->upgradeVersion();
}
$configs = db_query('SELECT * FROM planning_config');
while($configTemp = db_fetch_array($configs)) {
	define('CONFIG_' . $configTemp['cle'], $configTemp['valeur']);
}


?>