{* Smarty *}
{include file="www_header.tpl"}

<div class="row-fluid noprint ligneInfos">
	<a href="{$BASE}/projets.php" class="btn btn-small" ><img src="images/projets.png" border="0"> {#menuListeProjets#}</a>
	<a href="{$BASE}/groupe_form.php" class="btn btn-small" style="margin-left:10px;"><img src="images/addgroupe.png" border="0"> {#menuCreerGroupe#}</a>
</div>

<br />

{if $groupes|@count > 0}

<table class="table table-striped" cellpadding="3" cellspacing="0" style="width:600px;"> 
<tr align="middle">
	<th>&nbsp;</th>
	<th align="center">
		{if $order eq "nom"}
			{if $by eq "asc"}
				<a href="{$BASE}/groupe_list.php?page=1&order=nom&by=desc">{#groupe_liste_nom#}</a>&nbsp;<img src="{$BASE}/images/asc_order.png" border="0" alt="" />
			{else}
				<a href="{$BASE}/groupe_list.php?page=1&order=nom&by=asc">{#groupe_liste_nom#}</a>&nbsp;<img src="{$BASE}/images/desc_order.png" border="0" alt="" />
			{/if}
		{else}
			<a href="{$BASE}/groupe_list.php?page=1&order=nom&by={$by}">{#groupe_liste_nom#}</a>
		{/if}
	</th>
	<th>{#groupe_liste_nbProjets#}</th>
</tr>
{foreach name=groupes item=groupe from=$groupes}
	<tr bgcolor="#FFFFFF" onMouseOver="javascript:this.style.backgroundColor='#EEEEEE'" onMouseOut="javascript:this.style.backgroundColor='#FFFFFF'">
		<td align="center" nowrap="nowrap">
			<a href="{$BASE}/groupe_form.php?groupe_id={$groupe.groupe_id}"><img src="{$BASE}/images/edit.gif" border="0" width="16" height="16" /></a>
			&nbsp;
			<a href="{$BASE}/process/groupe_save.php?groupe_id={$groupe.groupe_id}&action=delete" onClick="javascript:return confirm('{#groupe_liste_confirmSuppr#|escape:"javascript"}')"><img src="{$BASE}/images/delete.gif" border="0" width="16" height="16" /></a>
		</td>
		<td>{$groupe.nom|xss_protect}&nbsp;</td>
		<td>{$groupe.totalProjets}&nbsp;</td>
	</tr>
{/foreach}
{if $nbPages > 1}
	<tr>
		<td colspan="7" align="right">
			{if $currentPage > 1}<a href="{$BASE}/groupe_list.php?page={$currentPage-1}">&lt;&lt; {#action_precedent#}</a>&nbsp;&nbsp;{/if}
			{section name=pagination loop=$nbPages}
				{if $smarty.section.pagination.iteration == $currentPage}<b>{else}<a href="{$BASE}/groupe_list.php?page={$smarty.section.pagination.iteration}">{/if}
				{$smarty.section.pagination.iteration}
				{if $smarty.section.pagination.iteration == $currentPage}</b>{else}</a>{/if}&nbsp;
			{/section}
			{if $currentPage < $nbPages}<a href="{$BASE}/groupe_list.php?page={$currentPage+1}">{#action_suivant#} &gt;&gt;</a>{/if}
		</td>
	</tr>
{/if}
</table><br />
{else}
	{#info_noRecord#}
{/if}

{include file="www_footer.tpl"}