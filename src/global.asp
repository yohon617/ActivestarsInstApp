<% option explicit %>
<!--#INCLUDE FILE="ADOVBS.asp"-->


<%
'on error resume next
const SESSION_LOGGED = "SLOG"
const SESSION_NAME = "SNAM"
const SESSION_USERID = "SUID"
const SESSION_USERNAME = "SUNM"
const SESSION_EMAIL = "SUEM"
const SESSION_INSTRUCTOR = "INST"
const SESSION_INSTONLY = "IOLY"
const SESSION_ACCOUNTING = "ACCT"
const SESSION_ACCOUNTINGMGR = "ACCM"
const SESSION_INVENTORY = "INVT"
const SESSION_INVENTORYMGR = "INVM"
const SESSION_FACILITYOPS = "FAOP"
const SESSION_FACILITYOPSMGR = "FAOM"
const SESSION_FIELDOPS = "FIOP"
const SESSION_FIELDOPSMGR = "FIOM"
const SESSION_MARKETING = "MRKT"
const SESSION_MARKETINGMGR = "MKTM"
const SESSION_MANAGEMENT = "MGMT"
const SESSION_EXECUTIVE = "EXEC"
const SESSION_MAINTANCE = "MAIT"
const SESSION_SUPER = "SUPR"
const SESSION_RECEIVED = "RECD"
const SESSION_NOMESSAGE = "SNOM"
const SESSION_NEXTTRANS = "NXTR"
const SESSION_QUERYSTRING = "SQST"
const SESSION_FORMCONTENT = "SFCT"
const SESSION_LASTACCESSED = "SLAC"
const SESSION_TIMEOUT = "STIO"
const notes = "&lt;Communication&gt;"
const SESSION_NOSECURITY = "NOSE"

const SESSION_CR_BANKDEPDATE = "CRBD"
const SESSION_CR_BANKDEPNUM = "CRBN"
const SESSION_STRINGSQL = "SSQL"
const SESSION_AWARD_ORDER = "AWAD"
const SESSION_ROSTER_ORDER = "ROSO"
session(SESSION_NOSECURITY) = "1"


'-------------------------------------------------------------------------------------
dim objConnFS			' Connection object to the database
dim objRS_FS			' recordset with the view/edit rights
dim PageName			' name of the current page
dim ViewRights			' 'true' if the current user has viewing rights to the page
dim EditRights			' 'true' if the current user has edit rights to the page
dim URLFromKS2, item
URLFromKS2=""

'-------------------------------------------------------------------------------------
' This function loops through the user-groups (see above; passed as a comma separated
' list) and checks if the current user belongs to at least one of them. Depending on
' the result the function returns 'true' or 'false'. In case of 'False' and 'NewPage'
' is '1' the browser will naviagate from the current page before starting to render it.
function CheckSecurity(strGroups, NewPage)
	
	dim GroupArray, Group
	CheckSecurity = false
	
	if len(strGroups) >= 4 then
		GroupArray = split(strGroups, ",")
		for each Group in GroupArray
			if Session(Group) = "1" then
				CheckSecurity = true
				exit for
			end if
		next
	end if
	
	' This part is only executed, if a new page has been called.
	if NewPage = 1 then
		if CheckSecurity = false then
			dim csErrMsg, csAction
			if Session("SLOG") = 1 then
				csErrMsg = "Sorry, but you do not have the necessary rights to view this page!    \nFile name: "&ucase(PageName)
				if len(request.querystring("v1")) > 0 then
					csAction = "history.back();"
				else
					csAction = "window.close();"
				end if
			else
				if len(request.querystring("v1")) = 0 then
					csErrMsg = "Your session has timed out; please log in again!    "
					csAction = "window.close();" & vbCRLF & "var LoginPage = window.open(""login.asp?pop=1"", ""LoginPage"", 'directories=0,height=170,width=363');"
				else
					if instr(Request.ServerVariables("URL"), "ks.asp") <> 0 then
						if (Request.Cookies("YCOACOOKIE")("username")<>"") then
							For Each item In Request.QueryString
							    URLFromKS2=URLFromKS2&(item&"="&Request.QueryString(item)&"&")
							Next
							URLFromKS2=replace(URLFromKS2,"v1=","")
							URLFromKS2=replace(URLFromKS2,"&","_")
							URLFromKS2=left(URLFromKS2, len(URLFromKS2)-1)
							
							Dim GetPassword
							Dim GetPassword_SQL
							Dim GetPassword_Conn
									
							Set GetPassword_Conn = Server.CreateObject("ADODB.connection")
							GetPassword_Conn.Open Application("strConn")
							GetPassword_SQL = "exec a_get_password '"&Request.Cookies("YCOACOOKIE")("username")&"'"
							set GetPassword = GetPassword_Conn.execute(GetPassword_SQL)
							csAction = "window.location.replace('index.asp?v1=login.asp&login_username="&Request.Cookies("YCOACOOKIE")("username")&"&login_password="&GetPassword("usPassword")&"&URLFromKS="&URLFromKS2&"');"
							response.write("<scr" & "ipt language=""javascript"">" & vbCRLF & csAction & vbCRLF & "</script>")
						else
							csErrMsg = "Please log in before accessing the application!"
							
							For Each item In Request.QueryString
							    URLFromKS2=URLFromKS2&(item&"="&Request.QueryString(item)&"&")
							Next
							URLFromKS2=replace(URLFromKS2,"v1=","")
							URLFromKS2=replace(URLFromKS2,"&","_")
							URLFromKS2=left(URLFromKS2, len(URLFromKS2)-1)
							csAction = "window.location.replace('index.asp?v1=login.asp&URLFromKS="&URLFromKS2&"');"
							response.flush
						end if
					else
						if (Request.Cookies("YCOACOOKIE")("username")<>"") then
							Dim GetPassword2
							Dim GetPassword2_SQL
							Dim GetPassword2_Conn
									
							Set GetPassword2_Conn = Server.CreateObject("ADODB.connection")
							GetPassword2_Conn.Open Application("strConn")
							GetPassword2_SQL = "exec a_get_password '"&Request.Cookies("YCOACOOKIE")("username")&"'"
							set GetPassword2 = GetPassword2_Conn.execute(GetPassword2_SQL)
							csAction = "window.location.replace('index.asp?v1=login.asp&login_username="&Request.Cookies("YCOACOOKIE")("username")&"&login_password="&GetPassword2("usPassword")&"');"
							response.write("<scr" & "ipt language=""javascript"">" & vbCRLF & csAction & vbCRLF & "</script>")
						else
							csErrMsg = "Please log in before accessing the application!"
							csAction = "window.location.replace('index.asp?v1=login.asp');"
						end if
					end if
				end if
			end if
			response.write("<scr" & "ipt language=""javascript"">" & vbCRLF & "alert('" & csErrMsg &"');" & vbCRLF & csAction & vbCRLF & "</script>")
			response.flush
			response.end
		end if
		
		' Check if the session has expired unless the page requires no security.
		if not strGroups = "NOSE" then CheckSessionTime()
	end if
end function


'-------------------------------------------------------------------------------------
' CheckSessionTime checks when the application was accessed last by the current user
' and redirects to the log-in page if the difference is greater than 'SESSION_TIMEOUT'.
function CheckSessionTime
	if datediff("N", session(SESSION_LASTACCESSED), now) < cInt(session(SESSION_TIMEOUT)) then
		' Reset the last-accessed-time if the session has not yet expired (normal case).
		session(SESSION_LASTACCESSED) = now
	else
		' If the session has expired, save all data and require the user to log in again.
		' ResetSession() - not currently implemented
		session(SESSION_QUERYSTRING) = ""
		session(SESSION_FORMCONTENT) = ""
		dim item, csErrMsg, csAction
		csErrMsg = "Your session has timed out; please log in again!    "
		csAction = "window.location.replace('index.asp?v1=login.asp');"
		
		' If the current window is a pop-up, close it and open a new window with login-form.
		if len(request.querystring("v1")) = 0 then
			csAction = "window.close();" & vbCRLF & "var LoginPage = window.open(""login.asp?pop=1"", ""LoginPage"", 'directories=0,height=170,width=363');"
		else
			' Capture all information of the querystring in a session variable.
			for each item in request.querystring
				session(SESSION_QUERYSTRING) = session(SESSION_QUERYSTRING) & "&" & item & "=" & request(item)
			next
			session(SESSION_QUERYSTRING) = mid(session(SESSION_QUERYSTRING),2)
				
			' Capture all information of the form in another session variable.
			for each item in request.form
				session(SESSION_FORMCONTENT) = session(SESSION_FORMCONTENT) & "||" & item & "||" & request(item)
			next
			session(SESSION_FORMCONTENT) = mid(session(SESSION_FORMCONTENT),4)
		end if
		
		' Show the 'Session expired' message and redirect to the login-page.
		response.write("<scr" & "ipt language=""javascript"">" & vbCRLF & "alert('" & csErrMsg &"');" & vbCRLF & csAction & vbCRLF & "</script>")
		response.flush
		response.end
	end if
end function


'-------------------------------------------------------------------------------------
function makeLink(whereTo)
	makeLink = "index.asp?v1=" & whereTo
end function

function sendMail(SendTo,SendFrom,SendCC,SendSubject,SendMsg)
	Dim oMail
	
	if SendFrom = "" then
		if left(Application("dbnConn"),2) = "yo" then
			SendFrom = "outgoing@ycoaoffice.com"
		else
			SendFrom = "outgoing@ycoaoffice.com"
		end if
	end if
	
	if SendTo = "" then
		if left(Application("dbnConn"),2) = "yo" then
			SendTo = "outgoing@ycoaoffice.com"
		else
			SendTo = "outgoing@ycoaoffice.com"
		end if
	end if

	Set oMail = CreateObject("CDO.Message") 	
	oMail.Sender = SendFrom
	oMail.To =  SendTo
	oMail.CC = SendCC
	oMail.Subject = SendSubject
	oMail.HTMLBody = SendMsg
	oMail.Send 
end function

'-------------------------------------------------------------------------------------
' Get the name of the current page (that uses global.asp as an include-file)
if len(request.querystring("v1")) > 0 then
	if Mid(Request.ServerVariables("PATH_INFO"),2) = "events.asp" then
		PageName = "events.asp"
	else
		PageName = request.querystring("v1")
	end if
else
	PageName = Mid(Request.ServerVariables("PATH_INFO"),2)
end if

'-------------------------------------------------------------------------------------
' Security for the current page - check that the user requesting it is in at least one
' of the groups that have access rights and find out if they have edit rights as well.
if not PageName = "index.asp" and not PageName = "login.asp" and not PageName = "events.asp" and not PageName = "asperror.asp"  and not PageName = "eventsLookUpStudent.asp" and not PageName = "eventsCreatePassword.asp"  then
	' Retrieve which groups have view and/or edit rights to the current page
	set objConnFS = Server.CreateObject("ADODB.Command")
	objConnFS.ActiveConnection = Application("strConn")
	objConnFS.CommandText = "a_get_FileSecurity" 
	objConnFS.CommandType = adCmdStoredProc
	objConnFS.Parameters.Append objConnFS.CreateParameter("@pPageName", adVarChar, adParamInput, 50, PageName)
	set objRS_FS = objConnFS.execute
	set objConnFS = nothing
	
	if not objRS_FS.EOF then
		ViewRights = CheckSecurity(objRS_FS("fsViewGroups"),1)
		EditRights = CheckSecurity(objRS_FS("fsEditGroups"),0)
		objRS_FS.Close
		set objRS_FS = nothing
	else
		dim fsErrMsg, fsAction
		' The current page could not be found in 'tbFileSecurity' - display a message and exit.
		if len(request.querystring("v1")) = 0 then fsAction = "window.close();" else fsAction = "history.back();"
		fsErrMsg = "Page """&PageName&""" has not yet been added to the file security table.    \nPlease contact the system administrator!"
		response.write("<scr" & "ipt language=""javascript"">" & vbCRLF & "alert('" & fsErrMsg &"');" & vbCRLF & fsAction & vbCRLF & "</script>")
		response.flush
		response.end
	end if
end if
'-------------------------------------------------------------------------------------
'-------------------------------------------------------------------------------------
function RGBTranslator(intNum)
	Dim RGBArray(2)
	Select Case intNum
		Case 0 : 'Blue
			RGBArray(0) = 0
			RGBArray(1) = 0
			RGBArray(2) = 255
		Case 1 : 'Red
			RGBArray(0) = 255
			RGBArray(1) = 0
			RGBArray(2) = 0
		Case 2 : 'Orange
			RGBArray(0) = 255
			RGBArray(1) = 165
			RGBArray(2) = 0
		Case 3 : 'limegreen
			RGBArray(0) = 50
			RGBArray(1) = 205
			RGBArray(2) = 50
		Case 4 : 'cornflowerblue
			RGBArray(0) = 100
			RGBArray(1) = 149
			RGBArray(2) = 237
		Case 5 : 'fuchsia
			RGBArray(0) = 255
			RGBArray(1) = 0
			RGBArray(2) = 255
		Case 6 : 'gold
			RGBArray(0) = 255
			RGBArray(1) = 215
			RGBArray(2) = 0
		Case 7 : 'blueviolet
			RGBArray(0) = 138
			RGBArray(1) = 43
			RGBArray(2) = 226
		Case 8 : 'mediumaquamarine
			RGBArray(0) = 102
			RGBArray(1) = 205
			RGBArray(2) = 170
		Case 9 : 'deeppink
			RGBArray(0) = 255
			RGBArray(1) = 20
			RGBArray(2) = 147
		Case 10 : 'goldenrod
			RGBArray(0) = 218
			RGBArray(1) = 165
			RGBArray(2) = 32
		Case 11 : 'darkslateblue
			RGBArray(0) = 72
			RGBArray(1) = 61
			RGBArray(2) = 139
		Case Else
			RGBArray(0) = (intNum * 65) MOD 225
			RGBArray(1) = (intNum * 85) MOD 225
			RGBArray(2) = (intNum * 105) MOD 225
	End Select
	RGBTranslator = RGBArray
end function
%>
<%If request.querystring("v1") <> "main.asp" And request.querystring("v1") <> "main_CA.asp" Then%>
<!--#include file="contextmenu.asp"-->
<%End If%>
