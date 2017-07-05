<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"

dim cmd
cmd = request("cmd")
dim classID

dim classconn
dim classstrSQL
dim classRS

set classconn = Server.CreateObject("ADODB.Connection")
classconn.Open Application("strConn")

if cmd = "getClass" then

	classID = request("id")
	
	classstrSQL = "exec a_reg_get_ClassesInfo " & classID
	set classRS = classconn.execute(classstrSQL)
	
	if classRS.EOF then
		response.write("{""Classes"":[]}")
	else
		response.write(RStoJSON(classRS, "Classes"))
	end if
elseif cmd = "getClasses" then
    
	response.write("{""Classes"":[{""id"": 1, ""name"": ""arcadia""},{""id"": 2, ""name"": ""pasadena""}]}")
elseif cmd = "addClassToCart" then
	
	dim acStudentID, acType, acStatus, acWeekly, acWeekNum, acCartID, acTeam, acPaid
	classID = request("cID")
	acStudentID = request("sID")
	acType = request("type")
	acStatus = request("status")
	acWeekly = request("weekly")
	acWeekNum = request("weekNum")
	acTeam = request("team")
	acPaid = request("paid")

	if acPaid = "0" then

	classconn.execute("a_reg_delStudentClassRegistration "&acStudentID&", "&classID)

	set classRS = classconn.execute("a_prereg_getOpenCartID "&session(SESSION_PUSERID))
	acCartID = classRS("cartID")

	classstrSQL = "exec a_reg_add_classRegistration " & classID & "," & acStudentID & ",'" & acType & "'," & acStatus & "," & acWeekly & "," & acWeekNum & ",'" & acTeam & "'," & acCartID & ""
 	classconn.execute(classstrSQL)

 	end if

	response.Write ("{""result"":1, ""message"":""Class added.""}")

elseif cmd = "getStudentRegistrationByClass" then
	classID = request("id")
	
	set classRS = classconn.execute("a_reg_getStudentRegistrationByClass "&session(SESSION_PUSERID)&", "&classID)
	
	if classRS.EOF then
		response.write("{""StudentClassRegistrations"":[]}")
	else
		response.write(RStoJSON(classRS, "StudentClassRegistrations"))
	end if

elseif cmd = "deleteStudentClassRegistration" then
	classID = request("cID")
	dim dsStudentID
	dsStudentID = request("sID")
	
	classconn.execute("a_reg_delStudentClassRegistration "&dsStudentID&", "&classID)

	response.Write ("{""result"":1, ""message"":""Class registration deleted.""}")
else
	response.Write ("{""result"":0, ""message"":""cmd parameter not valid.""}")


		'response.Write ("{""result"":1, ""message"":""" & "pickedEvents" & """}")
		'response.end()
end if
'CheckstrSQL = "EXEC a_events_checkStudentExists '"&firstName&"', '"&lastName&"', '"&hPhone&"'"

'set Check = Checkconn.Execute(CheckstrSQL)



'response.Write ("{""result"":0, ""message"":""Student with same name and home phone already in database.""}")

set classconn = nothing
	
%>


