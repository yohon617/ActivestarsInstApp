<% @ LANGUAGE="VBScript"%>
<% option explicit %>
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

'const SESSION_LOGGED = "SLOG"
'const SESSION_SUPER = "SUPR"
'const SESSION_INSTONLY = "IOLY"
'const SESSION_USERID = "SUID"
'const SESSION_USERNAME = "SUNM"
'const SESSION_NAME = "SNAM"
'const SESSION_USERSTUDENTID = "SUID"
' Added by Mamoru 2/7/2005
'const SESSION_ACCOUNTING = "ACCT"
'const SESSION_FACILITYOPS = "FAOP"
'const SESSION_CHILDREN = "CHLD"
'const SESSION_CHILDRENCOUNT = "CHCT"
'const SESSION_PUSERID = "USID"
'const SESSION_SPECAGE = "SPAG"
'--------------------------------------------------------------------------------------
%>


<!DOCTYPE html>

<html>
<head>
    <base href="/">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

	<title><%=Application("YCOA")%> Instructor App</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />



	<link rel="stylesheet" href="/Styles/bootstrap_override.css" type="text/css" />
	<link rel="stylesheet" href="/Styles/IEStyle.css" type="text/css" />

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" />



	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="./Scripts/spin.min.js"></script>
  <script src="./Scripts/jquery.spin.js"></script>

  <script>
    var jq = $.noConflict();
  </script>

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>



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

</script>
</head>

<body>

<!-- Header -->
<!--#INCLUDE FILE="eventsHeader.asp"-->

<!-- Main Content -->
<div id="content-main">
	<!--#include file="eventsglobal.asp"-->
	<div name="Headline" id="headline">
		<div ALIGN="CENTER" class="BodyHeaderTitle" width="302">
			Start
		</div>
	</div>
	<div class="container main-content">
		<div class="panel panel-default">
			<div class="panel-body">
              <app-root></app-root>
			</div>
		</div>
			
	</div>

</div>
<!-- Footer -->
<!--#INCLUDE FILE="footer.asp"-->
  
  <script type="text/javascript" src="inline.bundle.js"></script>
  <script type="text/javascript" src="polyfills.bundle.js"></script>
  <script type="text/javascript" src="styles.bundle.js"></script>
  <script type="text/javascript" src="vendor.bundle.js"></script>
  <script type="text/javascript" src="main.bundle.js"></script>
</body>
</html>
