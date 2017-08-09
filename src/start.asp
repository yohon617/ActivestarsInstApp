<% @ LANGUAGE="VBScript"%>
<% option explicit %>
<% 'Response.Buffer = True %>



<!DOCTYPE html>

<html lang="en">
<head>
    <base href="/">
  
  <!-- Enable bootstrap 4 theme -->
  <script>window.__theme = 'bs4';</script>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

	<title><%=Application("YCOA")%> Instructor App</title>

<script language="JavaScript">
<% if session(SESSION_LOGGED) = 1 then %>

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
	<!--<div name="Headline" id="headline">
		<div ALIGN="CENTER" class="BodyHeaderTitle" width="302">
			Start
		</div>
	</div>-->
	<div class="container main-content">
		<!--<div class="panel panel-default">-->
			<div class="panel-body ag2-panel-body">
              <app-root></app-root>
			</div>
		<!--</div>-->
			
	</div>

</div>
<!-- Footer -->
<!--#INCLUDE FILE="footer.asp"-->
  <!--<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>-->
  <script type="text/javascript" src="inline.bundle.js"></script>
  <script type="text/javascript" src="polyfills.bundle.js"></script>
  <script type="text/javascript" src="styles.bundle.js"></script>
  <script type="text/javascript" src="vendor.bundle.js"></script>
  <script type="text/javascript" src="main.bundle.js"></script>
</body>
</html>
