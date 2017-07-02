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
dim tID

dim tournamentconn
dim tournamentstrSQL
dim tournamentRS

set tournamentconn = Server.CreateObject("ADODB.Connection")
tournamentconn.Open Application("strConn")

if cmd = "getTournamentsLookUp" then

	dim SPORT,STATE
	SPORT = request("SPORT")
	STATE = request("STATE")
	
	tournamentstrSQL = "exec a_events_get_tournamentsWithRegistered 0,'" & SPORT & "', '" & STATE & "'," & session(SESSION_PUSERID)
	set tournamentRS = tournamentconn.execute(tournamentstrSQL)
	
	if tournamentRS.EOF then
		response.write("{""Tournaments"":[]}")
	else
		response.write(RStoJSON(tournamentRS, "Tournaments"))
	end if
elseif cmd = "getTournamentByID" then

	dim ID
	ID = request("tID")
	
	set tournamentRS = tournamentconn.execute("a_events_get_tournamentInfo "&ID)
	
	if tournamentRS.EOF then
		response.write("{""Tournaments"":[]}")
	else
		response.write(RStoJSON(tournamentRS, "Tournaments"))
	end if
elseif cmd = "getStudentRegistrationByTournament" then
	tID = request("tID")
	
	'a_events_getStudentRegistrationByTournamentID
	
	set tournamentRS = tournamentconn.execute("a_events_getStudentRegistrationByTournamentID "&session(SESSION_PUSERID)&", "&tID)
	
	if tournamentRS.EOF then
		response.write("{""StudentRegistrations"":[]}")
	else
		response.write(RStoJSON(tournamentRS, "StudentRegistrations"))
	end if

elseif cmd = "getTournamentEvents" then
	tID = request("tID")	
	
	set tournamentRS = tournamentconn.execute("a_events_get_TournamentEvents "&tID)
	
	if tournamentRS.EOF then
		response.write("{""TournamentEvents"":[]}")
	else
		response.write(RStoJSON(tournamentRS, "TournamentEvents"))
	end if

elseif cmd = "getTournamentCampSaleItems" then
	tID = request("tID")	
	
	set tournamentRS = tournamentconn.execute("a_events_get_CampSaleItems "&tID)
	
	if tournamentRS.EOF then
		response.write("{""TournamentCampSaleItems"":[]}")
	else
		response.write(RStoJSON(tournamentRS, "TournamentCampSaleItems"))
	end if

elseif cmd = "getTournamentSaleItems" then
	tID = request("tID")	
	
	set tournamentRS = tournamentconn.execute("a_get_eventSaleItems "&tID)
	
	if tournamentRS.EOF then
		response.write("{""TournamentSaleItems"":[]}")
	else
		response.write(RStoJSON(tournamentRS, "TournamentSaleItems"))
	end if
elseif cmd = "getKarateEventsPrice" then
	dim eventCount 
	eventCount = request("eventCount")

	set tournamentRS = tournamentconn.execute("a_events_get_karateEventPriceByCount "&eventCount)
	response.write("{""TotalEventPrice"":" & tournamentRS("kpDiscountPrice")& "}")
elseif cmd = "getKarateEventPricesList" then

	set tournamentRS = tournamentconn.execute("a_events_get_karatePrices")
	response.write(RStoJSON(tournamentRS, "KarateEventPrices"))

elseif cmd = "addEventToCart_New" then

	response.Write ("{""result"":1, ""message"":""Event Added. Instuctor: " & request("instructor") & " ""}")
elseif cmd = "addEventToCart" then
	Dim eventSport
	Dim tournamentID, studentID
	dim pickedEvents
	dim pickedArray
	dim pickedOptions
	dim optionArray
	dim numEvents
	dim special
	dim instructor
	dim age
	dim rank
	dim classLo
	dim teamName
	dim paymentType
	dim saleItemString, saleItem, saleItemArray
	dim saleItemID, saleItemQuantity, saleItemOption
	dim paid
	dim spectators, specFirst, specLast, specAge, specPaid
	dim cartID

	set tournamentRS = tournamentconn.execute("a_prereg_getOpenCartID "&session(SESSION_PUSERID))
	cartID = tournamentRS("cartID")

	tournamentID = request("tID")
	studentID = request("sID")
	paid = request("paid")

	set tournamentRS = tournamentconn.execute("a_events_get_tournamentInfo "&tournamentID)

	'eventSport = request("sport")
	eventSport = tournamentRS("tsport")

	'response.Write ("{""result"":1, ""message"":""Event Added. Instuctor: " & request("instructor") & " ""}")
	'response.end()

	if len(request("special")) > 0 then
		special = request("special")
	end if
	instructor = request("instructor")
	'if instructor = "unknown" then
		'instructor = request("instructorBox") 
	'end if
	instructor = Replace(instructor, "'", "''")

	'age = request("age")
	'if len(request.Form("belt")) > 0 then
		'rank = request.Form("belt")
	'end if
	if len(request.Form("classLocation")) > 0 then
		classLo = request.Form("classLocation")
	end if
	'if len(request.Form("teamName")) > 0 then
		'teamName = request.Form("teamName")
	'end if

	'paymentType = request.Form("PaymentType")
	dim connRegister
			
	set connRegister = Server.CreateObject("ADODB.connection")
	connRegister.Open Application("strConn")


	if paid = 0 then
		connRegister.execute("a_events_delete_events "& studentID &","&tournamentID)
		connRegister.execute("a_event_delete_TournamentStudentSaleItems "& studentID &","&tournamentID)
	end if

	if eventSport = "Karate" then
		
		pickedEvents = request("karateEvents")
		pickedArray = Split(pickedEvents, "=")


		dim i
		i=0
		do while i <= uBound(pickedArray)
		'response.write(pickedArray(i))
		
		connRegister.execute("a_events_register_tournament "& studentID &","&tournamentID&","&pickedArray(i)&",'"&special&"', 0,'','',0,'','"&classLo&"','"&teamName&"', "&cartID)

		i=i+1
		loop
		numEvents = i
	elseif eventSport = "camp" then

		pickedEvents = request("campSaleItems")
		pickedArray = Split(pickedEvents, "=")
		'pickedOptions = request("PickedOptions")
		'optionArray = Split(pickedOptions, ",")
		dim j
		j=0
		do while j <= uBound(pickedArray)
		'response.write(pickedArray(i))
		'response.write(pickedArray(j)&"-"&optionArray(j))
		connRegister.execute("a_events_register_tournament "& studentID &","&tournamentID&",0,'"&special&"',"&Split(pickedArray(j),"-")(0)&",'"&Split(pickedArray(j),"-")(1)&"','"&instructor&"',"&age&",'"&rank&"','"&classLo&"','"&teamName&"',"&cartID)

		j=j+1
		loop
	else
		connRegister.execute("a_events_register_tournament "& studentID &","&tournamentID&",1,'"&special&"', 0,'','',0,'','"&classLo&"','"&teamName&"',"&cartID)
	end if

	
	if len(request("saleItems")) > 0 then
		saleItemString = request("saleItems")
		pickedArray = Split(saleItemString, "=")
		'response.write(request.Form("SaleItemsString"))
		for each item in pickedArray
			saleItemID = Split(item, "-")(0)
			saleItemQuantity = Split(item, "-")(1)
			saleItemOption = Split(item, "-")(2)
			if len(saleItemOption) = 0 then
				saleItemOption = ""
			end if
			'response.write("a_event_addTournamentStudentSaleItem "& Session(SESSION_USERSTUDENTID) &","&tournamentID&","&saleItemID&","&saleItemQuantity)
			
			connRegister.execute("a_event_addTournamentStudentSaleItem "& studentID &","&tournamentID&","&saleItemID&","&saleItemQuantity&",'"&saleItemOption&"'")
		next

	end if

	connRegister.execute("a_events_delete_spectators "& studentID &","&tournamentID)

	if len(request("spectators")) > 0 then
		spectators = request("spectators")
		pickedArray = Split(spectators, "=")

		for each item in pickedArray
			specFirst = Split(item, "-")(0)
			specLast = Split(item, "-")(1)
			specAge = Split(item, "-")(2)
			specPaid = Split(item, "-")(3)

			connRegister.execute("a_events_addSpectator "&studentID&", "&tournamentID&", '"&specFirst & " " & specLast &"', '"&specFirst&"', '"&specLast&"', "&specAge&","&specPaid)
		next
	end if


	set connRegister = nothing
	
	response.Write ("{""result"":1, ""message"":""Event Added.""}")
elseif cmd = "deleteTournamentRegistration" then
	Dim rStudentID, rTournamentID
	rTournamentID = request("tID")	
	rStudentID = request("sID")
	
	tournamentconn.execute("a_events_delete_events "& rStudentID &","&rTournamentID)
	tournamentconn.execute("a_event_delete_TournamentStudentSaleItems "& rStudentID &","&rTournamentID)
	tournamentconn.execute("a_events_delete_spectators "& rStudentID &","&rTournamentID)
	
	
	response.Write ("{""result"":1, ""message"":""Event registration removed.""}")
else
	response.Write ("{""result"":0, ""message"":""cmd parameter not valid.""}")


		'response.Write ("{""result"":1, ""message"":""" & "pickedEvents" & """}")
		'response.end()
end if
'CheckstrSQL = "EXEC a_events_checkStudentExists '"&firstName&"', '"&lastName&"', '"&hPhone&"'"

'set Check = Checkconn.Execute(CheckstrSQL)



'response.Write ("{""result"":0, ""message"":""Student with same name and home phone already in database.""}")

set tournamentconn = nothing
	
%>


