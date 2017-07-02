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

dim cartconn
dim cartstrSQL
dim cartRS

set cartconn = Server.CreateObject("ADODB.Connection")
cartconn.Open Application("strConn")


dim srCartID

set cartRS = cartconn.execute("a_prereg_getOpenCartID "&session(SESSION_PUSERID))
srCartID = cartRS("cartID")

if cmd = "getCartStudentRegistration" then
	
	set cartRS = cartconn.execute("a_reg_getStudentRegistrationByCartID "&srCartID)
	
	if cartRS.EOF then
		response.write("{""CartClassRegistrations"":[]}")
	else
		response.write(RStoJSON(cartRS, "CartClassRegistrations"))
	end if
elseif cmd = "getCartStudentEventRegistration" then
	
	
	set cartRS = cartconn.execute("a_reg_getStudentEventRegistrationByCartID "&srCartID)
	
	if cartRS.EOF then
		response.write("{""CartEventRegistrations"":[]}")
	else
		response.write(RStoJSON(cartRS, "CartEventRegistrations"))
	end if
elseif cmd = "getCartEventSpectators" then
	
	
	set cartRS = cartconn.execute("a_reg_getCartEventSpectators "&srCartID)
	
	if cartRS.EOF then
		response.write("{""CartEventSpectators"":[]}")
	else
		response.write(RStoJSON(cartRS, "CartEventSpectators"))
	end if
else
	response.Write ("{""result"":0, ""message"":""cmd parameter not valid.""}")


		'response.Write ("{""result"":1, ""message"":""" & "pickedEvents" & """}")
		'response.end()
end if
'CheckstrSQL = "EXEC a_events_checkStudentExists '"&firstName&"', '"&lastName&"', '"&hPhone&"'"

'set Check = Checkconn.Execute(CheckstrSQL)



'response.Write ("{""result"":0, ""message"":""Student with same name and home phone already in database.""}")

set cartconn = nothing
	
%>


