{* Smarty *}
{include file="www_header.tpl"}

<div class="noprint ligneInfos">
	<div class="span">
	<form action="process/planning.php" method="GET" class="form-inline">
		<label>
			{#formNbMois#} :
		</label>
		<div class="input-append">
			<input name="nb_mois" type="text" size="2" value="{$nbMois}" class="input-mini" style="width:30px;" />
			<button class="btn" type="submit" style="padding-top:2px;"><i class="icon-share-alt"></i></button>
		</div>
		<label style="margin-left:30px;">
			{#formDebut#} :
		</label>
		<div class="input-append">
			<input name="date_debut_affiche" id="date_debut_affiche" type="text" value="{$dateDebut}" class="input-mini datepicker" style="width:70px;" />
			<button class="btn btn-small" type="submit" style="padding-top:4px;"><i class="icon-share-alt"></i></button>
			<script>{literal}addEvent(window, 'load', function(){jQuery("#date_debut_affiche").datepicker()});{/literal}</script>
		</div>
		<label style="margin-left:30px;">
			{#formInfoDateFin#} : {$dateFin}
		</label>
		<label style="margin-left:50px">
			<a class="btn btn-small" onClick="document.location='process/planning.php?date_debut_affiche={$dateBoutonInferieur}';"><i class="icon-backward"></i> {$dateBoutonInferieur}</a>
			<a class="btn btn-small" onClick="document.location='process/planning.php?date_debut_affiche={$dateBoutonSuperieur}';">{$dateBoutonSuperieur} <i class="icon-forward"></i></a>
		</label>
	</form>
	</div>

	{if !in_array("planning_readonly", $user.tabDroits)}
		<div class="span">
			<label style="margin-left:50px">
				<a class="btn btn-info btn-small" href="javascript:Reloader.stopRefresh();xajax_ajoutPeriode();undefined;">
					{if !$smarty.server.HTTP_USER_AGENT|strstr:"MSIE 8.0"}
						<img src="{$BASE}/images/addplanning.png" border="0" style="vertical-align:middle;padding-right:4px;">
					{/if}
					{#menuAjouterPeriode#}
				</a>
			</label>
		</div>
	{/if}

</div>

<br />

<div class="noprint ligneInfos">
	<div class="span">
		{* DIV POUR CHOIX FILTRE USERS *}
		<form action="process/planning.php" method="POST">
		<input type="hidden" name="filtreUser" value="1">
		<div class="btn-group">
			<button class="btn {if $filtreUser|@count > 0}btn-danger{/if} dropdown-toggle btn-small" data-toggle="dropdown">{#formChoixUser#}&nbsp;<span class="caret"></span></button>
			<ul class="dropdown-menu">
				{if $filtreUser|@count > 0}
                    <a href="process/planning.php?desactiverFiltreUser=1" class="btn btn-danger btn-small" style="margin-left:10px;">{#formFiltreUserDesactiver#}</a>
				{/if}
				<li><a onClick="event.cancelBubble=true;" href="javascript:filtreUserCocheTous(true);undefined;">{#formFiltreUserCocherTous#}</a></li>
				<li><a onClick="event.cancelBubble=true;" href="javascript:filtreUserCocheTous(false);undefined;">{#formFiltreUserDecocherTous#}</a></li>
				<li class="divider"></li>
				<li>
					<table onClick="event.cancelBubble=true;" style="margin:10px;">
					<tr>
						<td nowrap="nowrap" valign="top">
							<input type="checkbox" id="gu0" value="1" onClick="filtreCocheUserGroupe('0')" /><label for="gu0" style="display:inline">&nbsp;<b>{#cocheUserSansGroupe#}</b></label>
							{assign var=groupeTemp value=""}

							{math assign=nbColonnes equation="ceil(nbUsers / nbUsersParColonnes)" nbUsers=$listeUsers|@count nbUsersParColonnes=$smarty.const.FILTER_NB_USERS_PER_COLUMN}
							{math assign=maxCol equation="ceil(nbUsers / nbColonnes)" nbUsers=$listeUsers|@count nbColonnes=$nbColonnes}
							{assign var=tmpNbDansColCourante value="0"}
							{foreach from=$listeUsers item=userCourant name=loopUsers}
								{if $tmpNbDansColCourante eq $maxCol}
									{assign var=tmpNbDansColCourante value="0"}
									</td>
									<td nowrap="nowrap" valign="top">
								{else}
									{if $userCourant.user_groupe_id neq $groupeTemp}
										<br /><br />
									{/if}
								{/if}
								{if $userCourant.user_groupe_id neq $groupeTemp}
									<input type="checkbox" id="gu{$userCourant.user_groupe_id}" value="1" onClick="filtreCocheUserGroupe('{$userCourant.user_groupe_id}')" /> <label for="gu{$userCourant.user_groupe_id}" style="display:inline"><b>{$userCourant.groupe_nom}</b></label>
								{/if}
								<br />
								<input type="checkbox" id="user_{$userCourant.user_id}" value="{$userCourant.user_id}" name="user_{$userCourant.user_id}" onClick="checkStatutUserGroupe(this, '{$userCourant.user_groupe_id}')" {if in_array($userCourant.user_id, $filtreUser)}checked="checked"{/if} /> <label for="user_{$userCourant.user_id}" style="display:inline">{$userCourant.nom|escape} ({$userCourant.user_id})</label>
								{assign var=groupeTemp value=$userCourant.user_groupe_id}
								{assign var=tmpNbDansColCourante value=$tmpNbDansColCourante+1}
							{/foreach}
						</td>
					</tr>
					</table>
				</li>
				<li><input type="submit" value="{#submit#}" style="margin-left:10px;" class="btn btn-small" /></li>
			</ul>
		</div>
		</form>
	</div>

	<div class="span">
		{* DIV POUR CHOIX FILTRE PROJETS *}
		<form action="process/planning.php" method="POST">
		<input type="hidden" name="filtreGroupeProjet" value="1">
		<div class="btn-group">
			<button class="btn {if $filtreGroupeProjet|@count > 0}btn-danger{/if} dropdown-toggle btn-small" data-toggle="dropdown">{#formChoixProjet#}&nbsp;<span class="caret"></span></button>
			<ul class="dropdown-menu">
				{if $listeProjets|@count eq 0}
					<li>&nbsp;&nbsp;{#formFiltreProjetAucunProjet#}</li>
				{else}
					{if $filtreGroupeProjet|@count > 0}
						<a href="process/planning.php?desactiverFiltreGroupeProjet=1" class="btn btn-danger btn-small" style="margin-left:10px;">{#formFiltreProjetDesactiver#}</a>
					{/if}
					<li><a onClick="event.cancelBubble=true;" href="javascript:filtreGroupeProjetCocheTous(true);undefined;">{#formFiltreProjetCocherTous#}</a></li>
					<li><a onClick="event.cancelBubble=true;" href="javascript:filtreGroupeProjetCocheTous(false);undefined;">{#formFiltreProjetDecocherTous#}</a></li>
					<li class="divider"></li>
					<li>
						<table onClick="event.cancelBubble=true;" style="margin:10px;">
						<tr>
							<td nowrap="nowrap" valign="top">
								<input type="checkbox" id="g0" value="1" onClick="filtreCocheGroupe('0')" /><label for="g0" style="display:inline">&nbsp;<b>{#projet_liste_sansGroupes#}</b></label>
								{assign var=groupeTemp value=""}
								{math assign=nbColonnes equation="ceil(nbProjets / nbProjetsParColonnes)" nbProjets=$listeProjets|@count nbProjetsParColonnes=$smarty.const.FILTER_NB_PROJECTS_PER_COLUMN}
								{math assign=maxCol equation="ceil(nbProjets / nbColonnes)" nbProjets=$listeProjets|@count nbColonnes=$nbColonnes}
								{assign var=tmpNbDansColCourante value="0"}
								{foreach from=$listeProjets item=projetCourant name=loopProjets}
									{if $tmpNbDansColCourante eq $maxCol}
										{assign var=tmpNbDansColCourante value="0"}
										</td>
										<td nowrap="nowrap" valign="top">
									{else}
										{if $projetCourant.groupe_id neq $groupeTemp}
											<br /><br />
										{/if}
									{/if}
									{if $projetCourant.groupe_id neq $groupeTemp}
										<input type="checkbox" id="g{$projetCourant.groupe_id}" value="1" onClick="filtreCocheGroupe('{$projetCourant.groupe_id}')" /> <label for="g{$projetCourant.groupe_id}" style="display:inline"><b>{$projetCourant.groupe_nom}</b></label>
									{/if}
									<br />
									<input type="checkbox" id="projet_{$projetCourant.projet_id}" value="{$projetCourant.projet_id}" name="projet_{$projetCourant.projet_id}" onClick="checkStatutGroupe(this, '{$projetCourant.groupe_id}')" {if in_array($projetCourant.projet_id, $filtreGroupeProjet)}checked="checked"{/if} /> <label for="projet_{$projetCourant.projet_id}" style="display:inline">{$projetCourant.nom|escape} ({$projetCourant.projet_id})
									{assign var=groupeTemp value=$projetCourant.groupe_id}</label>
									{assign var=tmpNbDansColCourante value=$tmpNbDansColCourante+1}
								{/foreach}
							</td>
						</tr>
						</table>
					</li>
					<li><input type="submit" value="{#submit#}" style="margin-left:10px;" class="btn" /></li>
				{/if}
			</ul>
		</div>
		</form>
	</div>

	<div class="span">
		{* DIV POUR CHOIX FILTRE STATUT TACHES *}
		<form action="process/planning.php" method="POST">
		<input type="hidden" name="filtreStatutTache" value="1">
		<div class="btn-group">
			<button class="btn {if $filtreStatutTache|@count > 0}btn-danger{/if} dropdown-toggle btn-small" data-toggle="dropdown">{#formChoixStatutTache#}&nbsp;<span class="caret"></span></button>
			<ul class="dropdown-menu">
				<li>
					<table onClick="event.cancelBubble=true;" style="margin:10px;">
					<tr>
						<td nowrap="nowrap" valign="top">
							<input type="checkbox" id="a_faire" name="statutsTache[]" value="a_faire" {if in_array('a_faire', $filtreStatutTache)}checked="checked"{/if} /><label for="a_faire" style="display:inline">&nbsp;{#winPeriode_statut_a_faire#}</label><br />
							<input type="checkbox" id="en_cours" name="statutsTache[]" value="en_cours" {if in_array('en_cours', $filtreStatutTache)}checked="checked"{/if} /><label for="en_cours" style="display:inline">&nbsp;{#winPeriode_statut_en_cours#}</label><br />
							<input type="checkbox" id="fait" name="statutsTache[]" value="fait" {if in_array('fait', $filtreStatutTache)}checked="checked"{/if} /><label for="fait" style="display:inline">&nbsp;{#winPeriode_statut_fait#}</label><br />
							<input type="checkbox" id="abandon" name="statutsTache[]" value="abandon" {if in_array('abandon', $filtreStatutTache)}checked="checked"{/if} /><label for="abandon" style="display:inline">&nbsp;{#winPeriode_statut_abandon#}</label>
						</td>
					</tr>
					</table>
				</li>
				<li><input type="submit" value="{#submit#}" style="margin-left:10px;" class="btn" /></li>
			</ul>
		</div>
		</form>
	</div>

	<div class="span">
		{* DIV POUR TRI AFFICHAGE *}
		<div class="btn-group">
			<button class="btn dropdown-toggle btn-small" data-toggle="dropdown">{#formTrierPar#}&nbsp;<span class="caret"></span></button>
			<ul class="dropdown-menu">
				{if $inverserUsersProjets}
					{foreach from=$triPlanningPossibleProjet item=triTemp}
						{assign var=chaineTmp value="triProjet_"|cat:$triTemp|replace:' ':'_'|replace:',':'_'}
						<li {if $triTemp eq $triPlanning}class="active"{/if}><a href="process/planning.php?triPlanning={$triTemp|urlencode}">{$smarty.config.$chaineTmp}</a></li>
					{/foreach}
				{else}
					{foreach from=$triPlanningPossibleUser item=triTemp}
						{assign var=chaineTmp value="triUser_"|cat:$triTemp|replace:' ':'_'|replace:',':'_'}
						<li {if $triTemp eq $triPlanning}class="active"{/if}><a href="process/planning.php?triPlanning={$triTemp|urlencode}">{$smarty.config.$chaineTmp}</a></li>
					{/foreach}
				{/if}
			</ul>
		</div>
	</div>

	<div class="span">
		{* DIV POUR RECHERCHE TEXTE *}
		<form action="process/planning.php" method="POST" class="form-inline">
			<div class="input-append">
				<input type="text" name="filtreTexte" value="{$filtreTexte|escape:"html"}" class="input-medium span4 inputCustom" maxlength="50" rel="tooltip" title="{#formFiltreTexte#|escape}" id="filtreTexte" style="width:80px">
				<button class="btn {if $filtreTexte != ""}btn-danger{/if} btn-small" type="submit" style="padding-top:4px;"><i class="icon-search"></i></button>
				{if $filtreTexte != ""}
					<div class="btn-group">
						<button class="btn dropdown-toggle" data-toggle="dropdown" >&nbsp;<span class="caret"></span></button>
						<ul class="dropdown-menu">
							<li><a href="process/planning.php?desactiverFiltreTexte=1">{#formFiltreUserDesactiver#}</a></li>
						</ul>
					</div>
				{/if}
			</div>
		</form>
	</div>

	<div class="span">
		<div class="btn-group">
			<a href="javascript:window.print();" class="btn" id="btPrint" rel="tooltip" title="{#printAll#|escape}"><img align="absbottom" border="0" src="images/printButton.png"></a>
			<a href="export_csv.php" class="btn" id="btCSVexport" rel="tooltip" title="{#CSVExport#|escape}"><img align="absbottom" border="0" src="images/CSVIcon.gif"></a>
			<a href="javascript:xajax_choixPDF();undefined;" class="btn" id="btChoixPDF" rel="tooltip" title="{#PDFExport#|escape}"><img align="absbottom" border="0" src="images/pdf.png"></a>
			<a href="export_gantt.php" target="_blank" class="btn" rel="tooltip" title="{#ganttExport#|escape}"><img align="absbottom" border="0" src="images/gantt.png"></a>
			<a href="export_pdf_calendrier.php" target="_blank" class="btn" rel="tooltip" title="{#calendarExport#|escape}"><img align="absbottom" border="0" src="images/calendar.png"></a>
			<a href="javascript:xajax_choixIcal();undefined;" class="btn" rel="tooltip" title="{#icalExport#|escape}"><img align="absbottom" border="0" src="images/ical.png"></a>
			{if $affichageLarge eq 0}
				<a href="?affichageLarge=1" class="btn" rel="tooltip" title="{#affichageReduit#|escape}"><img align="absbottom" border="0" src="images/scroll.png"></a>
			{else}
				<a href="?affichageLarge=1" class="btn" rel="tooltip" title="{#affichageReduit#|escape}"><img align="absbottom" border="0" src="images/scroll.png"></a>
			{/if}
		</div>
	</div>

</div>

<br />

{* le planning *}
<table id="tabPlanning" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td valign="top" width="100" align="right">
		<table id="layerPersonnes" border="0" cellpadding="0" cellspacing="1">
			<tbody id="bodyLayerPersonnes">
				<tr id="loadingLayerPersonnes">
					<td align="center" class="entete" nowrap="nowrap"><br /><br />{#loading#}<br /><br /><br /></td>
				</tr>
			</tbody>
		</table>
	</td>
	<td valign="top">
		<div id="divConteneurPlanning" {if $affichageLarge eq 0}style="width:700px; overflow-x:scroll"{/if}>
			{$htmlTableau}
		</div>
	</td>
</tr>
</table>

{* PAGINATION *}
<div class="row-fluid noprint ligneInfos" style="margin-top:5px;">
{if $nbPagesLignes > 1}
	<div class="span2">
		<div class="pagination">
			<ul>
			{section loop=$nbPagesLignes name=loopPages}
				{if $pageLignes eq $smarty.section.loopPages.iteration}				
					<li class="active">
						<a href="#">{$smarty.section.loopPages.iteration}</a>
					</li>
					{else}
					<li>
						<a href="{$BASE}/process/planning.php?page_lignes={$smarty.section.loopPages.iteration}">{$smarty.section.loopPages.iteration}</a>
					</li>
					{/if}
					{if !$smarty.section.loopPages.last}
						
					{/if}
				{/section}						
			</ul>
		</div>					
	</div>
{/if}				
	<div class="span2">
		<div class="btn-group">
			<a class="btn dropdown-toggle btn-small" data-toggle="dropdown" href="#">{$nbLignes} {#planning_nbLignes#} <span class="caret"></span></a>
			{assign var=tabPages value=","|explode:$smarty.const.CONFIG_PLANNING_PAGES}
			<ul class="dropdown-menu">
				{foreach from=$tabPages item=valTemp}
				<li>
					<a onClick="top.location='{$BASE}/process/planning.php?nb_lignes='+{$valTemp}"">{$valTemp} {#planning_nbLignes#}</a>
				</li>
				{/foreach}
			</ul>
		</div>
	</div>							
	<div class="span2">				
		<div class="btn-group">
			<a class="btn dropdown-toggle btn-small {if $masquerLigneVide eq 1}btn-danger{/if}" data-toggle="dropdown" href="#">{#planning_masquerLignesVides#} <span class="caret"></span></a>
			{assign var=tabPages value=","|explode:$smarty.const.CONFIG_PLANNING_PAGES}
			<ul class="dropdown-menu">
				 {if $masquerLigneVide eq 1}
				<li>
					<a onClick="top.location='process/planning.php?masquerLigneVide=0'">{#planning_masquerLignesVides_non#}</a>
				</li>
				 {else}
				<li>
					<a onClick="top.location='process/planning.php?masquerLigneVide=1'">{#planning_masquerLignesVides_oui#}</a>
				</li>
				{/if} 
			</ul>
		</div>				
	</div>
	<div class="span2">				
		<div class="btn-group">
			<a class="btn dropdown-toggle btn-small" data-toggle="dropdown"  onclick="javascript:toggle2('divProjectTable');" >{#hide_show_table#}</a>
		</div>				
	</div>	
</div>
{* PAGINATION *}

<div style="page-break-after:always;"></div>

{$htmlRecap}

{* CODE POUR PALETTE DE COULEUR *}
{* div affichant la palette *}
<div id="plugin" onmousedown="HSVslide('drag','plugin',event)" style="TOP: 140px; LEFT: 430px; Z-INDEX: 20;display:none;">
	<div id="plugHEX" onmousedown="stop=0; setTimeout('stop=1',100);">F1FFCC</div><div id="plugCLOSE" onmousedown="togglePalette();">X</div><br>
	<div id="SV" onmousedown="HSVslide('SVslide','plugin',event)" title="Saturation + Value">
	<div id="SVslide" style="TOP: -4px; LEFT: -4px;"><br /></div>
	</div>
	<form id="H" onmousedown="HSVslide('Hslide','plugin',event)" title="Hue">
	<div id="Hslide" style="TOP: -7px; LEFT: -8px;"><br /></div>
	<div id="Hmodel"></div>
	</form>
</div>
{* FIN PALETTE DE COULEUR *}


{* GESTION DU DRAG N DROP *}
{literal}
<script language="javascript">
destinationsDrag = new Array();

var origineCaseX;
var origineCaseY;
function modifPeriode(obj, periode_id){
	if(origineCaseX != parseInt(obj.style.left) || origineCaseY != parseInt(obj.style.top)) {
		return false;
	}
	xajax_modifPeriode(periode_id);
}

{/literal}
{$js}
{literal}

</script>
{/literal}
{* FIN GESTION DU DRAG N DROP *}



{* JAVASCRIPT POUR CHOIX FILTRE PROJETS *}
<script language="javascript">
var listeProjets = new Array();
listeProjets[0] = new Array();
{assign var=groupeTemp value=""}
{foreach from=$listeProjets item=projetCourant}
	{if $projetCourant.groupe_id neq $groupeTemp}
		listeProjets[{$projetCourant.groupe_id}] = new Array();
	{/if}
	{if $projetCourant.groupe_id eq ''}
		listeProjets[0].push('{$projetCourant.projet_id}');
	{else}
		listeProjets[{$projetCourant.groupe_id}].push('{$projetCourant.projet_id}');
	{/if}
	{assign var=groupeTemp value=$projetCourant.groupe_id}
{/foreach}

{literal}
// coche ou decoche tous les projets
function filtreGroupeProjetCocheTous(action) {
	for (var groupe in listeProjets) {
		if (!document.getElementById('g' + groupe)) {
			// si pas une case à cocher existantes, on sort
			continue;
		}
		document.getElementById('g' + groupe).checked = action;
		for (var projet in listeProjets[groupe]) {
			if (!document.getElementById('projet_' + listeProjets[groupe][projet])) {
				// si pas une case à cocher existantes, on sort
				continue;
			}
			document.getElementById('projet_' + listeProjets[groupe][projet]).checked = action;
		}
	}
}

// coche ou decoche les projets d'un groupe
function filtreCocheGroupe(groupe) {
	var action = document.getElementById('g' + groupe).checked;
	for (var projet in listeProjets[groupe]) {
		if (!document.getElementById('projet_' + listeProjets[groupe][projet])) {
			// si pas une case à cocher existantes, on sort
			continue;
		}
		document.getElementById('projet_' + listeProjets[groupe][projet]).checked = action;
	}
}

// decoche le groupe si on decoche un projet
function checkStatutGroupe(obj, groupe) {
	if (groupe == '') {
		groupe = '0';
	}
	if (!obj.checked) {
		document.getElementById('g' + groupe).checked = false;
	}
}

{/literal}
</script>
{* FIN JAVASCRIPT POUR CHOIX FILTRE PROJETS *}



{* MENU POUR CHOIX ACTION APRES DRAG AND DROP CASE *}
<script language="javascript">
	var idCaseEnCoursDeplacement = false;
	var idCaseDestination = false;
</script>

<div id="divChoixDragNDrop" style="border: 1px solid #000000;background-color:#ffffff;position:absolute;z-index:100;display:none;padding:10px;" onMouseOut="masquerMenuDelai();" onMouseOut="masquerSousMenuDelai('divChoixDragNDrop');" onMouseOver="AnnuleMasquerSousMenu('divChoixDragNDrop');" onfocus="AnnuleMasquerSousMenu('divChoixDragNDrop')">
	<a href="javascript:windowPatienter();xajax_moveCasePeriode(idCaseEnCoursDeplacement, destination, false);undefined;">{#planning_deplacer#}</a>
	<br /><br />
	<a href="javascript:windowPatienter();xajax_moveCasePeriode(idCaseEnCoursDeplacement, destination, true);undefined;">{#planning_copier#}</a>
	<br /><br />
	<a href="javascript:location.reload();undefined;">{#planning_annuler#}</a>
</div>

{* JAVASCRIPT POUR CHOIX FILTRE USERS *}
<script language="javascript">
var listeUsers = new Array();
listeUsers[0] = new Array();
{assign var=groupeTemp value=""}
{foreach from=$listeUsers item=userCourant}
	{if $userCourant.user_groupe_id neq $groupeTemp}
		listeUsers[{$userCourant.user_groupe_id}] = new Array();
	{/if}
	{if $userCourant.user_groupe_id eq ''}
		listeUsers[0].push('{$userCourant.user_id}');
	{else}
		listeUsers[{$userCourant.user_groupe_id}].push('{$userCourant.user_id}');
	{/if}
	{assign var=groupeTemp value=$userCourant.user_groupe_id}
{/foreach}


{literal}
// coche ou decoche tous les Users
function filtreUserCocheTous(action) {
	for (var groupe in listeUsers) {
		if (!document.getElementById('gu' + groupe)) {
			// si pas une case à cocher existantes, on sort
			continue;
		}
		document.getElementById('gu' + groupe).checked = action;
		for (var user in listeUsers[groupe]) {
			if (!document.getElementById('user_' + listeUsers[groupe][user])) {
				// si pas une case à cocher existantes, on sort
				continue;
			}
			document.getElementById('user_' + listeUsers[groupe][user]).checked = action;
		}
	}
}

// coche ou decoche les users d'un groupe
function filtreCocheUserGroupe(groupe) {
	var action = document.getElementById('gu' + groupe).checked;
	for (var user in listeUsers[groupe]) {
		if (!document.getElementById('user_' + listeUsers[groupe][user])) {
			// si pas une case à cocher existantes, on sort
			continue;
		}
		document.getElementById('user_' + listeUsers[groupe][user]).checked = action;
	}
}

// decoche le groupe si on decoche un user
function checkStatutUserGroupe(obj, groupe) {
	if (groupe == '') {
		groupe = '0';
	}
	if (!obj.checked) {
		document.getElementById('gu' + groupe).checked = false;
	}
}
{/literal}
</script>
{* FIN JAVASCRIPT POUR CHOIX FILTRE USERS *}


{* FONCTION POUR COPIER LE TABLEAU DES PERSONNES *}
<script language="javascript">
{literal}
function copierTableauPersonnes () {
	document.getElementById('loadingLayerPersonnes').style.display = 'none';

	// on adapte le div à la largeur de la fenetre
	document.getElementById('divConteneurPlanning').style.width = document.body.offsetWidth - 80 - document.getElementById('tdUser_0').offsetWidth + 'px';

	// recopie de la premiere case
	trTemp = document.createElement("tr");
	thTemp = document.createElement("th");
	thTemp.setAttribute('id', 'tdUserCopie_0');
	trTemp.appendChild(thTemp);
	document.getElementById('bodyLayerPersonnes').appendChild(trTemp);
	document.getElementById('tdUserCopie_0').style.height = document.getElementById('tdUser_0').offsetHeight + 'px';
	document.getElementById('tdUserCopie_0').innerHTML = '<a id="lienInverse" href="?inverserUsersProjets={/literal}{if $inverserUsersProjets eq 0}1{else}0{/if}{literal}"><img src="images/switch.png" border="0" /></a>';

	var table = document.getElementById("tabContenuPlanning");
	numeroCellule = 1;
	for (var i = 4, row; row = table.rows[i]; i++) {
		for (var j = 0, col; col = row.cells[j]; j++) {
			if (j == 0) {
				thACopier = col.cloneNode(true);
				thACopier.setAttribute('id', 'tdUserCopie_' + numeroCellule);
				trTemp = document.createElement("tr");
				trTemp.appendChild(thACopier);
				document.getElementById('bodyLayerPersonnes').appendChild(trTemp);
				document.getElementById('tdUserCopie_' + numeroCellule).style.height = col.offsetHeight + 'px';
				numeroCellule++;
				col.style.display = 'none';
			}
		}
	}

	document.getElementById("tdUser_0").style.display = 'none';
}
{/literal}
</script>
{* FONCTION POUR COPIER LE TABLEAU DES PERSONNES *}

<script language="javascript">
{literal}
addEvent(window, 'load', copierTableauPersonnes);

Reloader.init({/literal}{$smarty.const.CONFIG_REFRESH_TIMER}{literal});
{/literal}

{* textes pour erreur dans fichier JS *}
var js_choisirProjet = '{#js_choisirProjet#|escape:"javascript"}';
var js_choisirDateDebut = '{#js_choisirDateDebut#|escape:"javascript"}';
var js_saisirFormatDate = '{#js_saisirFormatDate#|escape:"javascript"}';
var js_dateFinInferieure = '{#js_dateFinInferieure#|escape:"javascript"}';
var js_saisirIDProjet = '{#js_saisirIDProjet#|escape:"javascript"}';
var js_saisirNomProjet = '{#js_saisirNomProjet#|escape:"javascript"}';
var js_saisirCouleur = '{#js_saisirCouleur#|escape:"javascript"}';
var js_saisirCharge = '{#js_saisirCharge#|escape:"javascript"}';
var js_saisirSemaine = '{#js_saisirSemaine#|escape:"javascript"}';
var js_deposerCaseSurDate = '{#js_deposerCaseSurDate#|escape:"javascript"}';
var js_deplacementOk = '{#js_deplacementOk#|escape:"javascript"}';
var js_patienter = '{#js_patienter#|escape:"javascript"}';

{literal}
jQuery(function () {
	jQuery("[rel='tooltip']").tooltip();
});
{/literal}
</script>

{include file="www_footer.tpl"}