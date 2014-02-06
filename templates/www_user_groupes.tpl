{* Smarty *}
{include file="www_header.tpl"}

<div class="row-fluid noprint ligneInfos">
	<a href="{$BASE}/user_list.php" class="btn btn-small" ><img src="images/users.png" border="0"> {#menuGestionUsers#}</a>
	<a href="javascript:xajax_modifUserGroupe();undefined;" class="btn btn-small" style="margin-left:10px;"><img src="images/adduser_groupes.png" border="0"> {#menuCreerUserGroupe#}</a>
	<a href="javascript:xajax_modifUser();undefined;" class="btn btn-small" style="margin-left:10px;"><img src="images/adduser.png" border="0"> {#menuCreerUser#}</a>
</div>

<br />
{if $groupes|@count > 0}

<table class="table table-striped" cellpadding="3" cellspacing="0" style="width:600px"> 
<tr align="middle">
	<th>&nbsp;</th>
	<th align="center">
		{if $order eq "nom"}
			{if $by eq "asc"}
				<a href="{$BASE}/user_groupes.php?page=1&order=nom&by=desc">{#user_groupe#}</a>&nbsp;<img src="{$BASE}/images/asc_order.png" border="0" alt="" />
			{else}
				<a href="{$BASE}/user_groupes.php?page=1&order=nom&by=asc">{#user_groupe#}</a>&nbsp;<img src="{$BASE}/images/desc_order.png" border="0" alt="" />
			{/if}
		{else}
			<a href="{$BASE}/user_groupes.php?page=1&order=nom&by={$by}">{#user_groupe#}</a>
		{/if}
	</th>
	<th>{#user_groupe_nbUsers#}</th>
</tr>

{foreach name=groupes item=groupe from=$groupes}
	<tr bgcolor="#FFFFFF" onMouseOver="javascript:this.style.backgroundColor='#EEEEEE'" onMouseOut="javascript:this.style.backgroundColor='#FFFFFF'">
		<td align="center" nowrap="nowrap" width="60">
			<a href="javascript:xajax_modifUserGroupe({$groupe.user_groupe_id});undefined;"><img src="{$BASE}/images/edit.gif" border="0" width="16" height="16" /></a>
			&nbsp;
			<a href="javascript:if(confirm('{#confirm#|escape:"javascript"}')){literal}{{/literal}javascript:xajax_supprimerUserGroupe({$groupe.user_groupe_id});{literal}}{/literal};undefined;"><img src="{$BASE}/images/delete.gif" border="0" width="16" height="16" /></a>
		</td>
		<td>{$groupe.nom}&nbsp;</td>
		<td>{$groupe.totalUsers}&nbsp;</td>
	</tr>
{/foreach}
</table>

{else}
	{#info_noRecord#}
{/if}

{include file="www_footer.tpl"}