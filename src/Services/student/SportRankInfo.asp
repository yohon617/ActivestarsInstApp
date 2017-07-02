<!--#include virtual="/eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by William Tam December, 2002
' Powered by Meiotic Inc.
'************************************************
'Response.ContentType = "application/json"

Dim cmd
cmd = request("cmd")

Dim SportRank
Dim SportRank_conn
Dim SportRank_sql

Dim SportRankID
Dim StudentID

set SportRank_conn = Server.CreateObject("ADODB.connection")
SportRank_conn.Open Application("strConn")
	
if cmd = "getSports" then

	set SportRank_conn = Server.CreateObject("ADODB.connection")
	SportRank_conn.Open Application("strConn")
	SportRank_sql = "exec a_lk_sport"
	set SportRank = SportRank_conn.execute(SportRank_sql)
	
	response.write(RStoJSON(SportRank, "Sports"))

elseif cmd = "getRankDegrees" then
	Dim sport
	sport = request("sport")
	dim rankJson, degreeJson
	rankJson = "{""Rank"": [ ] }"
	degreeJson = "{ ""Degree"": [ ]} "
	
	if sport = "Karate" then
		dim krArray, kdArray
		'Rank Array
		SportRank_sql = "exec a_lk_kr"
		set krArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		SportRank_sql = "exec a_lk_kd"
		set kdArray = SportRank_conn.execute(SportRank_sql)
		
		rankJson = RStoJSON(krArray, "Rank")
		degreeJson = RStoJSON(kdArray, "Degree") 
	elseif sport = "Hip Hop" then
		dim hrArray
		'Rank Array
		SportRank_sql = "exec a_lk_hhr"
		set hrArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		'no hip hop degree
		
		rankJson = RStoJSON(hrArray, "Rank")
	elseif sport = "Safe" then
		dim srArray
		'Rank Array
		SportRank_sql = "exec a_lk_sfr"
		set srArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		'no hip hop degree
		
		rankJson = RStoJSON(srArray, "Rank")
	elseif sport = "Soccer" then
		dim scrArray
		'Rank Array
		SportRank_sql = "exec a_lk_sr"
		set scrArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		'no hip hop degree
		
		rankJson = RStoJSON(scrArray, "Rank")
	elseif sport = "Cheer" then
		dim chrArray, chdArray
		'Rank Array
		SportRank_sql = "exec a_lk_pr"
		set chrArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		SportRank_sql = "exec a_lk_pd"
		set chdArray = SportRank_conn.execute(SportRank_sql)
		
		rankJson = RStoJSON(chrArray, "Rank")
		degreeJson = RStoJSON(chdArray, "Degree") 
	elseif sport = "Football" then
		dim fbrArray
		'Rank Array
		SportRank_sql = "exec a_lk_fr"
		set fbrArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		'no hip hop degree
		
		rankJson = RStoJSON(fbrArray, "Rank")
	elseif sport = "Basketball" then
		dim bbrArray
		'Rank Array
		SportRank_sql = "exec a_lk_br"
		set bbrArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		'no hip hop degree
		
		rankJson = RStoJSON(bbrArray, "Rank")
	elseif sport = "Dance" then
		dim dnrArray
		'Rank Array
		SportRank_sql = "exec a_lk_dr"
		set dnrArray = SportRank_conn.execute(SportRank_sql)

		'Degree Array
		'no hip hop degree
		
		rankJson = RStoJSON(dnrArray, "Rank")
	end if
	
	
	response.write(Mid(rankJson, 1, len(rankJson) - 2) & ", " & Mid(degreeJson, 2, len(degreeJson) - 2))
	

end if

set SportRank_conn = nothing
%>
