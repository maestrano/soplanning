{* Smarty *}

{include file="www_header.tpl"}

<div class="row-fluid noprint ligneInfos">
	<a href="javascript:xajax_modifFerie();undefined;" class="btn btn-small" ><img src="images/feries.png" border="0"> {#menuCreerFerie#}</a>

	<div class="btn-group" style="margin-left:10px;">
		<button class="btn dropdown-toggle btn-small" data-toggle="dropdown">{#feries_import#}&nbsp;<span class="caret"></span></button>
		<ul class="dropdown-menu">
			{foreach from=$fichiers item=fichier}
				<li><a onClick="event.cancelBubble=true;" href="javascript:if(confirm('{#feries_confirmImport#}')){literal}{{/literal}document.location='process/feries.php?fichier={$fichier|basename}'{literal}}{/literal}">{$fichier|basename}</a></li>
			{/foreach}
		</ul>
	</div>
</div>

<br />

{if $feries|@count > 0}

<table class="table table-striped" cellpadding="0" cellspacing="0" style="width:600px;"> 
<tr align="middle">
	<th width="70">&nbsp;</th>
	<th align="center" width="100">
		<b>{#feries_date#}</b>
	</th>
	<th align="center">
		<b>{#feries_libelle#}</b>
	</th>
</tr>
{foreach name=feries item=ferie from=$feries}
	<tr bgcolor="#FFFFFF" onMouseOver="javascript:this.style.backgroundColor='#EEEEEE'" onMouseOut="javascript:this.style.backgroundColor='#FFFFFF'">
		<td align="center" nowrap="nowrap">
			<a href="javascript:xajax_modifFerie('{$ferie.date_ferie|urlencode}');undefined;"><img src="{$BASE}/images/edit.gif" border="0" width="16" height="16" /></a>
			&nbsp;
			<a href="javascript:xajax_supprimerFerie('{$ferie.date_ferie|urlencode}');undefined;" onClick="javascript:return confirm('{#confirm#|escape:"javascript"}')"><img src="{$BASE}/images/delete.gif" border="0" width="16" height="16" /></a>
		</td>
		<td align="center">
			{$ferie.date_ferie|sqldate2userdate}&nbsp;
		</td>
		<td>
			{$ferie.libelle}
			&nbsp;
		</td>
	</tr>
{/foreach}
</table>
<br />

{else}
	{#info_noRecord#}
{/if}

{include file="www_footer.tpl"}