<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"

Dim us_objConn
Dim us_rs

Set us_objConn = Server.CreateObject("ADODB.Command")
	With us_objConn
		.ActiveConnection = Application("strConn")
		.CommandText = "a_events_insert_childToParent"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@pID", adVarchar, adParamInput,20,session(SESSION_PUSERID))
		.Parameters.Append .CreateParameter("@pStudentID", adVarchar, adParamInput,20,request ("stID"))
	Set us_rs = .execute
	
	dim connChildrenList
		dim childrenListRS
		dim childrenCount
		childrenCount = 0
		dim childrenList
		
	set connChildrenList = Server.CreateObject("ADODB.connection")
		connChildrenList.Open Application("strConn")
		set childrenListRS = connChildrenList.execute("a_events_get_ParentChildren "&session(SESSION_PUSERID))
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
	
	End With
	
	response.Write ("{""result"":1, ""message"":""Child added.""}")


set us_objConn = nothing
	
%>
