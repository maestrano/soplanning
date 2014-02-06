<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>{$smarty.const.CONFIG_SOPLANNING_TITLE|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link href="{$BASE}/css/style.css" rel="stylesheet" media="screen" type="text/css" />
	<link href="{$BASE}/css/print.css" rel="stylesheet" media="print" type="text/css" />
	<link href="favicon.ico" rel="icon" type="image/x-icon" />
	<meta name="reply-to" content="support@soplanning.org" />
	<meta name="email" content="support@soplanning.org" />
	<meta name="Identifier-URL" content="http://www.soplanning.org" />

	{$xajax}
</head>

<body>

<br /><br /><br />

<table align="center" cellpadding="0" cellspacing="0" width="450" class="blocHomepage">
<tr>
	<td align="center" style="padding-bottom:16px;">
		<img src="{$BASE}/images/logo.jpg" border="0">
	</td>
</tr>
</table>

<br /><br /><br />
<table align="center" cellpadding="0" cellspacing="0" width="450" class="blocHomepage">
<tr>
	<td align="center" style="padding-bottom:16px;">
		<form action="process/install.php" method="post">
		<table width="400" align="center">
			<tr>
				<td align="right"><b>Serveur hébergeant la base de données :</b></td>
				<td><input type="text" size="20" name="host" id="host" placeholder="localhost"></td>
			</tr>
			<tr>
				<td align="right"><b>Nom de la base de données :</b></td>
				<td><input type="text" size="20" name="database" id="database" placeholder="soplanning"></td>
			</tr>
			<tr>
				<td align="right"><b>Login :</b></td>
				<td><input type="text" size="20" name="login" id="login" placeholder="root"></td>
			</tr>
			<tr>
				<td align="right"><b>Mot de passe :</b></td>
				<td><input type="text" size="20" name="password" id="password" placeholder="root"></td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					<input class="normal" type="submit" value="Installer la base">
				</td>
			</tr>
		</table>

		</form>
	</td>
</tr>
</table>

<br /><br />
<table align="center" cellpadding="0" cellspacing="0" width="450" class="blocHomepage">
<tr>
	<td align="center" style="padding-bottom:10px;">
		<a href="?language=en">English</a> -
		<a href="?language=fr">French</a> -
		<a href="?language=it">Italian</a> -
		<a href="?language=nl">Nederlands</a> -
		<a href="?language=de">German</a>
	</td>
</tr>
</table>

</body>
</html>