<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by William Tam December, 2002
' Powered by Meiotic Inc.
'************************************************
Response.ContentType = "application/json"

Dim cmd
cmd = request("cmd")

Dim SportRank
Dim SportRank_conn
Dim SportRank_sql

Dim SportRankID
Dim StudentID

set SportRank_conn = Server.CreateObject("ADODB.connection")
SportRank_conn.Open Application("strConn")
	
if cmd = "byStudent" then
	StudentID = request("studentID")
	
	SportRank_sql = "exec a_get_sportrank "&StudentID&""
	Set SportRank = SportRank_conn.Execute(SportRank_sql)
	
	response.write(RStoJSON(SportRank, "SportRank"))

elseif cmd = "byID" then
	SportRankID = request("sportRankID")

	SportRank_sql = "exec a_get_sportrank_detail "&SportRankID&""
	set SportRank = SportRank_conn.execute(SportRank_sql)
		
	response.write(RStoJSON(SportRank, "SportRank"))
		
elseif cmd = "createUpdate" then
	Dim Sport
	Dim Rank
	Dim Degree
	Dim Semester

	SportRankID = request.form("SPORTRANKID")
	StudentID = request.form("STUDENTID")
	Sport = request.form("SPORT")
	Rank = request.form("RANK")
	Degree = request.form("DEGREE")
	Semester = request.form("SEMESTER")
	
	if SportRankID = 0 then
		SportRank_sql = "exec a_check_IfSportRankExists "&StudentID&", '"&Sport&"'"
		set SportRank = SportRank_conn.execute(SportRank_sql)
		
		if SportRank.EOF <> true AND SportRank.BOF <> true then
			response.Write ("{""result"":0, ""message"":""Student Rank for this sport exists, please edit existing rank.""}")
		else
			SportRank_sql = "exec a_add_NEW_sportrank "&StudentID&", "&Semester&", '"&Sport&"', '"&Rank&"', '"&Degree&"', '"&session(SESSION_USERNAME)&"', 0"
			set SportRank = SportRank_conn.execute(SportRank_sql)
			response.Write ("{""result"":1, ""message"":""Sport rank added.""}")
		end if
	else
		SportRank_sql = "exec a_up_sportrank "&SportRankID&", '"&Sport&"', '"&Rank&"', '"&Degree&"', "&Semester&", '"&session(SESSION_USERNAME)&"'"
		set SportRank = SportRank_conn.execute(SportRank_sql)
		response.Write ("{""result"":1, ""message"":""Sport rank updated.""}")
	end if

end if

set SportRank_conn = nothing
%>
