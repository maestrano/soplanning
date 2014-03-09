<?php

require 'base.inc';
require BASE . '/../config.inc';

// Hook:Maestrano
// Load Maestrano
require BASE . '/maestrano/app/init/base.php';

// http://ltb-project.org/wiki/documentation/self-service-password
function retrieve_ldap_password($login, $password){

    global $ldapUrl, $ldapBase, $ldapFilter;

    # Connect to LDAP
    $ldap = @ldap_connect($ldapUrl);
    @ldap_set_option($ldap, LDAP_OPT_PROTOCOL_VERSION, 3);
    @ldap_set_option($ldap, LDAP_OPT_REFERRALS, 0);

    # Bind
    $bind = @ldap_bind($ldap);
    
    $errno = @ldap_errno($ldap);
    if ( $errno ) {
        $result = "ldaperror";
        $err = "LDAP - Bind error $errno  (".@ldap_error($ldap).")";
        die("LDAP - Bind error $errno  (".@ldap_error($ldap).")");
    }
    else {
		# Search for user
		$ldapFilter = str_replace("{login}", $login, $ldapFilter);
		$search = @ldap_search($ldap, $ldapBase, $ldapFilter);

		$errno = @ldap_errno($ldap);
		if ( $errno ) {
			$result = "ldaperror";
			$err = "LDAP - Search error $errno  (".@ldap_error($ldap).")";
		}
		else {
			# Get user DN
			$entry = @ldap_first_entry($ldap, $search);
			$userdn = @ldap_get_dn($ldap, $entry);

			if( !$userdn ) {
				$result = "badcredentials";
				$err = "LDAP - User $login not found";
			}
			else {    
				# Bind with password
				$bind = @ldap_bind($ldap, $userdn, $password);
				$errno = @ldap_errno($ldap);
				if ( $errno ) {
					$result = "badcredentials";
					$err = "LDAP - Bind user error $errno  (".@ldap_error($ldap).")";
				} else {
					// Everything is OK ;)
					$result = "OK";
					$err = "";
				}
			}
		}
	}
	@ldap_close($ldap);
	if ($result == "OK") {
		return True;
	}
	else {
		return False;
	}		
}

// deconnexion
if(isset($_GET['action']) && $_GET['action'] == 'logout') {
	unset($_SESSION['user_id']);
	session_regenerate_id();
	//session_destroy();
  
  // Hook:Maestrano
  $maestrano = MaestranoService::getInstance();
  if ($maestrano->isSsoEnabled()) {
    header("Location: " . $maestrano->getSsoLogoutUrl());
    exit;
  }
  
	if(CONFIG_LOGOUT_REDIRECT != '') {
		header('Location: ' . CONFIG_LOGOUT_REDIRECT);
		exit;
	} else {
		header('Location: ../index.php');
		exit;
	}
}

//login 
if(!isset($_POST['login']) || !isset($_POST['password']) || $_POST['login'] == '' || $_POST['password'] == '') {
	$_SESSION['message'] = 'erreur_bad_login';
	header('Location: ../index.php');
	exit;
}

// ldap password
if($ldapLogin) {
    if(!isset($_POST['password']) || !retrieve_ldap_password($_POST['login'], $_POST['password'])) {
        $_SESSION['message'] = 'erreur_bad_login';
        header('Location: ../index.php');
        exit;
    }
}

$user = New User();
if($ldapLogin) {
    if(!$user->db_load(array('login', '=', $_POST['login']))) {
        $_SESSION['message'] = 'erreur_bad_login';
        header('Location: ../index.php');
        exit;
    }
}
else {
	$pwd = sha1("¤" . $_POST['password'] . "¤");
	if(!$user->db_load(array('login', '=', $_POST['login'], 'password', '=', $pwd))) {
        $_SESSION['message'] = 'erreur_bad_login';
        header('Location: ../index.php');
        exit;
    }
}

$_SESSION['user_id'] = $user->user_id;

header('Location: ../planning.php');
exit;

?>
