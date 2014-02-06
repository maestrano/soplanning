
function toggle2(obj) {
	var el = document.getElementById(obj);
	if ( el.style.display != 'none' ) {
		el.style.display = 'none';
		setCookie(obj, 'none', 1000, '/');
	}
	else {
		el.style.display = '';
		setCookie(obj, '', 1000, '/');
	}
}

function getPosition(element, attribute) {
	// exemple : offsetLeft et offsetTop
	p = 0;
	while (element) {
		p += element[attribute];
		element = element.offsetParent;
	}
	return p;
}

//au format dd/mm/yyyy
function getDate(strDate){	  
	day = strDate.substring(0,2);
	month = strDate.substring(3,5) - 1;
	year = strDate.substring(6,10);
	d = new Date(year, month, day);
	return d;
}
//   0 si date_1=date_2
//   1 si date_1>date_2
//  -1 si date_1<date_2	  
function dateCompare(date_1, date_2){
	diff = date_1.getTime()-date_2.getTime();
	return (diff==0?diff:diff/Math.abs(diff));
}

function remplirDateFinPeriode() {
	if (document.getElementById('date_fin').value == '') {
		dateDebut = document.getElementById('date_debut').value;
		if (dateDebut != '') {
			document.getElementById('date_fin').value = dateDebut;
		}
	}
}

function remplirDateRepetition() {
	if (document.getElementById('dateFinRepetition').value == '') {
		dateDebut = document.getElementById('date_debut').value;
		if (dateDebut != '') {
			document.getElementById('dateFinRepetition').value = dateDebut;
		}
	}
	displayCalendar(document.getElementById('dateFinRepetition'),'dd/mm/yyyy', document.getElementById('boutonDateFinRepetition'));
}

function JSformProjet() {
	if (document.getElementById('projet_id').value == "") {
		alert(js_saisirIDProjet);
		return false;
	}

	if (document.getElementById('nom').value == "") {
		alert(js_saisirNomProjet);
		return false;
	}
	if (document.getElementById('couleur').value.length != 6) {
		alert(js_saisirCouleur);
		return false;
	}

	if (document.getElementById('charge').value != '' && (document.getElementById('charge').value <= 0 || document.getElementById('charge').value > 999)) {
		alert(js_saisirCharge);
		return false;
	}

	if (document.getElementById('livraison').value != '' && (document.getElementById('livraison').value <= 0 || document.getElementById('livraison').value > 52)) {
		alert(js_saisirSemaine);
		return false;
	}

	return true;
}

function controlDate(date) {
	if (date != '' && !date.match(/^\d\d\/\d\d\/\d\d\d\d$/)) {
		return false;
	}
	return true;
}

// FONCTIONS POUR PALETTE DE COULEUR
// fonction de mise à jour sur clic de couleur
function mkColor(v){
	$S('colorbox').background='#'+v;
	$('couleur').value= v;
}
// fonction d'affichage de la palette
function togglePalette() {
	loadSV();
	$S('plugin').display = ($S('plugin').display == 'none'?'block':'none');
	$S('plugin').left = getPosition(document.getElementById('colorbox'), 'offsetLeft') +20 + 'px';
	$S('plugin').top = getPosition(document.getElementById('colorbox'), 'offsetTop') +20 + 'px';
}
// FIN FONCTIONS POUR PALETTE DE COULEUR


var Drag = {

	obj : null,

	init : function(o, oRoot, minX, maxX, minY, maxY, bSwapHorzRef, bSwapVertRef, fXMapper, fYMapper)
	{
		o.onmousedown	= Drag.start;

		o.hmode			= bSwapHorzRef ? false : true ;
		o.vmode			= bSwapVertRef ? false : true ;

		o.root = oRoot && oRoot != null ? oRoot : o ;

		if (o.hmode  && isNaN(parseInt(o.root.style.left  ))) o.root.style.left   = "0px";
		if (o.vmode  && isNaN(parseInt(o.root.style.top   ))) o.root.style.top    = "0px";
		if (!o.hmode && isNaN(parseInt(o.root.style.right ))) o.root.style.right  = "0px";
		if (!o.vmode && isNaN(parseInt(o.root.style.bottom))) o.root.style.bottom = "0px";

		o.minX	= typeof minX != 'undefined' ? minX : null;
		o.minY	= typeof minY != 'undefined' ? minY : null;
		o.maxX	= typeof maxX != 'undefined' ? maxX : null;
		o.maxY	= typeof maxY != 'undefined' ? maxY : null;

		o.xMapper = fXMapper ? fXMapper : null;
		o.yMapper = fYMapper ? fYMapper : null;

		o.root.onDragStart	= new Function();
		o.root.onDragEnd	= new Function();
		o.root.onDrag		= new Function();
	},

	start : function(e)
	{
		var o = Drag.obj = this;
		
		e = Drag.fixE(e);

		// init des var permettant de vérifier si déplacement
		//origineCaseX = Drag.obj.offsetLeft;
		//origineCaseY = Drag.obj.offsetTop;
		origineCaseX = parseInt(Drag.obj.style.left);
		origineCaseY = parseInt(Drag.obj.style.top);

		var y = parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		o.root.onDragStart(x, y);

		o.lastMouseX	= e.clientX;
		o.lastMouseY	= e.clientY;

		if (o.hmode) {
			if (o.minX != null)	o.minMouseX	= e.clientX - x + o.minX;
			if (o.maxX != null)	o.maxMouseX	= o.minMouseX + o.maxX - o.minX;
		} else {
			if (o.minX != null) o.maxMouseX = -o.minX + e.clientX + x;
			if (o.maxX != null) o.minMouseX = -o.maxX + e.clientX + x;
		}

		if (o.vmode) {
			if (o.minY != null)	o.minMouseY	= e.clientY - y + o.minY;
			if (o.maxY != null)	o.maxMouseY	= o.minMouseY + o.maxY - o.minY;
		} else {
			if (o.minY != null) o.maxMouseY = -o.minY + e.clientY + y;
			if (o.maxY != null) o.minMouseY = -o.maxY + e.clientY + y;
		}

		document.onmousemove	= Drag.drag;
		document.onmouseup		= Drag.end;

		return false;
	},

	drag : function(e)
	{
		e = Drag.fixE(e);
		var o = Drag.obj;

		var ey	= e.clientY;
		var ex	= e.clientX;
		var y = parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		var nx, ny;

		if (o.minX != null) ex = o.hmode ? Math.max(ex, o.minMouseX) : Math.min(ex, o.maxMouseX);
		if (o.maxX != null) ex = o.hmode ? Math.min(ex, o.maxMouseX) : Math.max(ex, o.minMouseX);
		if (o.minY != null) ey = o.vmode ? Math.max(ey, o.minMouseY) : Math.min(ey, o.maxMouseY);
		if (o.maxY != null) ey = o.vmode ? Math.min(ey, o.maxMouseY) : Math.max(ey, o.minMouseY);

		nx = x + ((ex - o.lastMouseX) * (o.hmode ? 1 : -1));
		ny = y + ((ey - o.lastMouseY) * (o.vmode ? 1 : -1));

		if (o.xMapper)		nx = o.xMapper(y)
		else if (o.yMapper)	ny = o.yMapper(x)

		Drag.obj.root.style[o.hmode ? "left" : "right"] = nx + "px";
		Drag.obj.root.style[o.vmode ? "top" : "bottom"] = ny + "px";
		Drag.obj.lastMouseX	= ex;
		Drag.obj.lastMouseY	= ey;

		Drag.obj.root.onDrag(nx, ny);
		return false;
	},

	end : function()
	{
		document.onmousemove = null;
		document.onmouseup   = null;
		Drag.obj.root.onDragEnd(	parseInt(Drag.obj.root.style[Drag.obj.hmode ? "left" : "right"]), 
									parseInt(Drag.obj.root.style[Drag.obj.vmode ? "top" : "bottom"]));

		// on n'execute les détections de destinations que s'il y a eu un déplacement
		if(origineCaseX != parseInt(Drag.obj.style.left) || origineCaseY != parseInt(Drag.obj.style.top)) {
			// on teste les coordonnées des destinations possibles pour voir si ça matche
			destination = null;
			for(i=0;i<destinationsDrag.length;i++) {
				centreDivX = parseInt(getPosition(Drag.obj, 'offsetLeft')) + parseInt(Drag.obj.offsetWidth)/2;
				centreDivY = parseInt(getPosition(Drag.obj, 'offsetTop')) + parseInt(Drag.obj.offsetHeight)/2;
				caseCouranteX = parseInt(getPosition(document.getElementById(destinationsDrag[i]), 'offsetLeft'));
				caseCouranteY = parseInt(getPosition(document.getElementById(destinationsDrag[i]), 'offsetTop'));
				caseCouranteWidth = parseInt(document.getElementById(destinationsDrag[i]).offsetWidth);
				caseCouranteHeight = parseInt(document.getElementById(destinationsDrag[i]).offsetHeight);
				if ((centreDivX >= caseCouranteX) && 
					(centreDivX <= caseCouranteX + caseCouranteWidth) &&
					(centreDivY >= caseCouranteY) &&
					(centreDivY <= caseCouranteY + caseCouranteHeight)
					) {
					//alert('Matching : ' + destinationsDrag[i]);
					destination = destinationsDrag[i];
					break;
				}

			}
			// fin de détection

			// fenetre d'info si pas de destination détectée
			if (destination == null) {
				windowErreurDeplacement();
				// renvoi de l'objet à son endroit de départ
				Drag.obj.style.left = origineCaseX + "px";
				Drag.obj.style.top = origineCaseY + "px";
			} else {
				// appel ajax pour appliquer le déplacement : on donne la case à déplacer et le jour de destination
				idCaseEnCoursDeplacement = Drag.obj.id;
				idCaseDestination = destination;
				afficherSousMenu('divChoixDragNDrop', Drag.obj.id);
			}
		}
		// destruction de l'objet de drag n drop
		Drag.obj = null;
	},

	fixE : function(e)
	{
		if (typeof e == 'undefined') e = window.event;
		if (typeof e.layerX == 'undefined') e.layerX = e.offsetX;
		if (typeof e.layerY == 'undefined') e.layerY = e.offsetY;
		return e;
	}
};


function windowErreurDeplacement() {
	nomWindow = 'infoDeplacement' + Math.round(Math.random()*1000);
	winInfoDeplacement = new Window(nomWindow, {className: "charte1", title: "Info Déplacement", width:400, height:30, destroyOnClose: true, recenterAuto:true, minimizable:false, maximizable:false, draggable:false, closable:false});
	winInfoDeplacement.setHTMLContent('<div align="center" style="color:#FF0000;font-weight:bold;">' + js_deposerCaseSurDate + '</div>');
	winInfoDeplacement.showCenter(false, 30, undefined);
	setTimeout("Windows.close('" + nomWindow + "');", 1000);
}

function windowDeplacementOK() {
	nomWindow = 'infoDeplacement' + Math.round(Math.random()*1000);
	winInfoDeplacement = new Window(nomWindow, {className: "charte1", title: "Info Déplacement", width:400, height:30, destroyOnClose: true, recenterAuto:true, minimizable:false, maximizable:false, draggable:false, closable:false});
	winInfoDeplacement.setHTMLContent('<div align="center" style="color:#FF0000;font-weight:bold;">' + js_deplacementOk + '</div>');
	winInfoDeplacement.showCenter(false, 30, undefined);
	setTimeout("Windows.close('" + nomWindow + "');", 1000);
}

function windowPatienter() {
	nomWindow = 'patienter' + Math.round(Math.random()*1000);
	winInfoDeplacement = new Window(nomWindow, {className: "charte1", title: "...", width:400, height:30, destroyOnClose: true, recenterAuto:true, minimizable:false, maximizable:false, draggable:false, closable:false});
	winInfoDeplacement.setHTMLContent('<div align="center" style="color:#000000;font-weight:bold;">' + js_patienter + '</div>');
	winInfoDeplacement.showCenter(false, 30, undefined);
}

function assombrirPage () {
	var page_screen;
	if ( ! document.getElementById ('page_screen')) {
		page_screen = document.createElement ('DIV');
		page_screen.id = "page_screen";
		var body = document.getElementsByTagName ('BODY')[0];
		body.insertBefore (page_screen, body.firstChild);
	} else {
		page_screen = document.getElementById ('page_screen');
	}
	page_screen.style.height = Math.max (document.body.scrollHeight, document.body.clientHeight) + 'px';
	page_screen.style.width = Math.max (document.body.scrollWidth, document.body.clientWidth) + 'px';
	page_screen.style.display = 'block';
}


function retablirPage () {
	var page_screen = document.getElementById ('page_screen');
	page_screen.style.display = 'none';
}

function addEvent( obj, type, fn ) {
	if ( obj.attachEvent ) {
		obj['e'+type+fn] = fn;
		obj[type+fn] = function(){obj['e'+type+fn]( window.event );}
		obj.attachEvent( 'on'+type, obj[type+fn] );
	} else
		obj.addEventListener( type, fn, false );
}


function addLoadEvent(func) {
   var oldonload = window.onload;
   alert(typeof window.onload);
   if (typeof window.onload != "function") {
	  window.onload = func;
   } else {
	  window.onload = function() {
		 if (oldonload) {
			oldonload();
		 }
		 func();
	  };
   }
}


var Reloader = {
	CONFIG_REFRESH_TIMER : 0,
	REFRESH_BLOCKED : false,
	STOP_REFRESH : false,
	UPDATE_STATUS : true,

	init : function(CONFIG_REFRESH_TIMER)
	{
		Reloader.CONFIG_REFRESH_TIMER = CONFIG_REFRESH_TIMER;
		setInterval("Reloader.checkRefresh()", CONFIG_REFRESH_TIMER*1000);
	},

	checkRefresh : function()
	{
		Reloader.UPDATE_STATUS = true;
		if (Reloader.STOP_REFRESH) {
			return;
		}
		top.location.reload();
	},

	stopRefresh : function()
	{
		Reloader.UPDATE_STATUS = false;
		Reloader.STOP_REFRESH = true;
	},
	
	closeWindow : function()
	{
		Reloader.STOP_REFRESH = false;
		if (Reloader.UPDATE_STATUS) {
			top.location.reload();
		}
	}
};

// fonction d'affichage de la palette
function togglePalette() {
	loadSV();
	$S('plugin').display = ($S('plugin').display == 'none'?'block':'none');
	$S('plugin').left = getPosition(document.getElementById('colorbox'), 'offsetLeft') +20 + 'px';
	$S('plugin').top = getPosition(document.getElementById('colorbox'), 'offsetTop') +20 + 'px';
}
// FIN FONCTIONS POUR PALETTE DE COULEUR

function desactiverRappelVersion() {
	setCookie('infosVersionInactif', '1', 30, '/');
	document.getElementById('infosVersion').style.display = 'none';
}


// création, lecture et suppression de cookie
function getCookie( name ) {
	var start = document.cookie.indexOf( name + "=" );
	var len = start + name.length + 1;
	if ( ( !start ) && ( name != document.cookie.substring( 0, name.length ) ) ) {
		return null;
	}
	if ( start == -1 ) return null;
	var end = document.cookie.indexOf( ";", len );
	if ( end == -1 ) end = document.cookie.length;
	return unescape( document.cookie.substring( len, end ) );
}
	
function setCookie( name, value, expires, path, domain, secure ) {
	var today = new Date();
	today.setTime( today.getTime() );
	if ( expires ) {
		expires = expires * 1000 * 60 * 60 * 24;
	}
	var expires_date = new Date( today.getTime() + (expires) );
	document.cookie = name+"="+escape( value ) +
		( ( expires ) ? ";expires="+expires_date.toGMTString() : "" ) + //expires.toGMTString()
		( ( path ) ? ";path=" + path : "" ) +
		( ( domain ) ? ";domain=" + domain : "" ) +
		( ( secure ) ? ";secure" : "" );
}
	
function deleteCookie( name, path, domain ) {
	if ( getCookie( name ) ) document.cookie = name + "=" +
			( ( path ) ? ";path=" + path : "") +
			( ( domain ) ? ";domain=" + domain : "" ) +
			";expires=Thu, 01-Jan-1970 00:00:01 GMT";
}


// fonctions pour textarea auto-enlarge
function attachAutoResizeEvents(obj)
{
	var txtX=document.getElementById(obj)
	var minH=txtX.style.height.substr(0,txtX.style.height.indexOf('px'))
	txtX.onchange=new Function("resize(this,"+minH+")")
	txtX.onkeyup=new Function("resize(this,"+minH+")")
	txtX.onchange(txtX,minH)
}
function resize(txtX,minH)
{   txtX.style.height = 'auto' // required when delete, cut or paste is performed
    txtX.style.height = txtX.scrollHeight+'px'
    if(txtX.scrollHeight<=minH)
        txtX.style.height = minH+'px'
}


function getRadioValue(idOrName) {
	var value = null;
	var element = document.getElementById(idOrName);
	var radioGroupName = null;  

	// if null, then the id must be the radio group name
	if (element == null) {
		radioGroupName = idOrName;
	} else {
		radioGroupName = element.name;
	}
	if (radioGroupName == null) {
		return null;
	}
	var radios = document.getElementsByTagName('input');
	for (var i=0; i<radios.length; i++) {
		var input = radios[ i ];
		if (input.type == 'radio' && input.name == radioGroupName && input.checked) {
			value = input.value;
			break;
		}
	}
	return value;
}

function fermerMessage() {
	document.getElementById('divMessage').style.display = "none";
}

// pour scripts au chargement de la page
function initAll() {
	jQuery.datepicker.setDefaults({dateFormat:"dd/mm/yy"});
	WindowCloseKey.init();
}
