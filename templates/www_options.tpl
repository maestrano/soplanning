{* Smarty *}
{include file="www_header.tpl"}

<div class="row-fluid noprint blocParams">
	<div class="titreParams">
		{#options_configGenerale#}
	</div>
	<form action="process/options.php" method="POST" class="form-inline">
	<div style="font-weight:bold;">
		{#options_titre#} :
		<input name="SOPLANNING_TITLE" type="text" size="50" value="{$smarty.const.CONFIG_SOPLANNING_TITLE}" class="span6" />
		<a onmouseover="return coolTip('{#options_aide_titre#|escape:"quotes"}', WIDTH, 400)"  onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

		<br /><br />
		{#options_url#} :
		<input name="SOPLANNING_URL" type="text" size="62" value="{$smarty.const.CONFIG_SOPLANNING_URL}" class="span6" />
		<a onmouseover="return coolTip('{#options_aide_url#|cat:'<br>'|cat:$urlSuggeree|escape:"quotes"}', WIDTH, 400)"  onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>
	</div>
	<div align="right">
		<input type="submit" class="btn" class="btn" value="{#submit#}">
	</div>
	</form>
</div>

<br />
<div class="row-fluid noprint blocParams">
	<div class="titreParams">
		{#options_planning#}
	</div>
	<form action="process/options.php" method="POST" class="form-inline">
	{assign var=jours value=","|explode:$smarty.const.CONFIG_DAYS_INCLUDED}
	{#options_joursInclus#} :
	<input type="checkbox" name="DAYS_INCLUDED[]" value="1" id="chklundi" {if in_array('1', $jours)}checked="checked"{/if}>
	<label for="chklundi">{#day_1#}</label>
	&nbsp;&nbsp;
	<input type="checkbox" name="DAYS_INCLUDED[]" value="2" id="chkmardi" {if in_array('2', $jours)}checked="checked"{/if}>
	<label for="chkmardi">{#day_2#}</label>
	&nbsp;&nbsp;
	<input type="checkbox" name="DAYS_INCLUDED[]" value="3" id="chkmercredi" {if in_array('3', $jours)}checked="checked"{/if}>
	<label for="chkmercredi">{#day_3#}</label>
	&nbsp;&nbsp;
	<input type="checkbox" name="DAYS_INCLUDED[]" value="4" id="chkjeudi" {if in_array('4', $jours)}checked="checked"{/if}>
	<label for="chkjeudi">{#day_4#}</label>
	&nbsp;&nbsp;
	<input type="checkbox" name="DAYS_INCLUDED[]" value="5" id="chkvendredi" {if in_array('5', $jours)}checked="checked"{/if}>
	<label for="chkvendredi">{#day_5#}</label>
	&nbsp;&nbsp;
	<input type="checkbox" name="DAYS_INCLUDED[]" value="6" id="chksamedi" {if in_array('6', $jours)}checked="checked"{/if}>
	<label for="chksamedi">{#day_6#}</label>
	&nbsp;&nbsp;
	<input type="checkbox" name="DAYS_INCLUDED[]" value="0" id="chkdimanche" {if in_array('0', $jours)}checked="checked"{/if}>
	<label for="chkdimanche">{#day_0#}</label>

	<br /><br />
	{#options_nbMoisDefaut#} :
	<input name="DEFAULT_NB_MONTHS_DISPLAYED" type="text" size="2" value="{$smarty.const.CONFIG_DEFAULT_NB_MONTHS_DISPLAYED}" style="width:40px" />

	<br /><br />
	{#options_nbLignes#} :
	<input name="DEFAULT_NB_ROWS_DISPLAYED" type="text" size="2" value="{$smarty.const.CONFIG_DEFAULT_NB_ROWS_DISPLAYED}" style="width:40px" />

	<br /><br />
	{#options_nbJoursPasses#} :
	<input name="DEFAULT_NB_PAST_DAYS" type="text" size="2" value="{$smarty.const.CONFIG_DEFAULT_NB_PAST_DAYS}" style="width:40px" />

	<br /><br />
	{#options_raffraichissement#} :
	<input name="REFRESH_TIMER" type="text" size="2" value="{$smarty.const.CONFIG_REFRESH_TIMER}" style="width:40px" />

	<br /><br />
	{#options_hauteurLigne#} :
	<input name="PLANNING_LINE_HEIGHT" type="text" size="2" value="{$smarty.const.CONFIG_PLANNING_LINE_HEIGHT}" style="width:40px" />
	<a onmouseover="return coolTip('{#options_aide_hauteurLigne#|escape:"quotes"}', WIDTH, 400)" onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

	<br /><br />
	{#options_uneTacheParJour#} :
	<select name="PLANNING_ONE_ASSIGNMENT_MAX_PER_DAY" style="width:100px">
		<option value="0" {if $smarty.const.CONFIG_PLANNING_ONE_ASSIGNMENT_MAX_PER_DAY eq 0}selected="selected"{/if}>{#non#}</option>
		<option value="1" {if $smarty.const.CONFIG_PLANNING_ONE_ASSIGNMENT_MAX_PER_DAY eq 1}selected="selected"{/if}>{#oui#}</option>
	</select>
	<a onmouseover="return coolTip('{#options_aide_uneTacheParJour#|escape:"quotes"}', WIDTH, 400)" onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

	<br /><br />
	{#options_repeterHeaderDate#} :
	<input name="PLANNING_REPEAT_HEADER" type="text" size="2" value="{$smarty.const.CONFIG_PLANNING_REPEAT_HEADER}" style="width:40px" />
	<a onmouseover="return coolTip('{#options_aide_repeterHeaderDate#|escape:"quotes"}', WIDTH, 400)" onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

	<br />
	<div align="right">
		<input type="submit" class="btn" value="{#submit#}">
	</div>
	</form>
</div>

<br />

<div class="row-fluid noprint blocParams">
	<div class="titreParams">
		{#options_divers#}
	</div>
		
	<form action="process/options.php" method="POST" class="form-inline">
	{#options_couleursProjets#} :
	<input name="PROJECT_COLORS_POSSIBLE" type="text" size="30" value="{$smarty.const.CONFIG_PROJECT_COLORS_POSSIBLE}" class="span6" />
	<a onmouseover="return coolTip('{#options_aide_couleursPossibles#|escape:"quotes"}', WIDTH, 400)"  onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

	<br /><br />
	{#options_lienDefaut#} :
	<input name="DEFAULT_PERIOD_LINK" type="text" size="50" value="{$smarty.const.CONFIG_DEFAULT_PERIOD_LINK}" class="span6" />
	<a onmouseover="return coolTip('{#options_aide_LinkPeriod#|escape:"quotes"}', WIDTH, 400)"  onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

	<br /><br />
	{#options_urlRedirection#} :
	<input name="LOGOUT_REDIRECT" type="text" size="50" value="{$smarty.const.CONFIG_LOGOUT_REDIRECT}" class="span6" />
	<a onmouseover="return coolTip('{#options_aide_redirect#|escape:"quotes"}', WIDTH, 400)"  onmouseout="nd()" href="javascript:unedfined;"><img src="images/question.png" border="0" /></a>

	<br />
	<div align="right">
		<input type="submit" class="btn" value="{#submit#}">
	</div>
	</form>
</div>

<br />

<div class="row-fluid noprint blocParams">
	<div class="titreParams">
		{#options_smtp#}
	</div>

	<form action="process/options.php" method="POST" class="form-inline">
	{#options_smtp_host#} :
	<input name="SMTP_HOST" type="text" size="40" value="{$smarty.const.CONFIG_SMTP_HOST}" />
	&nbsp;&nbsp;&nbsp;&nbsp;
	{#options_smtp_port#} :
	<input name="SMTP_PORT" type="text" size="4" value="{$smarty.const.CONFIG_SMTP_PORT}" />
	<br /><br />
	{#options_smtp_secure#} :
	<select id="" name="SMTP_SECURE">
		<option value="" {if $smarty.const.CONFIG_SMTP_SECURE eq ""}selected="selected"{/if}>{#options_smtp_nonSecurise#}</option>
		<option value="ssl" {if $smarty.const.CONFIG_SMTP_SECURE eq "ssl"}selected="selected"{/if}>SSL</option>
		<option value="tls" {if $smarty.const.CONFIG_SMTP_SECURE eq "tls"}selected="selected"{/if}>TLS</option>
	</select>
	<br /><br />
	{#options_smtp_from#} :
	<input name="SMTP_FROM" type="text" size="40" value="{$smarty.const.CONFIG_SMTP_FROM}" />
	<br /><br />
	{#options_smtp_login#} :
	<input name="SMTP_LOGIN" type="text" size="30" value="{$smarty.const.CONFIG_SMTP_LOGIN}" />
	&nbsp;&nbsp;&nbsp;&nbsp;
	{#options_smtp_password#} :
	<input name="SMTP_PASSWORD" type="password" size="30" value="{$smarty.const.CONFIG_SMTP_PASSWORD}" />
	<br />
	<div align="right">
		<input type="submit" class="btn" value="{#submit#}">
	</div>
	</form>
</div>

{include file="www_footer.tpl"}