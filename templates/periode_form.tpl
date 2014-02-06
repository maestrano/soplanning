{* Smarty *}

<form action="" method="POST" onSubmit="return false;">
<input type="hidden" id="periode_id" name="periode_id" value="{$periode.periode_id}" />
<input type="hidden" id="saved" name="saved" value="{$periode.saved}" />

<table width="100%" style="padding:2px;">
<tr>
	<td width="100" align="right">{#winPeriode_projet#} :</td>
	<td>
		<select name="projet_id" id="projet_id" class="span3">
			<option value="">- - - - - - - - - - - - - - - -</option>
			{foreach from=$listeProjets item=projet}
				<option value="{$projet.projet_id}" {if $periode.projet_id eq $projet.projet_id}selected="selected"{/if}>{$projet.nom} ({$projet.projet_id}) {if $projet.livraison neq ''} - S{$projet.livraison}{/if}</option>
			{/foreach}
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		{#winPeriode_filtrage#} :
		<input type="text" id="chercherProjet" maxlength="8" onKeyUp="xajax_filtreProjet(this.value);" style="display:inline;width:40px;" />
	</td>
</tr>
<tr>
	<td align="right">{#winPeriode_user#} :</td>
	<td>
		<select name="user_id" id="user_id">
		{foreach from=$listeUsers item=userTmp}
			<option value="{$userTmp.user_id}" {if $periode.user_id eq $userTmp.user_id}selected="selected"{/if} {if isset($user_id_choisi) && $user_id_choisi eq $userTmp.user_id}selected="selected"{/if}>{$userTmp.nom} - {$userTmp.user_id}</option>
		{/foreach}
		</select>
		{if isset($estFilleOuParente)}
			<br />
			<input type="checkbox" checked="checked" id="appliquerATous" value="1">	{#winPeriode_appliquerATous#}
		{/if}
	</td>
</tr>
<tr>
	<td align="right">{#winPeriode_debut#} :</td>
	<td>
		<input type="text" name="date_debut" id="date_debut" size="11" maxlength="10" value="{$periode.date_debut|sqldate2userdate}" style="width:80px" class="datepicker" />
		{if $periode.periode_id neq 0}
			&nbsp;&nbsp;&nbsp;<input type="checkbox" id="conserver_duree" name="conserver_duree" value="1" onClick="toggle2('bloc_date_fin');" /> <label for="conserver_duree" style="display:inline;font-size:12px">{#winPeriode_conserverDuree#|sprintf:$nbJours}</label>
		{else}
			<input type="hidden" id="conserver_duree" value="" />
		{/if}
	</td>
</tr>
<tr id="bloc_date_fin">
	<td align="right" valign="middle">{#winPeriode_fin#} :</td>
	<td>
		<input type="text" name="date_fin" id="date_fin" size="11" maxlength="10" value="{$periode.date_fin|sqldate2userdate}" onFocus="remplirDateFinPeriode();" style="width:80px" class="datepicker" />
		&nbsp;{#winPeriode_ouNBHeures#} <a onmouseover="return coolTip('{#winPeriode_FormatDuree#|escape:"quotes"}', WIDTH, 200)"  onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a> : <input type="text" name="duree" id="duree" size="3" maxlength="5" value="{$periode.duree|sqltime2usertime}" style="width:36px" />
		{if $periode.periode_id eq 0}
			&nbsp;{#winPeriode_ouNBJours#} :
			<input type="text" name="nb_jours" id="nb_jours" size="1" maxlength="2" style="width:30px" />
		{else}
			<input type="hidden" id="nb_jours" value="" />
		{/if}
	</td>
</tr>
{if $periode.periode_id eq 0}
	<input type="hidden" id="appliquerATous" value="0">
	<tr>
		<td align="right">{#winPeriode_repeter#} :</td>
		<td>
			<select name="repetition" id="repetition" onChange="{literal}if(this.value!=''){$('divDateFinRepetition').style.display='inline';}else{$('divDateFinRepetition').style.display='none';}{/literal}">
				<option value="">- - - - - - - - - - - - - - -</option>
				<option value="jour">{#winPeriode_repeter_jour#}</option>
				<option value="semaine">{#winPeriode_repeter_semaine#}</option>
				<option value="mois">{#winPeriode_repeter_mois#}</option>
			</select>
			<span id="divDateFinRepetition" style="display:none;">
				&nbsp;&nbsp;&nbsp;
				{#winPeriode_repeter_jusque#}
				<input type="text" id="dateFinRepetition" value="" size="11" maxlength="10" style="width:80px" class="datepicker">
			</span>
		</td>
	</tr>
{elseif isset($estFilleOuParente)}
	<input type="hidden" id="repetition" value="">
	<input type="hidden" id="dateFinRepetition" value="">
	<tr>
		<td align="right">&nbsp;</td>
		<td>
			<b>{#winPeriode_recurrente#}{$prochaineOccurence|sqldate2userdate}</b><br />
		</td>
	</tr>
{else}
	<input type="hidden" id="appliquerATous" value="0">
	<input type="hidden" id="repetition" value="">
	<input type="hidden" id="dateFinRepetition" value="">
{/if}
<tr>
	<td align="right">{#winPeriode_statut#} :</td>
	<td>
		<select name="statut_tache" id="statut_tache">
			<option value="a_faire" {if $periode.statut_tache eq "a_faire"}selected="selected"{/if}>{#winPeriode_statut_a_faire#}</option>
			<option value="en_cours" {if $periode.statut_tache eq "en_cours"}selected="selected"{/if}>{#winPeriode_statut_en_cours#}</option>
			<option value="fait" {if $periode.statut_tache eq "fait"}selected="selected"{/if}>{#winPeriode_statut_fait#}</option>
			<option value="abandon" {if $periode.statut_tache eq "abandon"}selected="selected"{/if}>{#winPeriode_statut_abandon#}</option>
		</select>
	</td>
</tr>
<tr>
	<td align="right">{#winPeriode_livrable#} :</td>
	<td>
		<select name="livrable" id="livrable">
			<option value="oui" {if $periode.livrable eq "oui"}selected="selected"{/if}>{#oui#}</option>
			<option value="non" {if $periode.livrable eq "non"}selected="selected"{/if}>{#non#}</option>
		</select>
	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap">{#winPeriode_titre#} :</td>
	<td>
		<div class="ui-widget">
			<label for="titre"></label>
			<input type="text" name="titre" id="titre" size="40" maxlength="2000" value="{$periode.titre|escape}" onFocus="xajax_autocompleteTitreTache($('projet_id').value);" />
		</div>
	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap">{#winPeriode_commentaires#} :</td>
	<td>
		<textarea style="width:360px;height:36px;" id="notes" name="notes" class="textareaAuto">{$periode.notes_xajax|escape:"html"}</textarea>
	</td>
</tr>
<tr>
	<td align="right" nowrap="nowrap">{#winPeriode_lien#} :</td>
	<td>
		<div class="input-append">
			<input type="text" name="lien" id="lien" size="40" maxlength="2000" value="{$periode.lien}" style="width:318px" />
			{if $periode.lien neq ""}
				<a class="btn btn-small" type="submit" style="padding-top:4px;" id="btnGotoLien" rel="tooltip" title="{#winPeriode_gotoLien#|escape}" href="{if $periode.lien|strpos:"http" !== 0 && $periode.lien|strpos:"\\" !== 0}http://{/if}{$periode.lien}" target="_blank"><i class="icon-share"></i></a>
			{/if}
		</div>
	</td>
</tr>
<tr>
	<td align="right">{#winPeriode_user2#} :</td>
	<td>
		<select name="user_id2">
			<option selected="selected" value="">- - - - - - - - - - - -</option>
			{foreach from=$listeUsers item=userTmp}
				<option value="{$userTmp.user_id}">{$userTmp.nom} - {$userTmp.user_id}</option>
			{/foreach}
		</select>
	</td>
</tr>
<tr>
	<td align="right">{#winPeriode_user3#} :</td>
	<td>
		<select name="user_id3">
			<option selected="selected" value="">- - - - - - - - - - - -</option>
			{foreach from=$listeUsers item=userTmp}
				<option value="{$userTmp.user_id}">{$userTmp.nom} - {$userTmp.user_id}</option>
			{/foreach}
		</select>
	</td>
</tr>
{if !in_array("planning_readonly", $user.tabDroits)}
	<tr>
		<td>&nbsp;</td>
		<td>
			<table width="100%">
			<tr>
				<td valign="top">
					<input id="butSubmitPeriode" type="button" class="btn" value="{#winPeriode_valider#|escape:"html"}" onClick="$('divPatienter').style.display='inline';this.disabled=true;xajax_submitFormPeriode('{$periode.periode_id}', $(projet_id).value, $(user_id).value, $(date_debut).value, $(conserver_duree).checked, $(date_fin).value, $(duree).value, $(nb_jours).value, $(repetition).value, $(dateFinRepetition).value, $(appliquerATous).checked, $(statut_tache).value, $(livrable).value, $(titre).value, $(notes).value, $(lien).value, $(user_id2).value, $(user_id3).value);" />
					<span id="divPatienter" style="display:none;color:#ff0000;font-weight:bold;"><img src="images/loading16.gif" width="16" height="16" border="0" /></span>
				</td>
				<td valign="top" align="center">
					{if $periode.periode_id neq 0}
						<input type="button" class="btn" onClick="if(confirm('{#winPeriode_dupliquer#|escape:"javascript"} ?'))xajax_ajoutPeriode('', '', {$periode.periode_id});" value="{#winPeriode_dupliquer#}" />
						&nbsp;&nbsp;
						<input type="button" class="btn" onClick="if(confirm('{#winPeriode_confirmSuppr#|escape:"javascript"}'))xajax_supprimerPeriode({$periode.periode_id}, false);" value="{#winPeriode_supprimer#}" />
						{if isset($estFilleOuParente)}
							&nbsp;&nbsp;
							<input type="button" class="btn" onClick="if(confirm('{#winPeriode_confirmSupprRepetition#|escape:"javascript"}'))xajax_supprimerPeriode({$periode.periode_id}, true);" value="{#winPeriode_supprimer_repetition#}" />
						{/if}
					{/if}
				</td>
			</tr>
			</table>
		</td>
	</tr>
{/if}

</table>
</form>
