{include file="www_header.tpl"}

<br /><br /><br /><br />

<div align="center">
	<div class="blocHomepage">
		<table align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" style="padding-bottom:16px;">
				{if $smarty.const.CONFIG_SOPLANNING_TITLE neq "SOPlanning"}
					<span style="font-size:23px;font-weight:bold;">{$smarty.const.CONFIG_SOPLANNING_TITLE}</span>
				{else}
					<img src="images/logo.jpg" border="0">
				{/if}

				{if isset($planningVersion)}
				v{$planningVersion}
				{/if}
			</td>
		</tr>
		</table>
	</div>
</div>

{if $checkPhpVersion eq ""}
	<div style="color:#ff0000" align="center">{#checkPhpVersion#}</div>
{/if}

<br /><br />
<div align="center">
	<div class="blocHomepage">
		<table align="center" cellpadding="0" cellspacing="0">
		<tr>
			{if $checkPhpVersion neq ""}
				<form action="process/login.php" method="post" class="form-inline">
			{/if}
			<td align="center" style="padding-bottom:16px;">
				<table width="350" align="center">
					<tr>
						<td align="right"><b>{#login_login#}&nbsp;</b></td>
						<td><input type="text" size="20" name="login" id="login"></td>
					</tr>
					<tr>
						<td class="normal" align="right"><b>{#login_password#}&nbsp;</b></td>

						<td><input type="password" size="20" name="password"></td>
					</tr>
					<tr>
						<td>
							&nbsp;
						</td>
						<td>
							<input class="normal" type="submit" value="GO" style="width:40px;">
						</td>
					</tr>
				</table>

				<div align="right"><a href="javascript:$('divRappelPwd').style.display='block';undefined;">{#rappelPwdTitre#}</a></div>
				<div align="right" id="divRappelPwd" style="display:none;">
					{#rappelPwdVotreEmail#} : <input type="text" id="rappel_pwd" size="" maxlength="">
					<input class="btn" size="30" type="button" value="GO" style="width:40px;" onClick="xajax_changerPwd($('rappel_pwd').value);$('divRappelPwd').style.display='none';undefined;">
				</div>

				</form>
			</td>
		</tr>
		</table>
	</div>
</div>

<br /><br />
<div align="center">
	<div class="blocHomepage">
		<table align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center" style="padding-bottom:10px;">
					<a href="?language=en">English</a> -
					<a href="?language=fr">French</a> -
					<a href="?language=it">Italian</a> -
					<a href="?language=nl">Dutch</a> -
					<a href="?language=de">German</a> -
					<a href="?language=es">Spanish</a> -
					<a href="?language=pt">Portuguese</a>
					<br /><br />
					<a href="mailto:support@soplanning.org">Propose / udpate your translation !</a>
			</td>
		</tr>
		</table>
	</div>
</div>

<center>
<div id="infosVersion" style="display:none"></div>
</center>

<script language="javascript">
document.getElementById('login').focus();

setTimeout("xajax_checkVersion();", 5000);

</script>

{include file="www_footer.tpl"}