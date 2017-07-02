<% @ LANGUAGE="VBScript"%>
<% 'Response.Buffer = True %>
<%
'*************** [ NOTICE ] *********************
' COPYRIGHT (c) 2001 TradeBonds.com
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.

'************************************************


function makeLink(whereTo)
	makeLink = "events.asp?v1=" & whereTo
end function

const SESSION_LOGGED = "SLOG"
const SESSION_SUPER = "SUPR"
const SESSION_INSTONLY = "IOLY"
const SESSION_USERID = "SUID"
const SESSION_USERNAME = "SUNM"
const SESSION_NAME = "SNAM"
const SESSION_USERSTUDENTID = "SUID"
' Added by Mamoru 2/7/2005
const SESSION_ACCOUNTING = "ACCT"
const SESSION_FACILITYOPS = "FAOP"
const SESSION_CHILDREN = "CHLD"
const SESSION_CHILDRENCOUNT = "CHCT"
const SESSION_PUSERID = "USID"
const SESSION_SPECAGE = "SPAG"
'--------------------------------------------------------------------------------------
%>


<!DOCTYPE html>

<html>
<head>
    <base href="">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

	<title><%=Application("YCOA")%> Pre Reg</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />



	<link rel="stylesheet" href="/Styles/bootstrap_override.css" type="text/css" />

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" />



	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="./Scripts/spin.min.js"></script>
  <script src="./Scripts/jquery.spin.js"></script>

  <script>
    var jq = $.noConflict();
  </script>

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

	 <!-- <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
 <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular-route.js"></script> -->


<script language="JavaScript">
<% if session(SESSION_LOGGED) = 1 then %>
<%Dim sessionStudentList
if session(SESSION_CHILDRENCOUNT) > 0 then%>
<%
	dim counter
	counter = 0
	do while counter < session(SESSION_CHILDRENCOUNT)

sessionStudentList = sessionStudentList & """" & split(session(SESSION_CHILDREN)(counter), "-")(0) & "-" & split(session(SESSION_CHILDREN)(counter), "-")(1) &""","

	counter = counter + 1
	loop
	sessionStudentList = Mid(sessionStudentList, 1, len(sessionStudentList) - 1)
%>

var Session_StudentList = [<%=sessionStudentList%>]
var Session_Region = "<%=Application("YC")%>";
var Session_SpecAge = <%=session(SESSION_SPECAGE)%>;
<%end if%>
var Session_UserID = <%=session(SESSION_PUSERID)%>;
<%end if%>


  var mac = navigator.appVersion.indexOf("Mac")>-1
	    if (navigator.appName == "Netscape" && parseFloat(navigator.appVersion) > 5.00)
		{
			document.write ("<link rel=\"stylesheet\" href=\"Styles/NSstyle6.css\" type=\"text/css\">")
		}
		else if (navigator.appName == "Netscape" && parseFloat(navigator.appVersion) < 5.00)
		{
			document.write ("<link rel=\"stylesheet\" href=\"Styles/NSstyle47.css\" type=\"text/css\">")
		}
		else if (navigator.appName == "Netscape" && navigator.appVersion=="4.7 [en] (WinNT; U)")
		{
			document.write ("<link rel=\"stylesheet\" href=\"Styles/NSstyle47.css\" type=\"text/css\">")
		}
		else
		{
	    	document.write ("<link rel=\"stylesheet\" href=\"Styles/IEstyle.css\" type=\"text/css\">")
	    }


		function MM_swapImgRestore() { //v3.0
		  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
		}

		function MM_preloadImages()
		{ //v3.0
		  var d=document;
		  if(d.images)
		  {
		  	if(!d.MM_p)
				d.MM_p=new Array();
		    var i, j = d.MM_p.length, a = MM_preloadImages.arguments;
			for(i=0; i<a.length; i++)
		    	if (a[i].indexOf("#")!=0)
				{
					d.MM_p[j]=new Image;
					d.MM_p[j++].src=a[i];
				}
		   }
		 }

		function MM_findObj(n, d) { //v4.0
		  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
		    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
		  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
		  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
		  if(!x && document.getElementById) x=document.getElementById(n); return x;
		}

		function MM_swapImage() { //v3.0
		  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
		   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
		}

function popAEM(site)
{
	if(site == "aemclu.asp")
		var popAEM = window.open("aemclu.asp", "popAEM", 'directories=0,height=200,width=320,scrollbars=yes');
	if(site == "aemilu.asp")
		var popAEM = window.open("aemilu.asp", "popAEM", 'directories=0,height=200,width=320,scrollbars=yes');
	if(site == "aemllu.asp")
		var popAEM = window.open("aemllu.asp", "popAEM", 'directories=0,height=200,width=300,scrollbars=yes');
}

function toggle (blnVisiable, strObjectName)
{
	var myElement = document.getElementById(strObjectName);
	if (blnVisiable)
	{
		myElement.style.visibility = "visible";
		myElement.style.display = "block";
	}
	else
	{
		myElement.style.visibility = "hidden";
		myElement.style.display = "none";
	}
}

function autoJumpFocus(from, to, length)
{

	if(from.value.length >= length)
		to.focus();

	return true;
}

function validateCode(checkCode, cat, base)
{
	if (checkCode != "")
		var validateCode = window.open("validateCode.asp?checkCode="+checkCode+"&cat="+cat+"&base="+base+"", "validateCode", 'directories=0,height=100,width=420');
}

function ltrim(str)
{
	while (str.charCodeAt(0) == 32)
		str = str.substr(1);
	return str;
}

function rtrim(str)
{
	while (str.charCodeAt(str.length - 1) == 32)
		str = str.substr(0, str.length - 1);
	return str;
}

function trim(str)
{
	return rtrim(ltrim(str));
}

function popPicture(file)
{
	var popPicture = window.open("", "popPicture", 'directories=0,height=400,width=600,scrollbars=yes');
}

// This function formats a name (first character upper case, rest lower). This is only
// performed when a field is filled in the first time, so that the user can change the
// format if needed.  Required are the ID of the input field as the parameter and the
// existence of a hidden field with the same ID plus the string: 'Hid'.
function FormatName(ElementID)
{
	if (document.all[ElementID+'Hid'].value == 0)
	{
		var strName = trim(document.all[ElementID].value);
		strName = strName.substr(0,1).toUpperCase() + strName.substr(1).toLowerCase();
		if (strName.substr(0,2) == "O'" || strName.substr(0,2) == "Mc")
			strName = strName.substr(0,2) + strName.substr(2,1).toUpperCase() + strName.substr(3);
		document.all[ElementID].value = strName;
		document.all[ElementID+'Hid'].value = 1;
	}
}

// Function that checks whether a string conists of any invalid characters
// and returns true/false or the trimmed string in upper case.
function CheckInput(strInput,para)
{
	strInput = trim(strInput).toUpperCase();
	if (strInput.length == 0) return true;
	for (i = 0; i < strInput.length; i++)
	{
		CharToCheck = strInput.charCodeAt(i);

		// Only letters are valid characters.
		if (para == 0)
		{
			if (CharToCheck < 65 || CharToCheck > 90)
				return false;
		}

		// The dot, spaces, numbers and letters are valid characters.
		else if (para == 1)
		{
			if (((CharToCheck == 46 || CharToCheck == 32) || (CharToCheck >= 48 && CharToCheck <= 57) || (CharToCheck >= 65 && CharToCheck <= 90)) == false)
				return false;
		}

		else
			return false;
	}
	return strInput;
}

function roundOff(value)
{
	if (value == 0)
		return 0;
	else if (isNaN(value))
		return false;
	else
	{
		var result = Math.round(value*100)/100 ;
		return result;
	}
}

function checkdate(para)
// Function accepts dates in the form 'month/day/year' or 'month-day-year',
// but does not require two-digit months and days or 4 digit years.
{
	var a = trim(para);
	var mm;
	var dd;
	var yyyy;
	var mdy;
	var i, j;

	if (a.length == 0)
		return true;

	// Basic error checking
	if (a.length < 6)
		return false;

	// Checking to accept and convert date string that has exactly 6 characters
	if (a.length == 6)
	{
		for (j=0; j<6; j++)
		{
			if (isNaN(a.charAt(j)))
				return false;
		}
		var month1 = new String(a.charAt(0));
		var month2 = new String(a.charAt(1));
		var day1 = new String(a.charAt(2));
		var day2 = new String(a.charAt(3));
		var year1 = new String(a.charAt(4));
		var year2 = new String(a.charAt(5));
		var yy;
		mm=month1+month2;
		dd=day1+day2;
		yy=year1+year2;

		if (yy > 50)
			yyyy = '19' + yy;
		else
			yyyy = '20' + yy;
		return (mm + '/' + dd + '/' + yyyy);
	}
	else
	{
		a = a.replace('-','/');
		a = a.replace('-','/');

		// separate the month, day and year
		// and save results in an array
		mdy = a.split('/');
		if (mdy.length != 3)
			return false;

		// check for invalid characters
		for (i in mdy)
		{
			if (isNaN(mdy[i]))
				return false;
		}

		// check lenght of day, month, year and
		// add the 'missing didgits' if necessary
		if (mdy[0].length <= 2)
			mm = mdy[0];
		else
			return false;

		if (mdy[1].length <= 2)
			dd = mdy[1];
		else
			return false;

		if (mdy[2].length == 4)
			yyyy = mdy[2];
		else if ((mdy[2].length == 2))
		{
			if (mdy[2] > 50)
				yyyy = '19' + mdy[2];
			else
				yyyy = '20' + mdy[2];
		}
		else
			return false;

		//basic logic checking
		if (mm<1 || mm>12) return false;
		if (dd<1 || dd>31) return false;
		if (yyyy<0 || yyyy>9999) return false;

		//advanced logic checking

		// months with 30 days
		if (mm==4 || mm==6 || mm==9 || mm==11)
		{
			if (dd==31)
				return false;
		}

		// february, leap year
		if (mm==2)
		{
			// feb
			var g=parseInt(yyyy/4);
			if (isNaN(g))
				return false;

			if (dd > 29)
				return false;
			if (dd==29 && ((yyyy/4)!=parseInt(yyyy/4)))
				return false;
		}

		// the return value can be used to update the date string
		// the date string or field to guarantee the form: mm/dd/yyyy.
		if (yyyy < 1900)
			return false;
		return (mm + '/' + dd + '/' + yyyy);
	}
}

var MessageWin;
function RepGenerated()
{
	MessageWin = window.open("popMessageWin.asp?text=One Moment please, the report is being generated...&timeout=0", "MessageWin", 'directories=0,height=100,width=300');
}


var defaultEmptyOK = false;
function isInteger (s)
{
	var i;
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (!isDigit(c)) return false;
    }
    return true;
}

function isNumber (s)
{
	var i;
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (!isDigit(c) && c!='-' && c!='.') return false;
    }
    return true;
}

function ascii_value (c)
{
	c = c . charAt (0);

	var i;
	for (i = 0; i < 256; ++ i)
	{
		var h = i . toString (16);
		if (h . length == 1)
			h = "0" + h;

		h = "%" + h;
		h = unescape (h);
		if (h == c)
			break;
	}
	return i;
}

function containApostrophe(s)
{
	var i;
    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (ascii_value(c)==39) return true;
    }
    return false;
}

function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}
</script>

<!--<script src="./Scripts/events.module.js"></script>
<script src="./Scripts/shared/api.factory.js"></script>
<script src="./Scripts/shared/dateToDay.filter.js"></script>
<script src="./Scripts/shared/student-registration.directive.js"></script>
<script src="./Scripts/shared/angular-modal-service.factory.js"></script>
<script src="./Scripts/shared/utilities.factory.js"></script>
<script src="./Scripts/cart/cart.controller.js"></script>
<script src="./Scripts/cart/cart.factory.js"></script>
<script src="./Scripts/cart/models/cart-class-registration.model.js"></script>
<script src="./Scripts/cart/models/cart-event-registration.model.js"></script>
<script src="./Scripts/classes/classes.controller.js"></script>
<script src="./Scripts/classes/classes.factory.js"></script>
<script src="./Scripts/classes/classes-student-modal.controller.js"></script>
<script src="./Scripts/classes/models/classes.model.js"></script>
<script src="./Scripts/classes/models/classes-registration.model.js"></script>
<script src="./Scripts/classes/models/classes-student.model.js"></script>
<script src="./Scripts/events/tournament-list.controller.js"></script>
<script src="./Scripts/events/tournament-detail.controller.js"></script>
<script src="./Scripts/events/student-registration-modal.controller.js"></script>
<script src="./Scripts/events/tournament.factory.js"></script>
<script src="./Scripts/events/tournament-api.factory.js"></script>
<script src="./Scripts/events/models/tournament.model.js"></script>
<script src="./Scripts/events/models/karate-event.model.js"></script>
<script src="./Scripts/events/models/camp-sale-item.model.js"></script>
<script src="./Scripts/events/models/sale-item.model.js"></script>
<script src="./Scripts/events/models/event-registration.model.js"></script>
<script src="./Scripts/events/models/student-registration.model.js"></script>
<script src="./Scripts/user/eventsUserRegister.controller.js"></script>
<script src="./Scripts/user/userModel.js"></script>
<script src="./Scripts/student/student.controller.js"></script>
<script src="./Scripts/student/studentModel.js"></script>
<script src="./Scripts/student/studentCreateUpdate.controller.js"></script>
<script src="./Scripts/student/studentCreateUpdate.factory.js"></script>
<script src="./Scripts/sportRankModal.controller.js"></script>-->
</head>

<body ng-app="app" ng-cloak>

<!-- Header -->
<!--#INCLUDE FILE="eventsHeader.asp"-->

<!-- Main Content -->
<div id="content-main">
	<%
	' If no page is specified, load the log-in page as default.
		if len(request("v1")) = 0 then
			dim preURL
			preURL = request("HTTP_REFERER")
			if instr(preURL, "main.asp") > 0 then
			%>
				<table><tr><td align="center"><span class="redtext">You have successfully logged out.</span></td></tr></table>
			<%
			end if
				server.execute("eventslogin.asp")
		else

				if not request("rep") = "" then response.write("<scr" & "ipt language=""javascript"">" & vbCRLF & "RepGenerated();" & vbCRLF & "</script>")

				server.execute(request("v1"))

		end if
	%>


</div>
<!-- Footer -->
<!--#INCLUDE FILE="footer.asp"-->

</body>
</html>
