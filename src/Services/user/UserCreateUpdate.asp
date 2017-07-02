<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"

dim userID
userID = request("userID")
dim firstName, lastName
dim address, city, state, zip
dim Email
dim areaCode, firstCode, secondCode
dim cellAreaCode, cellFirstCode, cellSecondCode
dim hPhone
dim cPhone
dim username
dim password
dim donotemail
dim receiveSMS

hPhone = ""

firstName = replace(request.form("FIRST_NAME"), "'", "''")
lastName = replace(request.form("LAST_NAME"), "'", "''")

address = replace(request.form("ADDRESS"), "'", "''")

city = replace(request.form("CITY"), "'", "''")
state = request.form("STATE")
zip = request.form("ZIP")

Email = request.form("EMAIL")

areaCode = request.form("AREA_CODE")
firstCode = request.form("FIRST_CODE")
secondCode = request.form("SECOND_CODE")
if not areaCode = "" and not firstCode = "" and not secondCode = "" then
	hPhone = "("&areaCode&")"&firstCode&"-"&secondCode&""
end if


cellAreaCode = request.form("CELL_AREA_CODE")
cellFirstCode = request.form("CELL_FIRST_CODE")
cellSecondCode = request.form("CELL_SECOND_CODE")
if not cellAreaCode = "" and not cellFirstCode = "" and not cellSecondCode = "" then
	cPhone = "("&cellAreaCode&")"&cellFirstCode&"-"&cellSecondCode&""
end if

username = request.Form("username")
password = request.Form("password")
donotemail = 0
if request.Form("chkDoNotEmail") = "true" then
	donotemail = 1
end if

receiveSMS = 0
if request.Form("RECEIVESMS") = "true" then
	receiveSMS = 1
end if


	
	dim Checkconn
	dim CheckstrSQL
	dim Check
	
	set Checkconn = Server.CreateObject("ADODB.Connection")
	Checkconn.Open Application("strConn")
	
	CheckstrSQL = "EXEC a_events_checkUserExists '"&firstName&"', '"&lastName&"', '"&hPhone&"'"
	'response.write(CheckstrSQL)
	set Check = Checkconn.Execute(CheckstrSQL)


if userID = 0 then
	if Check.eof then
		dim conn
		dim strSQL
		dim an
		dim usernamecount
		
		
		set conn = Server.CreateObject("ADODB.Connection")
		conn.Open Application("strConn")
		
		strSQL = "EXEC a_events_check_username '"&username&"'"
		set an = conn.Execute(strSQL)
		
		usernamecount = an("numofname")
		
		if usernamecount = 0 then
		
			strSQL = "EXEC a_events_insert_eventsLogin '"&request.Form("username")&"', '"&request.Form("password")&"', '"&firstName&"', '"&lastName&"','"&address&"', '"&city&"', '"&state&"', '"&zip&"', '"&Email&"', '"&hPhone&"', '"&cPhone&"',"&receiveSMS
			
			set an = conn.Execute(strSQL)
			
			
			set conn = nothing
			'response.write ("New student added successfully!")
			session(SESSION_NAME) = trim(an("elFirstName")) & " " & trim(an("elLastName"))
			session(SESSION_USERSTUDENTID) = ""
			session(SESSION_PUSERID) = an("elID")
			session(SESSION_USERNAME) = "wtam"'ucase(lg_rs("usUsername"))
			session(SESSION_SPORT) = ""
			session(SESSION_EMAIL) = trim(an("elEmail"))
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
			
			dim instRS
			dim connInst
			
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
			response.Write ("{""result"":1, ""message"":""Registration completed.""}")
			//response.redirect(makelink("eventsLookUp.asp"))
		else
			response.Write ("{""result"":0, ""message"":""Username exists!""}")
			
			set conn = nothing
		end if
	
	else
	
		'response.write ("User with same name and home phone already in database.")
		response.Write ("{""result"":0, ""message"":""User with same name and home phone already in database.""}")
	
	end if
else
	dim conn2
	dim strSQL2
	dim al2
	
	set conn2 = Server.CreateObject("ADODB.connection")
	conn2.Open Application("strConn")
	
	strSQL2 = "exec a_events_update_eventsLogin "&userID&", '"&request.Form("username")&"', '"&request.Form("password")&"', '"&firstName&"', '"&lastName&"','"&address&"', '"&city&"', '"&state&"', '"&zip&"', '"&Email&"', '"&hPhone&"', '"&cPhone&"',"&receiveSMS
	
	'response.Write ("{""result"":1, ""message"":""" + strSQL2 + """}")
	'response.end()
	set al2 = conn2.execute(strSQL2)
	'response.write ("Your profile has been updated successfully!")
	response.Write ("{""result"":1, ""message"":""Your profile has been updated successfully!""}")
	set conn2 = nothing
end if



set Checkconn = nothing
	
%>
