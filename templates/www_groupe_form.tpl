{* Smarty *}
{include file="www_header.tpl"}

<div class="row-fluid noprint ligneInfos">
	<a href="{$BASE}/projets.php" class="btn btn-small" ><img src="images/projets.png" border="0"> {#menuListeProjets#}</a>
	<a href="{$BASE}/groupe_list.php" class="btn btn-small" style="margin-left:10px;"><img src="images/groupes.png" border="0"> {#menuListeGroupes#}</a>
</div>

<br />

{if isset($error_fields)}
		{#groupe_erreurChamps#} :<br />
	{foreach from=$error_fields item=field}
		- {$field}<br />
	{/foreach}
	<br /><br />
{/if}

<form action="{$BASE}/process/groupe_save.php" method="POST">
<input type="hidden" name="saved" value="{$groupe.saved}" />
<input type="hidden" name="groupe_id" value="{$groupe.groupe_id}" />

<table border="0" cellpadding="0" cellspacing="0" width="300">
   <tr>
		<td>{#groupe_nom#}</td>
		<td><input name="nom" type="text" value="{$groupe.nom|escape:"html"}" size="30" maxlength="100" /></td>
   </tr> 
	<tr align="center">
		<td>
			<input type="submit" value="{#groupe_valider#|escape:"html"}" class="btn" />
		</td>
		<td>
		</td>
	</tr>
</table>
</form>

{include file="www_footer.tpl"}