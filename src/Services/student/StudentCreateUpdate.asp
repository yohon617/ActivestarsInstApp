<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"

if session(SESSION_LOGGED) = 0 then
	response.Write ("{""result"":0, ""message"":""Your session has expired, please login again to continue.""}")
	response.end()
end if

dim stID
stID = request("stID")
dim firstName, lastName
dim age
dim address, city, state, zip
dim address2, city2, state2, zip2
dim pFirstName, pLastName
dim studentEmail
dim parentEmail
dim school, schoolID
dim sport, rank, degree
dim areaCode, firstCode, secondCode, ext
dim bAreaCode, bFirstCode, bSecondCode, bExt
dim cAreaCode, cFirstCode, cSecondCode, cExt
dim hPhone, bPhone, cPhone
dim comments
dim size
dim classnum

dim semester

dim DoNotSolicit
dim DoNotEmail


dim bmonth
dim bday
dim byear

dim disability, limitations

dim parentReceiveSMS

dim refresh
refresh = 0

hPhone = ""
bPhone = ""

firstName = replace(request.form("FIRST_NAME"), "'", "''")
lastName = replace(request.form("LAST_NAME"), "'", "''")

age = request.form("AGE")

bmonth = cint(request.form("bmonth"))
bday = cint(request.form("bday"))
byear = cint(request.form("byear"))

address = replace(request.form("ADDRESS"), "'", "''")

city = replace(request.form("CITY"), "'", "''")
state = request.form("STATE")
zip = request.form("ZIP")

address2 = replace(request.form("ALTADDRESS"), "'", "''")

city2 = replace(request.form("ALTCITY"), "'", "''")
state2 = request.form("ALTSTATE")
zip2 = request.form("ALTZIP")

pFirstName = replace(request.form("P_FIRST_NAME"), "'", "''")
pLastName = replace(request.form("P_LAST_NAME"), "'", "''")

'studentEmail = request.form("STUDENT_EMAIL")
parentEmail = request.form("P_EMAIL")
school = replace(request.form("SCHOOL"), "'", "''")


schoolID = request.form("SCHOOLID")
'sport = request.form ("SPORT")
'rank = request.form ("RANK")
'degree = request.form ("DEGREE")

areaCode = request.form("AREA_CODE")
firstCode = request.form("FIRST_CODE")
secondCode = request.form("SECOND_CODE")
ext = request.form("EXT")

'bAreaCode = request.form("BAREA_CODE")
'bFirstCode = request.form("BFIRST_CODE")
'bSecondCode = request.form("BSECOND_CODE")
'bExt = request.form("BEXT")

cAreaCode = request.form("CAREA_CODE")
cFirstCode = request.form("CFIRST_CODE")
cSecondCode = request.form("CSECOND_CODE")
cExt = request.form("CEXT")

comments = replace(request.form("COMMENTS"), "'", "''")
size = request.form("SIZE")
classnum = request.form("CLASSNUM")
'semester = request.form("SEMESTER")

'DoNotSolicit = request.form("DONOTSOLICIT")
'DoNotEmail = request.form("DONOTEMAIL")

disability = request.form("DISABILITY")
limitations = request.form("LIMITATIONS")

parentReceiveSMS = request.form("PARENTRECEIVESMS")

'if DoNotSolicit = "on" or DoNotSolicit = "1" then
	'DoNotSolicit = 1
'else
	'DoNotSolicit = 0
'end if

'if DoNotEmail = "on" or DoNotEmail = "1" then
	'DoNotEmail = 1
'else
	'DoNotEmail = 0
'end if

if parentReceiveSMS = "on" or parentReceiveSMS = "1" or parentReceiveSMS = "true" then
	parentReceiveSMS = 1
else
	parentReceiveSMS = 0
end if

if not areaCode = "" and not firstCode = "" and not secondCode = "" then
	if ext <> "" then
		hPhone = "("&areaCode&")"&firstCode&"-"&secondCode&"x"&ext&""
	else
		hPhone = "("&areaCode&")"&firstCode&"-"&secondCode&""
	end if
end if

'if not bAreaCode = "" and not bFirstCode = "" and not bSecondCode = "" then
	'if bExt <> "" then
		'bPhone = "("&bAreaCode&")"&bFirstCode&"-"&bSecondCode&"x"&bExt&""
	'else
		'bPhone = "("&bAreaCode&")"&bFirstCode&"-"&bSecondCode&""
	'end if
'end if

if not cAreaCode = "" and not cFirstCode = "" and not cSecondCode = "" then
	if cExt <> "" then
		cPhone = "("&cAreaCode&")"&cFirstCode&"-"&cSecondCode&"x"&cExt&""
	else
		cPhone = "("&cAreaCode&")"&cFirstCode&"-"&cSecondCode&""
	end if
end if

	dim Checkconn
	dim CheckstrSQL
	dim Check
	
	set Checkconn = Server.CreateObject("ADODB.Connection")
	Checkconn.Open Application("strConn")
	
	CheckstrSQL = "EXEC a_events_checkStudentExists '"&firstName&"', '"&lastName&"', '"&hPhone&"'"
	
	set Check = Checkconn.Execute(CheckstrSQL)


if Check.eof or stid <> 0 then
if stID = 0 then
	dim conn
	dim strSQL
	dim an	
	
	set conn = Server.CreateObject("ADODB.Connection")
	conn.Open Application("strConn")
	
	
	
	strSQL = "EXEC a_events_insert_NEWstudent '"&firstName&"', '"&lastName&"', "&age&", "&bmonth&", "&bday&", "&byear&", '"&address&"', '"&city&"', '"&state&"', '"&zip&"', '"&address2&"', '"&city2&"', '"&state2&"', '"&zip2&"', '"&pFirstName&"', '"&pLastName&"', '"&parentEmail&"', "&schoolID&", '"&hPhone&"', '"&cPhone&"', '"&comments&"', '"&size&"', "&classnum&", '"&SESSION(SESSION_USERNAME)&"', '"&session(SESSION_PUSERID)&"','"&disability&"','"&limitations&"',"&parentReceiveSMS


	
	set an = conn.Execute(strSQL)
	
	response.Write("{""result"":1, ""message"":""New Student added successfully.""}")
	set conn = nothing
	
	
	dim connChildrenList
		dim childrenListRS
		dim childrenCount
		childrenCount = 0
		dim childrenList
		
	set connChildrenList = Server.CreateObject("ADODB.connection")
		connChildrenList.Open Application("strConn")
		set childrenListRS = connChildrenList.execute("a_events_get_ParentChildren "&session(SESSION_PUSERID))
			
		session(SESSION_USERSTUDENTID) = childrenListRS("lcStudentID")

		if not childrenListRS.eof then
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
		refresh = 1

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
else
	dim conn2
	dim strSQL2
	dim al2
	
	set conn2 = Server.CreateObject("ADODB.connection")
	conn2.Open Application("strConn")
	
	strSQL2 = "exec a_event_up_studentInfo "&stID&", '"&firstName&"', '"&lastName&"', "&age&", "&bmonth&", "&bday&", "&byear&", '"&address&"', '"&city&"', '"&state&"', '"&zip&"', '"&address2&"', '"&city2&"', '"&state2&"', '"&zip2&"', '"&pFirstName&"', '"&pLastName&"', '"&parentEmail&"', "&schoolID&", '"&hPhone&"', '"&cPhone&"', '"&comments&"', '"&size&"', "&classnum&", '"&SESSION(SESSION_USERNAME)&"','"&disability&"','"&limitations&"',"&parentReceiveSMS
	set al2 = conn2.execute(strSQL2)
	response.Write ("{""result"":1, ""message"":""Student updated.""}")
	set conn2 = nothing
end if
else

	response.Write ("{""result"":0, ""message"":""Student with same name and home phone already in database.""}")

end if



set Checkconn = nothing
	
%>


