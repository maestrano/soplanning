{* Smarty *}

<form action="" method="POST" onSubmit="return false;">

<br />
<table border="0" cellpadding="0" cellspacing="2" width="100%">
   <tr>
		<td>{#feries_date#}</td>
		<td>
			<input type="text" id="date_ferie" size="11" maxlength="10" value="{$ferie.date_ferie|sqldate2userdate}" style="width:80px" class="datepicker" />
		</td>
   </tr> 
   <tr>
		<td>{#feries_libelle#}</td>
		<td>
			<input id="libelle" size="30" maxlength="50" type="text" value="{$ferie.libelle}" />
		</td>
   </tr> 
	<tr>
		<td>
			&nbsp;
		</td>
		<td>
			<input type="button" value="{#submit#|escape:"html"}" onClick="xajax_submitFormFerie($('date_ferie').value, $('libelle').value);" class="btn" />
		</td>
	</tr>
</table>
</form>