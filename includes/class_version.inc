<?php
class Version
{
	public function __construct() {
	}

	public function getVersion() {
		return trim(file_get_contents(BASE . '/../version.txt'));
	}

	public function checkVersion() {

		$infos = array();
		$context = @stream_context_create(array('http' => array('header'=>'Connection: close', 'timeout' => 3)));
		$url = 'http://www.soplanning.org/ws/version.php?version_install=' . $this->getVersion() . '&type=' . substr($_SERVER['DOCUMENT_ROOT'], 0, 1);
		$data = @file_get_contents($url, false, $context);
		if(strlen($data) == 0) {
			return false;
		}

		$infos = array(
			'titre' => '',
			'version_install' => $this->getVersion()
		);
		$data = @unserialize(base64_decode($data));
		if(!$data) {
			return false;
		}
		$infos = array_merge($infos, $data);

		return $infos;
	}

	// upgrade de izi-eye
	public function upgradeVersion() {
		global $cfgConnection, $cfgSqlType, $cfgDatabase;

		if($cfgSqlType != 'mysql') {
			return true;
		}

		// detection de la version de la base. Si derniere version installée, on ne met pas à jour avec tous les upgrades
		$infoVersion = $this->getVersion();
		$config = new Config();
		$result = db_query("show tables from $cfgDatabase like 'planning_config'");
		if(db_num_rows($result) == 0) {
			$result = db_query("show tables from $cfgDatabase like 'planning_periode'");
			if(db_num_rows($result) == 0) {
				die('<br>Your database seems empty or you don\'t have enough rights. Please import soplanning/sql/planning_mysql.sql in your database');
			}
			$versionDemarrage = 118;
		} elseif ($config->db_load(array('cle', '=', 'CURRENT_VERSION')) && $infoVersion == $config->valeur) {
			return true;
		} elseif(!is_null($config->valeur)) {
			$versionDemarrage = (int)str_replace('.', '', $config->valeur) + 1;
		} else {
			$versionDemarrage = 119;
		}

		$upgradeSqlTrouve = false;
		for ($tmpVersion = $versionDemarrage; $tmpVersion<=($infoVersion*100); $tmpVersion = $tmpVersion+1) {
			$tmpVersionFinal = $this->versionFormatee($tmpVersion);

			echo '<br>Upgrade verification for version ' . $tmpVersionFinal;
			$fichierSQL = BASE . '/../sql/update/update-' . str_replace('.', '-', $tmpVersionFinal) . '.txt';
			if (is_file($fichierSQL)) {
				$upgradeSqlTrouve = true;
				$sql = file($fichierSQL);
				$requetes="";
				foreach($sql as $l){ // on lit le fichier sql
					if (substr(trim($l),0,2)!="--"){ // suppression des commentaires
						$requetes .= $l;
					}
				}
				$reqs = explode(";",$requetes);// on sépare les requêtes
				foreach($reqs as $req){	// et on les éxécute
					if (!mysql_query($req, $cfgConnection) && trim($req)!=""){
						echo "<br>Failed to upgrade database, please contact <a href='mailto:support@soplanning.org'>support@soplanning.org</a> with full details."; // stop si erreur 
						echo '<br/>upgrade failed :<br/> ' . $tmpVersionFinal;
						echo '<br/>request failed :<br/> ' . $req;
						die;
					}
				}
				echo '<br>Database upgrade done for version ' . $tmpVersionFinal;

				$config = new Config();
				$config->db_load(array('cle', '=', 'CURRENT_VERSION'));
				$config->cle = 'CURRENT_VERSION';
				$config->valeur = $tmpVersionFinal;
				$config->db_save();
			}
		}
		if (!$upgradeSqlTrouve) {
			// si aucune MAJ trouvée, on met juste à jour l'info de la version courante
			$config = new Config();
			$config->db_load(array('cle', '=', 'CURRENT_VERSION'));
			$config->cle = 'CURRENT_VERSION';
			$config->valeur = $infoVersion;
			$config->db_save();
		}

		return true;
	}

	public function checkPhpVersion() {
		$version = phpversion();
		if($version < '5.2') {
			return false;
		}
		return true;
	}


	public function checkWritable() {
		$errors = array();
		if(!is__writable(BASE . '/../smarty/templates_c/')) {
			die('<b>Error : please add read/write rights on "soplanning/smarty/templates_c" directory</b>');
		}
		return $errors;
	}

	private function versionFormatee($version) {
		$tmpVersionFinal = $version / 100;
		$tmpVersionFinal = str_replace(',', '.', $tmpVersionFinal);
		$decimal = explode('.', $tmpVersionFinal);
		if (!isset($decimal[1])) {$tmpVersionFinal = $tmpVersionFinal . ".00";}
		if (isset($decimal[1]) && strlen($decimal[1]) == 1) {$tmpVersionFinal = $tmpVersionFinal . "0";}
		return $tmpVersionFinal;
	}
}
?>