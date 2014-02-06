{* Smarty *}

<form action="" method="POST" onSubmit="return false;">

<table cellspacing="2" width="100%">
	<tr>
		<td>{#user_groupe#}</td>
		<td>
			<input id="nom" type="text" value="{$groupe.nom|escape:"html"}" size="50" maxlength="150" />
		</td>
	</tr> 
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="button" class="btn" value="{#submit#}" onClick="xajax_submitFormUserGroupe('{$groupe.user_groupe_id|escape}', $('nom').value);" />
		</td>
	</tr>
</table>
</form>
