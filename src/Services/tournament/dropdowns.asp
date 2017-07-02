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

dim tournamentconn
dim tournamentstrSQL
dim tournamentRS
dim returnStr

set tournamentconn = Server.CreateObject("ADODB.Connection")
tournamentconn.Open Application("strConn")
	
if cmd = "getStates" then	
	
	tournamentstrSQL = "exec a_event_get_tournamentStates"
	set tournamentRS = tournamentconn.execute(tournamentstrSQL)
	
	returnStr = "{""States"": ["
	
	if tournamentRS.EOF then
		response.write("{""States"":[]}")
	else
		do while tournamentRS.EOF <> true
		
		returnStr = returnStr + """" + tournamentRS("tState") + ""","
		
		tournamentRS.movenext
		loop
		
		returnStr = Mid(returnStr, 1, len(returnStr) - 1) + "]}"
		response.write(returnStr)
	end if
	
elseif cmd = "getSports" then
	tournamentstrSQL = "exec a_event_get_tournamentSports"
	set tournamentRS = tournamentconn.execute(tournamentstrSQL)

	returnStr = "{""Sports"": ["
	
	if tournamentRS.EOF then
		response.write("{""Sports"":[]}")
	else
		do while tournamentRS.EOF <> true
		
		returnStr = returnStr + """" + tournamentRS("tSport") + ""","
		
		tournamentRS.movenext
		loop
		
		returnStr = Mid(returnStr, 1, len(returnStr) - 1) + "]}"
		response.write(returnStr)
	end if
else
	response.Write ("{""result"":0, ""message"":""cmd parameter not valid.""}")
end if



set tournamentconn = nothing
	
%>


