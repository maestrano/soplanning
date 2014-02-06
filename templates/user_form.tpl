{* Smarty *}

<form name="formUser" action="" method="POST" onSubmit="return false;">

{* pour tester si compte déjà existant ou pas *}
<input type="hidden" id="user_id_origine" value="{$user_form.user_id}">

<table cellspacing="0" width="100%" style="border:collapse">
	<tr>
		<td>{#user_identifiant#}</td>
		<td>
			{if $user_form.saved eq 1}
				{$user_form.user_id|escape:"html"}
				<input id="user_id" type="hidden" value="{$user_form.user_id|escape:"html"}" />
			{else}
				<input id="user_id" type="text" value="{$user_form.user_id|escape:"html"}" size="10" maxlength="10" />
			{/if}
		</td>
		<td width="120">{#user_groupe#}</td>
		<td>
			<select id="user_groupe_id">
				<option value="">- - - - - - - - - - -</option>
				{foreach from=$groupes item=groupe}
					<option value="{$groupe.user_groupe_id}" {if $user_form.user_groupe_id eq $groupe.user_groupe_id}selected="selected"{/if}>{$groupe.nom|escape}</option>
				{/foreach}
			</select>
		</td>
	</tr> 
	<tr>
		<td>{#user_nom#}</td>
		<td><input id="nom" type="text" value="{$user_form.nom|escape:"html"}" size="30" maxlength="100" /></td>
		<td width="120">{#user_email#}</td>
		<td><input id="email_user" type="text" value="{$user_form.email|escape:"html"}" size="40" maxlength="255" /></td>
	</tr>
	<tr>
		<td>{#user_login#}</td>
		<td><input id="login_tmp" type="text" value="{$user_form.login|escape:"html"}" size="20" maxlength="20" /></td>
		<td>{#user_password#}</td>
		<td><input id="password_tmp" type="password" value="" size="20" maxlength="20" /></td>
	</tr>
	<tr>
		<td width="170">{#user_visiblePlanning#}</td>
		<td><input type="radio" id="visible_planningOui" name="visible_planning" value="oui" {if ($user_form.saved eq 0) || ($user_form.visible_planning eq "oui")}checked="checked"{/if}> <label for="visible_planningOui">{#oui#}</label>
		<input type="radio" id="visible_planningNon" name="visible_planning" value="non" {if ($user_form.saved eq 1) && ($user_form.visible_planning eq "non")}checked="checked"{/if} style="margin-left:20px;"> <label for="visible_planningNon">{#non#}</label></td>
		<td>{#user_couleur#}</td>
		<td>
			<input id="couleur" type="text" size="7" maxlength="6" value="{$user_form.couleur|escape:"html"}" size="20" maxlength="20" onChange="$S('colorbox').background='#'+this.value;" />
		</td>
	</tr>
	<tr>
		<td width="170">{#user_notifications#}</td>
		<td><input type="radio" id="notificationsOui" name="notifications" value="oui" {if $user_form.notifications eq "oui"}checked="checked"{/if}> <label for="visible_planningOui">{#oui#}</label>
		<input type="radio" id="notificationsNon" name="notifications" value="non" {if $user_form.notifications eq "non"}checked="checked"{/if} style="margin-left:20px;"> <label for="visible_planningNon">{#non#}</label></td>
		<td>
		</td>
		<td>
		</td>
	</tr>
	{if $user_form.saved eq 0}
		<tr>
			<td colspan="4" width="170">
				<label for="envoiMailPwd">{#user_mailPwd#}</label>&nbsp;&nbsp;
				<input type="checkbox" id="envoiMailPwd" name="envoiMailPwd" value="true" />
			<td>
		</tr>
	{else}
		<input type="hidden" id="envoiMailPwd" name="envoiMailPwd" value="false" />
	{/if}
	<tr>
		<td colspan="4" style="border-top:1px solid #666666;"><b>{#user_droits#}</b></td>
	</tr>
	<tr>
		<td colspan="4">
			<p style="line-height:10px;">
				<br />
				<b>{#droits_utilisateurs#} :</b>
				<input type="radio"name="users_manage" id="droit1" value="" {if !in_array("users_manage_all", $user_form.tabDroits)}checked="checked"{/if}><label for="droit1">{#droits_aucundroitUser#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio"name="users_manage" id="users_manage_all" value="users_manage_all" {if in_array("users_manage_all", $user_form.tabDroits)}checked="checked"{/if}><label for="users_manage_all">{#droits_gererTousUsers#}</label>
				<br />

				<b>{#droits_projets#} :</b>
				<input type="radio" name="projects_manage" id="droit2" value="" {if !in_array("projects_manage_all", $user_form.tabDroits) && !in_array("projects_manage_own", $user_form.tabDroits)}checked="checked"{/if}><label for="droit2">{#droits_aucunDroitProjets#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="projects_manage" id="projects_manage_all" value="projects_manage_all" {if in_array("projects_manage_all", $user_form.tabDroits)}checked="checked"{/if}><label for="projects_manage_all">{#droits_gererTousProjets#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="projects_manage" id="projects_manage_own" value="projects_manage_own" {if in_array("projects_manage_own", $user_form.tabDroits)}checked="checked"{/if}><label for="projects_manage_own">{#droits_uniquementProjProprio#}</label>
				<br />

				<b>{#droits_groupesProjets#} :</b>
				<input type="radio" name="projectgroups_manage" id="droit3" value="" {if !in_array("projectgroups_manage_all", $user_form.tabDroits)}checked="checked"{/if}><label for="droit3">{#droits_groupesProjetsAucun#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="projectgroups_manage" id="projectgroups_manage_all" value="projectgroups_manage_all" {if in_array("projectgroups_manage_all", $user_form.tabDroits)}checked="checked"{/if}><label for="projectgroups_manage_all">{#droits_gererTousGroupes#}</label>
				<br />

				<b>{#droits_modifPlanning#} :</b>
				<input type="radio" name="planning_modif" id="planning_readonly" value="planning_readonly" {if in_array("planning_readonly", $user_form.tabDroits) || (!in_array("planning_modify_all", $user_form.tabDroits) && !in_array("planning_modify_own_project", $user_form.tabDroits) && !in_array("planning_modify_own_task", $user_form.tabDroits))}checked="checked"{/if}><label for="droit4">{#droits_planningLectureSeule#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="planning_modif" id="planning_modify_all" value="planning_modify_all" {if in_array("planning_modify_all", $user_form.tabDroits)}checked="checked"{/if}><label for="planning_modify_all">{#droits_planningTousProjets#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="planning_modif" id="planning_modify_own_project" value="planning_modify_own_project" {if in_array("planning_modify_own_project", $user_form.tabDroits)}checked="checked"{/if}><label for="planning_modify_own_project">{#droits_planningProjetsProprio#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="planning_modif" id="planning_modify_own_task" value="planning_modify_own_task" {if in_array("planning_modify_own_task", $user_form.tabDroits)}checked="checked"{/if}><label for="planning_modify_own_task">{#droits_planningTachesAssignees#}</label>
				<br />

				<b>{#droits_vuePlanning#} :</b>
				<input type="radio" name="planning_view" id="planning_view_all_projects" value="planning_view_all_projects" {if in_array("planning_view_all_projects", $user_form.tabDroits) || !in_array("planning_view_own_projects", $user_form.tabDroits)}checked="checked"{/if}><label for="planning_view_all_projects">{#droits_vueTousProjets#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="planning_view" id="planning_view_team_projects" value="planning_view_team_projects" {if in_array("planning_view_team_projects", $user_form.tabDroits)}checked="checked"{/if}><label for="planning_view_team_projects">{#droits_vueProjetsEquipe#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="planning_view" id="planning_view_own_projects" value="planning_view_own_projects" {if in_array("planning_view_own_projects", $user_form.tabDroits)}checked="checked"{/if}><label for="planning_view_own_projects">{#droits_vueProjetsAssignes#}</label>
				<br />

				<b>{#droits_parametres#} :</b>
				<input type="radio" name="parameters" id="droit5" value="" {if !in_array("parameters_modify", $user_form.tabDroits)}checked="checked"{/if}><label for="droit5">{#droits_aucunParametres#}</label>
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="parameters" id="parameters_modify" value="parameters_all" {if in_array("parameters_all", $user_form.tabDroits)}checked="checked"{/if}><label for="parameters_modify">{#droits_parametresAcces#}</label>
			</p>
		</td>
	</tr> 
	<tr>
		<td colspan="4">
			<input type="button" class="btn" value="{#submit#}" onClick="xajax_submitFormUser($('user_id').value, $('user_id_origine').value, $('user_groupe_id').value, $('nom').value, $('email_user').value, $('login_tmp').value, $('password_tmp').value, $('visible_planningOui').checked, $('couleur').value, $('notificationsOui').checked, $('envoiMailPwd').checked, new Array(getRadioValue('users_manage'), getRadioValue('projects_manage'), getRadioValue('projectgroups_manage'), getRadioValue('planning_modif'), getRadioValue('planning_view'), getRadioValue('parameters')));" />
		</td>
	</tr>
</form>
</table>
