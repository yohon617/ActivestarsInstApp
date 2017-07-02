<% 'option explicit %>
<!--#INCLUDE FILE="ADOVBS.asp"-->


<%
'on error resume next
const SESSION_LOGGED = "SLOG"
const SESSION_NAME = "SNAM"
const SESSION_AGE = "SAGE"
const SESSION_USERSTUDENTID = "SUID"
const SESSION_USERSTUDENTNAME = "STNA"
const SESSION_PUSERID = "USID"
const SESSION_SPORT = "SPRT"
const SESSION_USERNAME = "SUNM"
const SESSION_INSTNAME = "INST"
const SESSION_CLSLOC = "LOCC"
const SESSION_EMAIL = "SUEM"
const SESSION_STUDENT = "STUD"
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

const SESSION_CHILDREN = "CHLD"
const SESSION_CHILDRENCOUNT = "CHCT"
const SESSION_SPECAGE = "SPAG"

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
		csAction = "window.location.replace('events.asp?v1=eventslogin.asp');"
		
		' If the current window is a pop-up, close it and open a new window with login-form.
		if len(request.querystring("v1")) = 0 then
			csAction = "window.close();" & vbCRLF & "var LoginPage = window.open(""eventslogin.asp"", ""LoginPage"", 'directories=0,height=170,width=363');"
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
	makeLink = "events.asp?v1=" & whereTo
end function

function sendMail(SendTo,SendFrom,SendCC,SendSubject,SendMsg)
	Dim oMail
	
	if SendFrom = "" then
		if left(Application("dbnConn"),2) = "yo" then
			SendFrom = "outgoing@ycoaoffice.net"
		else
			SendFrom = "outgoing@ycoaoffice.com"
		end if
	end if
	
	if SendTo = "" then
		if left(Application("dbnConn"),2) = "yo" then
			SendTo = "outgoing@ycoaoffice.net"
		else
			SendTo = "outgoing@ycoaoffice.com"
		end if
	end if

	Set oMail = CreateObject("CDO.Message") 	
	'oMail.Sender = SendFrom
	oMail.From = SendFrom
	oMail.To =  SendTo
	oMail.CC = SendCC
	oMail.Subject = SendSubject
	oMail.HTMLBody = SendMsg
	oMail.Send 
end function


function sendMail2(SendTo,SendFrom,SendCC,SendSubject,SendMsg)
	Dim oMail, objMailConf

	Set oMail = CreateObject("CDO.Message") 	
	Set objMailConf = Server.CreateObject("CDO.Configuration")

	objMailConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 1
	objMailConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpserverpickupdirectory") = "c:\inetpub\mailroot\pickup"
	objMailConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "http://localhost"
	'objMailConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "ycoaoffice.com"
	objMailConf.fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
	objMailConf.Fields.item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
	objMailConf.Fields.Update
	Set oMail.Configuration = objMailConf
	
	if SendFrom = "" then
		if left(Application("dbnConn"),2) = "yo" then
			SendFrom = "outgoing@ycoaoffice.net"
		else
			SendFrom = "outgoing@ycoaoffice.com"
		end if
	end if
	
	if SendTo = "" then
		if left(Application("dbnConn"),2) = "yo" then
			SendTo = "outgoing@ycoaoffice.net"
		else
			SendTo = "outgoing@ycoaoffice.com"
		end if
	end if

	oMail.Sender = SendFrom 
	oMail.From = SendFrom 
	oMail.To =  SendTo
	oMail.CC = SendCC
	oMail.Subject = SendSubject
	oMail.HTMLBody = SendMsg
	oMail.Send 
end function

'-------------------------------------------------------------------------------------
' Get the name of the current page (that uses global.asp as an include-file)
if len(request.querystring("v1")) > 0 then
	PageName = request.querystring("v1")
else
	'PageName = Mid(Request.ServerVariables("PATH_INFO"),2)
	'modified by Mamoru 3/21/2007
	dim Path
	Path = Request.ServerVariables("PATH_INFO")
	dim arry_path
	arry_path = split(Path,"/")
	PageName = arry_path(1)
end if

'-------------------------------------------------------------------------------------
' Security for the current page - check that the user requesting it is in at least one
' of the groups that have access rights and find out if they have edit rights as well.
'response.write(PageName)
if not PageName = "events.asp" and not PageName = "Services" and not PageName = "eventsPaid.asp" and not PageName = "eventslogin.asp"  and not PageName = "eventspopsch.asp" and not PageName = "eventsLookUpStudent.asp" and not PageName = "eventsCreatePassword.asp" and not PageName = "eventsRecoverPassword.asp" and not PageName = "eventsUserRegister.asp" and not PageName = "eventsUserRegisterS.asp" and not PageName = "regclasspaid.asp" and not PageName = "regAuthorizePaid.asp" and not PageName = "orderAuthorizePaid.asp" and not PageName = "eventsAuthorizePaid.asp" then 'and not PageName = "eventsNewStuReg.asp" and not PageName = "eventsNewStuRegS.asp"

	if session(SESSION_PUSERID) = "" then
		response.Redirect("/events.asp")
	end if
	if session(SESSION_CHILDRENCOUNT) = 0 and not PageName = "eventslookupstudent.asp" and not PageName = "eventsAddChild.asp" and not PageName = "eventsNewStuReg.asp" and not PageName = "eventsNewStuRegS.asp" then
		response.Redirect(makelink("eventslookupstudent.asp&nochild=1"))
	end if
	' Retrieve which groups have view and/or edit rights to the current page
	
end if
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

function RStoJSON(rs, listname)
    dim sFld
    dim sFlds
    dim sRec
    dim sRecs
    dim sRecordSet
    dim lRecCnt
	
	sFlds = ""
	dim fld
	
    sRecordSet = ""
    sRecs = ""
    lRecCnt = 0
    if rs.EOF or rs.BOF then
        RStoJSON = "null"
    else
        do while not rs.EOF and not rs.BOF
            lRecCnt = lRecCnt + 1
            sFlds = ""
            for each fld in rs.Fields
                sFld = """" & fld.Name & """:""" & toUnicode(fld.Value&"") & """"
                sFlds = sFlds & iif(sFlds <> "", ",", "") & sFld
            next 'fld
            sRec = "{" & sFlds & "}"
            sRecs = sRecs & iif(sRecs <> "", "," & vbCrLf, "") & sRec
            rs.MoveNext
        loop
        sRecordSet = "{""" & listname & """: [" & vbCrLf & sRecs & vbCrLf & "] } " 
        'sRecordSet = sRecordSet & """RecordCount"":""" & lRecCnt & """ } )"
        RStoJSON = sRecordSet
    end if
end function

function toUnicode(str)
    dim x
    dim uStr
    dim uChr
    dim uChrCode
    uStr = ""
    for x = 1 to len(str)
        uChr = mid(str,x,1)
        uChrCode = asc(uChr)
        if uChrCode = 8 then ' backspace
            uChr = "\b" 
        elseif uChrCode = 9 then ' tab
            uChr = "\t" 
        elseif uChrCode = 10 then ' line feed
            uChr = "\n" 
        elseif uChrCode = 12 then ' formfeed
            uChr = "\f" 
        elseif uChrCode = 13 then ' carriage return
            uChr = "\r" 
        elseif uChrCode = 34 then ' quote 
            uChr = "\""" 
        elseif uChrCode = 39 then ' apostrophe
            uChr = "'" 
        elseif uChrCode = 92 then ' backslash
            uChr = "\\" 
        elseif uChrCode < 32 or uChrCode > 127 then ' non-ascii characters
            uChr = "\u" & right("0000" & CStr(uChrCode),4)
        end if
        uStr = uStr & uChr
    next
    toUnicode = uStr
end function

function iif(cond,tv,fv)
    if cond then
        iif = tv
    else
        iif = fv
    end if
end function

%>
