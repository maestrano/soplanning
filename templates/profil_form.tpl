{* Smarty *}

<form name="formUser" action="" method="POST" onSubmit="return false;">

<table cellspacing="2" width="100%">
	<tr>
		<td>{#user_identifiant#}</td>
		<td>
			{if $user_form.saved eq 1}
				{$user_form.user_id|escape:"html"}
				<input id="user_id" type="hidden" value="{$user_form.user_id|escape:"html"}" />
			{else}
				<input id="user_id" type="text" value="{$user_form.user_id|escape:"html"}" size="3" maxlength="3" />
			{/if}
		</td>
	</tr> 
	<tr>
		<td>{#user_nom#}</td>
		<td>{$user_form.nom|escape:"html"}</td>
	</tr>
	<tr>
		<td>{#user_email#}</td>
		<td><input id="email_user" type="text" value="{$user_form.email|escape:"html"}" size="40" maxlength="255" /></td>
	</tr>
	<tr>
		<td>{#user_login#}</td>
		<td>{$user_form.login|escape:"html"}</td>
	</tr> 
	<tr>
		<td>{#user_password#}</td>
		<td><input id="password_tmp" type="password" value="" size="20" maxlength="20" /></td>
	</tr> 
	<tr>
		<td>{#user_notifications#}</td>
		<td><input type="radio" id="notificationsOui" name="notifications" value="oui" {if $user_form.notifications eq "oui"}checked="checked"{/if}> <label for="visible_planningOui">{#oui#}</label>
		<input type="radio" id="notificationsNon" name="notifications" value="non" {if $user_form.notifications eq "non"}checked="checked"{/if} style="margin-left:20px;"> <label for="visible_planningNon">{#non#}</label></td>
	</tr> 
	<tr>
		<td>&nbsp;</td>
		<td>
			<input type="button" class="btn" value="{#submit#}" onClick="xajax_submitFormProfil('{$user_form.user_id|escape}', $('email_user').value, $('password_tmp').value, $('notificationsOui').checked);" />
		</td>
	</tr>
</table>
</form>
