<!DOCTYPE html>
<html lang="en">
<head>
	<title>{$smarty.const.CONFIG_SOPLANNING_TITLE|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link href="favicon.ico" rel="icon" type="image/x-icon" />
	<meta name="reply-to" content="support@soplanning.org" />
	<meta name="email" content="support@soplanning.org" />
	<meta name="Identifier-URL" content="http://www.soplanning.org" />

    <script src="js/jquery/jquery-1.8.2.js"></script>
	<script src="js/jquery/ui/jquery.ui.core.js"></script>
	<script src="js/jquery/ui/jquery.ui.widget.js"></script>
	<script src="js/jquery/ui/jquery.ui.datepicker.js"></script>
	<script src="js/jquery/ui/i18n/jquery.ui.datepicker-{$lang}.js"></script>
	<script src="js/jquery/ui/jquery.ui.tooltip.js"></script>
	<script src="js/jquery/ui/jquery.ui.autocomplete.js"></script>
	<script src="js/jquery/ui/jquery.ui.position.js"></script>
	<script src="js/jquery/ui/jquery.ui.menu.js"></script>
	<link rel="stylesheet" href="js/jquery/css/redmond/jquery-ui-1.9.1.custom.css" />
	
	<script src="js/bootstrap/js/bootstrap.js"></script>
	<link href="js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">

	<link href="{$BASE}/css/style.css" rel="stylesheet" media="screen" type="text/css" />
	<link href="{$BASE}/css/print.css" rel="stylesheet" media="print" type="text/css" />

	<script type="text/javascript" src="js/fonctions.js"></script>

	{* prototype window *}
	<script type="text/javascript" src="js/window/prototype.js"></script>
	<script type="text/javascript" src="js/window/window.js"></script>
	<script type="text/javascript" src="js/window/window_ext.js"></script>
	<link href="js/window/default.css" rel="stylesheet" type="text/css"/>
	<link href="js/window/charte1.css" rel="stylesheet" type="text/css"/>

	{* palette de couleur *}
	<script type="text/javascript" src="js/jscolor/jscolor.js"></script>

	{* layer pour choix des projets à afficher *}
	<script type="text/javascript" src="js/sousmenu.js"></script>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	{$xajax}

</head>

<body>
<script>jQuery.noConflict();</script>

{if isset($user)}
	<div style="margin-bottom:10px;padding-top:5px;padding-bottom:3px;padding-left:5px;padding-right:18px;background-color:#474747">
		<table id="tabHeader" cellpadding="0" cellspacing="0" border="0" width="100%" class="noprint">
		<tr>
			<td style="color:#ffffff;" onMouseOver="this.bgColor='#58B3F5';" onMouseOut="this.bgColor='';">
				<a href="{$BASE}/planning.php" style="color:#ffffff;font-size:26px;font-weight:normal;text-decoration:none;">{$smarty.const.CONFIG_SOPLANNING_TITLE}</a>
				<span style="font-size:10px">&nbsp;v{$infoVersion}</span>
			</td>
			<td>
				<table id="tabHeaderTools" cellpadding="0" cellspacing="0" border="0" bgcolor="#474747" class="noprint">
				<tr>
					<td width="10" align="center"><img src="{$BASE}/images/separateur.png" border="0"></td>
					<td class="tdMenuPrincipal" onMouseOver="this.bgColor='#58B3F5';afficherSousMenu('divSousMenuPlanning', 'divPositionSousMenuPlanning');" onMouseOut="this.bgColor='';">
						<a target="_top" href="{$BASE}/planning.php" class="lienMenuPrincipal"><img src="{$BASE}/images/logo.png" border="0" style="vertical-align:middle;">&nbsp;{#menuAfficherPlanning#}</a>
						<div id="divPositionSousMenuPlanning"></div>
					</td>
					{if in_array("projects_manage_all", $user.tabDroits) || in_array("projects_manage_own", $user.tabDroits)}
						<td width="10" align="center"><img src="{$BASE}/images/separateur.png" border="0"></td>
						<td class="tdMenuPrincipal" onMouseOver="this.bgColor='#58B3F5';afficherSousMenu('divSousMenuProjets', 'divPositionSousMenuProjets');" onMouseOut="this.bgColor='';">
							<a target="_top" href="{$BASE}/projets.php" class="lienMenuPrincipal"><img src="{$BASE}/images/projets.png" border="0" style="vertical-align:middle;">{#menuListeProjets#}</a>
							<div id="divPositionSousMenuProjets"></div>
						</td>
					{/if}
					{if in_array("users_manage_all", $user.tabDroits)}
						<td width="10" align="center"><img src="{$BASE}/images/separateur.png" border="0"></td>
						<td class="tdMenuPrincipal" onMouseOver="this.bgColor='#58B3F5';afficherSousMenu('divSousMenuUsers', 'divPositionSousMenuUsers');" onMouseOut="this.bgColor='';">
							<a target="_top" href="{$BASE}/user_list.php" class="lienMenuPrincipal"><img src="{$BASE}/images/users.png" border="0" style="vertical-align:middle;">&nbsp;{#menuGestionUsers#}</a>
							<div id="divPositionSousMenuUsers"></div>
						</td>
					{/if}
					{if in_array("parameters_all", $user.tabDroits)}
						<td width="10" align="center"><img src="{$BASE}/images/separateur.png" border="0"></td>
						<td class="tdMenuPrincipal" onMouseOver="this.bgColor='#58B3F5';afficherSousMenu('divSousMenuParametres', 'divPositionSousMenuParametres');" onMouseOut="this.bgColor='';">
							<a target="_top" href="{$BASE}/options.php" class="lienMenuPrincipal"><img src="{$BASE}/images/options.png" border="0" style="vertical-align:middle;">&nbsp;{#menuOptions#}</a>
							<div id="divPositionSousMenuParametres"></div>
						</td>
					{/if}
					<td width="10" align="center"><img src="{$BASE}/images/separateur.png" border="0"></td>
				</tr>
				</table>
			</td>
			<td align="right" onMouseOver="this.bgColor='#58B3F5';" onMouseOut="this.bgColor='';">
				<table id="tabHeaderLog">
				<tr>
					<td style="color:#ffffff;">
						<a href="javascript:xajax_modifProfil();undefined;" class="lienMenuPrincipal">{$user.nom} ({$user.user_id})</a>
					</td>
					<td>
						&nbsp;&nbsp;&nbsp;
						<a href="process/login.php?action=logout"><img src="{$BASE}/images/logout.png" style="height:24px" border="0"></a>

					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</div>

	<div id="divSousMenuPlanning" style="border: 1px solid #000000;background-color:#ffffff;position:absolute;z-index:100;display:none;" onMouseOut="masquerSousMenuDelai('divSousMenuPlanning');" onMouseOver="AnnuleMasquerSousMenu('divSousMenuPlanning');" onfocus="AnnuleMasquerSousMenu('divSousMenuPlanning')">
		<table cellspacing="6">
		<tr style="background-color:#474747;height:15px;">
			<td style="color:#ffffff;">
			</td>
		</tr>
		<tr>
			<td style="padding-right:20px;">
				<a href="{$BASE}/planning.php"><img src="{$BASE}/images/logo.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuAfficherPlanning#}</a>
				<div style="font-size:0;height:7px;"></div>
				{if !in_array("planning_readonly", $user.tabDroits)}
					<a href="javascript:Reloader.stopRefresh();xajax_ajoutPeriode();undefined;"><img src="{$BASE}/images/addplanning.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuAjouterPeriode#}</a>
					<div style="font-size:0;height:7px;"></div>
				{/if}
			</td>
		</tr>
		</table>
	</div>

	{if in_array("projects_manage_all", $user.tabDroits) || in_array("projects_manage_own", $user.tabDroits)}
		<div id="divSousMenuProjets" style="border: 1px solid #000000;background-color:#ffffff;position:absolute;z-index:100;display:none;" onMouseOut="masquerSousMenuDelai('divSousMenuProjets');" onMouseOver="AnnuleMasquerSousMenu('divSousMenuProjets');" onfocus="AnnuleMasquerSousMenu('divSousMenuProjets')">
			<table cellspacing="6">
			<tr style="background-color:#474747;height:15px;">
				<td style="color:#ffffff;">
				</td>
			</tr>
			<tr>
				<td style="padding-right:20px;">
					<a href="{$BASE}/projets.php"><img src="{$BASE}/images/projets.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuListeProjets#}</a>
					<div style="font-size:0;height:7px;"></div> 
					<a href="javascript:Reloader.stopRefresh();xajax_ajoutProjet();undefined;"><img src="{$BASE}/images/addprojet.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuAjouterProjet#}</a>
					<div style="font-size:0;height:7px;"></div>
					{if in_array("projectgroups_manage_all", $user.tabDroits)}
						<a href="groupe_list.php"><img src="{$BASE}/images/groupes.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuListeGroupes#}</a>
						<div style="font-size:0;height:7px;"></div>
					{/if}
				</td>
			</tr>
			</table>
		</div>
	{/if}

	{if in_array("users_manage_all", $user.tabDroits)}
		<div id="divSousMenuUsers" style="border: 1px solid #000000;background-color:#ffffff;position:absolute;z-index:100;display:none;" onMouseOut="masquerSousMenuDelai('divSousMenuUsers');" onMouseOver="AnnuleMasquerSousMenu('divSousMenuUsers');" onfocus="AnnuleMasquerSousMenu('divSousMenuUsers')">
			<table cellspacing="6">
			<tr style="background-color:#474747;height:15px;">
				<td style="color:#ffffff;">
				</td>
			</tr>
			<tr>
				<td style="padding-right:20px;">
					<a href="{$BASE}/user_list.php"><img src="{$BASE}/images/users.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuGestionUsers#}</a>
					<div style="font-size:0;height:7px;"></div> 
					<a href="javascript:xajax_modifUser();undefined;"><img src="{$BASE}/images/adduser.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuCreerUser#}</a>
					<div style="font-size:0;height:7px;"></div>
					<a href="{$BASE}/user_groupes.php"><img src="{$BASE}/images/user_groupes.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuGroupesUsers#}</a>
					<div style="font-size:0;height:7px;"></div> 
				</td>
			</tr>
			</table>
		</div>
	{/if}

	{if in_array("parameters_all", $user.tabDroits)}
		<div id="divSousMenuParametres" style="border: 1px solid #000000;background-color:#ffffff;position:absolute;z-index:100;display:none;" onMouseOut="masquerSousMenuDelai('divSousMenuParametres');" onMouseOver="AnnuleMasquerSousMenu('divSousMenuParametres');" onfocus="AnnuleMasquerSousMenu('divSousMenuParametres')">
			<table cellspacing="6">
			<tr style="background-color:#474747;height:15px;">
				<td style="color:#ffffff;">
				</td>
			</tr>
			<tr>
				<td style="padding-right:20px;">
					<a href="{$BASE}/options.php"><img src="{$BASE}/images/options.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuOptions#}</a>
					<div style="font-size:0;height:7px;"></div> 
					<a href="{$BASE}/feries.php"><img src="{$BASE}/images/feries.png" border="0" style="vertical-align:middle;padding-right:4px;">{#menuFeries#}</a>
					<div style="font-size:0;height:7px;"></div>
				</td>
			</tr>
			</table>
		</div>
	{/if}

{/if}

{if isset($smartyData.message)}
	{assign var=messageFinal value=$smartyData.message|formatMessage}
	<center>
		<div id="divMessage" class="message" {if $smartyData.message eq "changeNotOK"}style="color:ff0000"{/if}>
			<div class="row-fluid noprint">
				<div class="span1"></div>
				<div class="span10">
					{$messageFinal}
				</div>
				<div class="span1">
					<a href="javascript:fermerMessage();undefined;"><i class="icon-remove"></i></a>
				</div>
			</div>
		</div>
	</center>
	<br />
{/if}

{* cooltip pour les rollover, à laisser ici sinon ça genere un espace en haut de page *}
<script type="text/javascript" src="js/cooltip.js"></script>
<script type="text/javascript">ctPageDefaults(WIDTH, 260, FGCOLOR, '#EBEBE0', BORDER, 1, TEXTSIZE, '11px'); </script>
<div id="ctDiv" style="position: absolute; visibility: hidden; z-index: 1000;" class="divTooltip"></div>

<div class="container-fluid">
