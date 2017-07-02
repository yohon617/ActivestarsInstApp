<!--#include file="eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************

Dim lg_objConn
Dim lg_rs
Dim lg_Failed
Dim popWin

Dim phoneNumber
dim birthday
dim email


phoneNumber = "99"
birthday = "1/1/1990"
email = "99"

if len(Request("username")) > 0 and len(Request("password")) > 0 then
	
	
	
	Set lg_objConn = Server.CreateObject("ADODB.Command")
	With lg_objConn
		.ActiveConnection = Application("strConn")
		.CommandText = "a_events_get_login"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@pUsername", adVarchar, adParamInput,50,Request ("username"))
		.Parameters.Append .CreateParameter("@pPassword", adVarchar, adParamInput,50,Request ("password"))		
		
	Set lg_rs = .execute
	
	End With


' ----------------------------------------------------------------------------------------
	if not lg_rs.EOF then


		session(SESSION_NAME) = trim(lg_rs("elFirstName")) & " " & trim(lg_rs("elLastName"))
		session(SESSION_USERSTUDENTID) = ""
		session(SESSION_USERSTUDENTNAME) = ""
		session(SESSION_PUSERID) = lg_rs("elID")
		session(SESSION_USERNAME) = "wtam"'ucase(lg_rs("usUsername"))
		session(SESSION_SPORT) = ""
		session(SESSION_EMAIL) = trim(lg_rs("elEmail"))
		session(SESSION_AGE) = ""
		session(SESSION_STUDENT) = 1
		session(SESSION_LOGGED) = 1
		session(SESSION_RECEIVED) = 1
		session(SESSION_NOMESSAGE) = 0
		session(SESSION_NEXTTRANS) = ""
		session(SESSION_LASTACCESSED) = now
		session(SESSION_TIMEOUT) = Application("Student_Timeout")
		session(SESSION_SPECAGE) = 12
		if Application("YC") = "Arizona / Texas" or Application("YC") = "Kansas" then
			session(SESSION_SPECAGE) = 8
		elseif Application("YC") = "Northwest" then
			session(SESSION_SPECAGE) = 17
		end if
		
		
		'set connInst = Server.CreateObject("ADODB.connection")
		'connInst.Open Application("strConn")
		'set instRS = connInst.execute("a_events_get_studInstNameLoc "&lg_rs("stID"))

		'if not instRS.eof then
			'session(SESSION_INSTNAME) = trim(instRS("instName"))
			'session(SESSION_CLSLOC) = trim(instRS("loc"))
		'else
			session(SESSION_INSTNAME) = "n/a"
			session(SESSION_CLSLOC) = "n/a"
		'end if
		
		'a_events_get_ParentChildren
		dim connChildrenList
		dim childrenListRS
		dim childrenCount
		childrenCount = 0
		dim childrenList
		
		set connChildrenList = Server.CreateObject("ADODB.connection")
		connChildrenList.Open Application("strConn")
		set childrenListRS = connChildrenList.execute("a_events_get_ParentChildren "&session(SESSION_PUSERID))
		if not childrenListRS.eof then
			session(SESSION_USERSTUDENTID) = childrenListRS("lcStudentID")
			
			dim instRS
			dim connInst
			set connInst = Server.CreateObject("ADODB.connection")
			connInst.Open Application("strConn")
			set instRS = connInst.execute("a_events_get_studInstNameLoc "&session(SESSION_USERSTUDENTID))

			if not instRS.eof then
				session(SESSION_INSTNAME) = trim(instRS("instName"))
				session(SESSION_CLSLOC) = trim(instRS("loc"))
			end if
			
			set instRS = connInst.execute("a_events_get_StudNameSport "&session(SESSION_USERSTUDENTID))

			if not instRS.eof then
				session(SESSION_USERSTUDENTNAME) = trim(instRS("studname"))
				session(SESSION_SPORT) = trim(instRS("stsport"))
				session(SESSION_AGE) = trim(instRS("stage"))
			end if
			
			set connInst = nothing
			
			childrenList = childrenListRS("lcStudentID") & "-" & childrenListRS("studentname")
			childrenCount = childrenCount + 1
			childrenListRS.MoveNext
		end if
		do while not childrenListRS.eof
			childrenList = childrenList &  "," & childrenListRS("lcStudentID") & "-" & childrenListRS("studentname")
			childrenCount = childrenCount + 1
			childrenListRS.MoveNext
		loop

		session(SESSION_CHILDRENCOUNT) = childrenCount
		childrenList = split(childrenList, ",")
		if childrenCount > 0 then
			session(SESSION_CHILDREN) = childrenList
		end if
		response.redirect("/start.asp")
	else
		lg_Failed = 1
	end if
end if

' ----------------------------------------------------------------------------------------
	'if not lg_rs.EOF then

		
'		session(SESSION_LOGGED) = 1
'		session(SESSION_RECEIVED) = 1
'		session(SESSION_NOMESSAGE) = 0
'		session(SESSION_NEXTTRANS) = ""
'		session(SESSION_LASTACCESSED) = now
	'end if
%>
<br><br>
<body onload="document.form_student_login.username.focus();">
<div class="container">
	<form action="<%=makelink("eventslogin.asp")%>" method="post" name="form_student_login" id="form_student_login" onsubmit="return CheckSubmit();"> 
		<div class="panel panel-default">
			<div class="panel-body panel-signin">
				<div class="form-signin clearfix">
					<%if Application("YC") <> "Michigan" then%>
					<div class="panel-body login-logo">
						<img src="/img/gold-star.png">
					</div>
					<%end if%>
					
					<div class="panel-body login-form clearfix">
						<h2 class="form-signin-heading">Parent Sign In</h2>
						<%if lg_Failed = 1 then%>
						<div>
							<span class="redtext">Login failed.</span>
						</div>
						<%end if%>
						<label for="inputEmail" class="sr-only">Username</label>
						<input type="text" id="username" name="username" class="form-control" placeholder="Username" required="" autofocus="">
						<label for="inputPassword" class="sr-only">Password</label>
						<input type="password" id="password" name="password" class="form-control" placeholder="Password" required="">
						<!--div class="checkbox">
						  <label>
							<input type="checkbox" value="remember-me"> Remember me
						  </label>
						</div-->
						<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
						<div style="text-align: right;">
						<a class="loginLinks" href="javascript: openHelp();">Login Help</a><br/>
						<a class="loginLinks" href="events.asp?v1=eventsUserRegister.asp&userID=0" style="font-size: 17px;"><strong>Create Log In</strong></a><br/>
						<a class="loginLinks" href="events.asp?v1=eventsRecoverPassword.asp">Forgot Password</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<script language="JavaScript">
function CheckSubmit()
{
	if (document.form_student_login.username.value=="" || document.form_student_login.password.value=="")
	{
		alert('Please fill in all fields!');
		return false;
	}
	else
		return true;
}

function openHelp()
{
	window.open('eventsHelp.asp',"Help",'directories=0,height=450,width=600,scrollbars=yes');
}

</script>
</body>
