<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"

Dim cmd
Dim st_objConn
Dim st_rs

cmd = Request("cmd")

if cmd = "byFamily" then
	Set st_objConn = Server.CreateObject("ADODB.Command")
		With st_objConn
			.ActiveConnection = Application("strConn")
			.CommandText = "a_events_get_family"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@pParentID", adInteger, adParamInput,,SESSION(SESSION_PUSERID))
		Set st_rs = .execute
		End With

	response.write(RStoJSON(st_rs, "Students"))
elseif cmd = "bySearch" then 
	
	Dim phoneNumber
	dim birthday
	dim email
	dim studentID

	phoneNumber = "99"
	birthday = "1/1/1990"
	email = "99"
	studentID = 0

	if len(Request("slAreaCode")) > 0 and len(Request("slFirstCode")) > 0 and len(Request("slSecondCode")) > 0 then
		phoneNumber = "(" & Request("slAreaCode") & ")" & Request("slFirstCode") & "-" & Request("slSecondCode")
	end if
	if len(Request("slEmail")) > 0 then
		email = Request("slEmail")
	end if
	if len(Request("slBMonth")) > 0 and len(Request("slBDay")) > 0 and len(Request("slBYear")) > 0 then
		birthday = Request("slBMonth") & "/" & Request("slBDay") & "/" & Request("slBYear")
	end if
	if len(Request("slID")) > 0 then
		studentID = Request("slID")
	end if

	Set st_objConn = Server.CreateObject("ADODB.Command")
	With st_objConn
		.ActiveConnection = Application("strConn")
		.CommandText = "a_events_get_student"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@pID", adInteger, adParamInput,4,studentID)
		.Parameters.Append .CreateParameter("@pFirstName", adVarchar, adParamInput,30,Request ("slFirstName"))
		.Parameters.Append .CreateParameter("@pLastName", adVarchar, adParamInput,30,Request ("slLastName"))
		.Parameters.Append .CreateParameter("@pPhoneNum", adVarchar, adParamInput,20,phoneNumber)
		.Parameters.Append .CreateParameter("@pEmail", adVarchar, adParamInput,20,email)
		.Parameters.Append .CreateParameter("@pBirthday", adVarchar, adParamInput,20,birthday)
	Set st_rs = .execute

	End With


	if st_rs.EOF then
		response.write("{""Students"":[]}")
	else
		response.write(RStoJSON(st_rs, "Students"))
	end if
	
elseif cmd = "byID" then 
	
	Dim stID
	Dim strSQL
	stID = Request("stID")

	set st_objConn = Server.CreateObject("ADODB.connection")
	st_objConn.Open Application("strConn")
	strSQL = "exec a_get_studentInfo "&stID&""
	set st_rs = st_objConn.execute(strSQL)
		
	if st_rs.EOF then
		response.write("{""Students"":[]}")
	else
		response.write(RStoJSON(st_rs, "Students"))
	end if

end if
	
set st_objConn = nothing
%>
