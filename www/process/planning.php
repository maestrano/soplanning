<?php

require 'base.inc';
require BASE . '/../config.inc';

require BASE . '/../includes/header.inc';

// changement date de début
$pattern = '/^([1-9]|0[1-9]|1[0-9]|2[0-9]|3[01])\/([1-9]|0[1-9]|1[012])\/(19[0-9][0-9]|20[0-9][0-9])$/';
if (isset($_GET['date_debut_affiche']) && preg_match($pattern, $_GET['date_debut_affiche']) == 1) {
	$_SESSION['date_debut_affiche'] = $_GET['date_debut_affiche'];
}

// changement nb mois affichés
if (isset($_GET['nb_mois']) && is_numeric($_GET['nb_mois']) && round($_GET['nb_mois']) > 0) {
	$nbMois = $_GET['nb_mois'];
	$_SESSION['nb_mois'] = $_GET['nb_mois'];
}

if(isset($_GET['nb_lignes'])  && is_numeric($_GET['nb_lignes']) && round($_GET['nb_lignes']) > 0) {
	$_SESSION['nb_lignes'] = $_GET['nb_lignes'];
	$_SESSION['page_lignes'] = 1;
}

if(isset($_GET['page_lignes'])  && is_numeric($_GET['page_lignes']) && round($_GET['page_lignes']) > 0) {
	$_SESSION['page_lignes'] = $_GET['page_lignes'];
}

if(isset($_POST['filtreGroupeProjet'])) {
	// si filtre sur les projets, on boucle pour recuperer l'ensemble des projets choisis
	$projetsFiltre = array();
	foreach ($_POST as $keyPost => $valPost) {
		if(strpos($keyPost, 'projet_') === 0) {
			$projetsFiltre[] = $valPost;
		}
	}
	$_SESSION['filtreGroupeProjet'] = $projetsFiltre;
}

if(isset($_POST['filtreTexte'])) {
	$_SESSION['filtreTexte'] = $_POST['filtreTexte'];
}

if(isset($_GET['desactiverFiltreGroupeProjet'])) {
	$_SESSION['filtreGroupeProjet'] = array();
}

if(isset($_GET['desactiverFiltreTexte'])) {
	$_SESSION['filtreTexte'] = "";
}


if(isset($_POST['filtreUser'])) {
	// si filtre sur les Users, on boucle pour recuperer l'ensemble des Users choisis
	$UsersFiltre = array();
	foreach ($_POST as $keyPost => $valPost) {
		if(strpos($keyPost, 'user_') === 0) {
			$UsersFiltre[] = $valPost;
		}
	}
	$_SESSION['filtreUser'] = $UsersFiltre;
}


if(isset($_GET['desactiverFiltreUser'])) {
	$_SESSION['filtreUser'] = array();
}

if(isset($_GET['masquerLigneVide'])) {
	$_SESSION['masquerLigneVide'] = $_GET['masquerLigneVide'];
}

if(isset($_GET['triPlanning'])) {
	$_SESSION['triPlanning'] = $_GET['triPlanning'];
}


if(isset($_POST['filtreStatutTache'])) {
	// si filtre sur les statuts de tache, on boucle pour recuperer l'ensemble des projets choisis
	$filtre = $_POST['statutsTache'];
	// si tous les status sont cochés, revient à desactiver le filtre
	if(count($filtre) >= 4) {
		$filtre = array();
	}
	$_SESSION['filtreStatutTache'] = $filtre;
}


header('Location: ../planning.php');
exit;

?>