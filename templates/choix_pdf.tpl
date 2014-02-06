{* Smarty *}

<br />
<form target="_blank" action="export_pdf.php" method="GET">

<table cellspacing="2" width="100%">
<tr>
	<td align="right">{#PDFExport_orientation#} :</td>
	<td>
		<select name="pdf_orientation" id="orientation">
			<option value="paysage" {if $pdf_orientation eq "paysage"}selected="selected"{/if}>{#PDFExport_orientation_paysage#}</option>
			<option value="portrait" {if $pdf_orientation eq "portrait"}selected="selected"{/if}>{#PDFExport_orientation_portrait#}</option>
		</select>
	</td>
</tr>
<tr>
	<td align="right">{#PDFExport_format#} :</td>
	<td>
		<select name="pdf_format" id="format">
			<option value="A4" {if $pdf_format eq "A4"}selected="selected"{/if}>A4</option>
			<option value="A3" {if $pdf_format eq "A3"}selected="selected"{/if}>A3</option>
			<option value="A2" {if $pdf_format eq "A2"}selected="selected"{/if}>A2</option>
			<option value="A1" {if $pdf_format eq "A1"}selected="selected"{/if}>A1</option>
			<option value="A0" {if $pdf_format eq "A0"}selected="selected"{/if}>A0</option>
		</select>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<input type="submit" class="btn" value="{#winPeriode_valider#|escape:"html"}" />
	</td>
</tr>
</table>
</form>
