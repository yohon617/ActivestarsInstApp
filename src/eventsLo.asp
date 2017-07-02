<%
'following 3 lines of code tells the server to terminate the 3
'Crystal Report session variables that will take up the RDC licenses
set Session("oPageEngine") = nothing
set Session("oRpt") = nothing
set Session("oApp") = nothing

Response.Cookies ("YCOACOOKIE")("username") = ""
Response.Cookies ("YCOACOOKIE").Expires = now() - 1
Session.Abandon

Response.Redirect("events.asp?v1=eventslogin.asp")
%>
