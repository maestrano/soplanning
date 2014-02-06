{* Smarty *}
{include file="www_header.tpl"}

<div class="row-fluid noprint ligneInfos">
	<div class="span3" style="width:340px">
		{if in_array("projectgroups_manage_all", $user.tabDroits)}
			<a href="groupe_list.php" class="btn btn-small"><img src="images/groupes.png" border="0"> {#menuListeGroupes#}</a>
		{/if}
		<a href="javascript:xajax_ajoutProjet('projets');undefined;" class="btn btn-small" style="margin-left:10px;"><img src="images/addprojet.png" border="0"> {#menuAjouterProjet#}</a>
	</div>

	<form action="projets.php" method="GET" class="form-inline">
	<div class="span2" style="width:300px;">
		<label>{#projet_liste_afficherProjets#} :</label>
		&nbsp;
		<input type="radio" name="filtrageProjet" id="filtrageTous" onClick="top.location='?filtrageProjet=tous';" {if $filtrageProjet eq "tous"}checked="checked"{/if}> <label for="filtrageTous">{#projet_liste_afficherProjetsTous#}</label>
		&nbsp;&nbsp;&nbsp;
		<input type="radio" name="filtrageProjet" id="filtrageDate" onClick="top.location='?filtrageProjet=date';" {if $filtrageProjet neq "tous"}checked="checked"{/if}> <label for="filtrageDate">{#projet_liste_afficherProjetsParDate#}</label>
	</div>
	<div class="span6" id="divDates" {if $filtrageProjet eq "tous"}style="display:none"{/if}>
		<label>
			&nbsp;&nbsp;&nbsp;
		</label>
		<label>
			{#formNbMois#}:
		</label>
		<div class="input-append">
			<input name="nb_mois" type="text" size="2" value="{$nbMois}" class="input-mini span4" />
			<button class="btn btn-small" type="submit"><i class="icon-share-alt"></i></button>
		</div>
		<label>
			{#formDebut#}:
		</label>
		<div class="input-append">
			<input name="date_debut_affiche" id="date_debut_affiche" type="text" value="{$dateDebut}" class="input-mini span6 datepicker" />
			<button class="btn btn-small" type="submit"><i class="icon-share-alt"></i></button>
			<script>{literal}addEvent(window, 'load', function(){jQuery("#date_debut_affiche").datepicker()});{/literal}</script>
		</div>
		<label>
			{#formInfoDateFin#} : {$dateFin}
		</label>
	</div>
	</form>
</div>

<br />

<div class="row-fluid noprint ligneInfos">
	<form action="" method="GET" class="form-inline">
		{#projet_liste_afficherProjets#} :
		<input style="margin-left:20px;" type="checkbox" name="statut[]" id="a_faire" value="a_faire" {if in_array('a_faire', $listeStatuts)}checked="checked"{/if}> <label for="a_faire">{#projet_liste_statutAfaire#}</label>
		<input style="margin-left:20px;" type="checkbox" name="statut[]" id="en_cours" value="en_cours" {if in_array('en_cours', $listeStatuts)}checked="checked"{/if}> <label for="en_cours">{#projet_liste_statutEnCours#}</label>
		<input style="margin-left:20px;" type="checkbox" name="statut[]" id="fait" value="fait" {if in_array('fait', $listeStatuts)}checked="checked"{/if}> <label for="fait">{#projet_liste_statutFait#}</label>
		<input style="margin-left:20px;" type="checkbox" name="statut[]" id="abandon" value="abandon" {if in_array('abandon', $listeStatuts)}checked="checked"{/if}> <label for="abandon">{#projet_liste_statutAbandon#}</label>
		<input style="margin-left:20px;" type="submit" value="{#formAfficher#|escape:"html"}" class="btn" />

		<input style="margin-left:80px;" type="text" size="12" maxlength="30" name="rechercheProjet" value="{$rechercheProjet|default:""}" />
		<input type="submit" value="{#projet_liste_chercher#}" class="btn {if $rechercheProjet neq ""}btn-danger{/if}" />
	</form>
</div>

<br />


<br />

<table class="table table-striped" style="width:980px;">
<tr style="font-weight:bold;">
	<td colspan="2" align="center">{#projet_liste_projet#}</td>
	<td align="center">{#projet_liste_createur#}</td>
	<td align="center">{#projet_liste_charge#}</td>
	<td align="center">{#projet_liste_livraison#}</td>
	<td align="center">{#projet_liste_commentaires#}</td>
</tr>
<tr>
	<td colspan="6" style="font-size:14px; background-color:#ECE9D8;"><b>{#projet_liste_sansGroupes#}</b></td>
</tr>
{assign var=groupeCourant value=""}
{foreach from=$projets item=projet}
	{if $projet.groupe_id neq $groupeCourant}
		<td colspan="6" style="font-size:14px; background-color:#ECE9D8;"><b>{$projet.nom_groupe|xss_protect}</b></td>		
	{/if}
	{if $projet.statut eq "a_faire"}
		{assign var=couleurLigne value="#ffffff"}
	{elseif $projet.statut eq "en_cours"}
		{assign var=couleurLigne value="#B0FB04"}
	{elseif $projet.statut eq "fait"}
		{assign var=couleurLigne value="#FFBE7D"}
	{elseif $projet.statut eq "abandon"}
		{assign var=couleurLigne value="#9D9D9D"}
	{/if}
	<tr style="background-color:{$couleurLigne};" onMouseOver="javascript:this.style.backgroundColor='#EEEEEE'" onMouseOut="javascript:this.style.backgroundColor='{$couleurLigne}'">
		<td width="25" style="font-size:8px;background-color:#{$projet.couleur};color:{"#"|cat:$projet.couleur|buttonFontColor}">{$projet.projet_id}</td>
		<td>
			{if in_array("projects_manage_all", $user.tabDroits) || (in_array("projects_manage_own", $user.tabDroits) && $projet.createur_id eq $user.user_id)}
				<a onClick="javascript:xajax_modifProjet('{$projet.projet_id}', 'projets');undefined;" style="cursor:pointer;"><img src="{$BASE}/images/edit.gif" border="0" width="16" height="16" alt="Modifier" align="absbottom" /></a>
				&nbsp;
				<a href="{$BASE}/process/projet.php?projet_id={$projet.projet_id}&action=delete&origine=projets" onClick="javascript:return confirm('{#projet_liste_confirmSuppr#|escape:"javascript"}')"><img src="{$BASE}/images/delete.gif" border="0" width="16" height="16" alt="supprimer"  align="absbottom" /></a>
			{/if}
			&nbsp;
			{$projet.nom|xss_protect}
		</td>
		<td>
			{$projet.nom_createur|xss_protect}
		</td>
		<td width="80" align="center">{$projet.charge}</td>
		<td width="80" align="center">
			{if $projet.livraison neq '' && $projet.livraison neq '0000-00-00'}
				<a href="planning.php?livraison={$projet.livraison}">{$projet.livraison|sqldate2userdate}</a>
			{/if}
		</td>
		<td>{$projet.iteration|xss_protect}</td>
	</tr>
	{assign var=groupeCourant value=$projet.groupe_id}
{/foreach}
</table>


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

{include file="www_footer.tpl"}