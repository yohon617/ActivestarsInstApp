<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"
dim base
dim userID

userID = request("userID")

if not userID = 0 then
		dim conn
		dim strSQL
		dim ci
		set conn = Server.CreateObject("ADODB.connection")
		conn.Open Application("strConn")
		strSQL = "exec a_events_get_Profile "&userID&""
		set ci = conn.execute(strSQL)
	end if

response.write(RStoJSON(ci, "Students"))

set conn = nothing
	
%>
