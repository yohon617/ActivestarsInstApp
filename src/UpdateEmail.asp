<!--#include file="eventsglobal.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
dim email
email = request("email")
dim connUpdateEmail
		  
if len(email) > 0 then

set connUpdateEmail = Server.CreateObject("ADODB.connection")
connUpdateEmail.Open Application("strConn")
connUpdateEmail.execute("exec a_reg_update_email "&session(SESSION_PUSERID)&", '"&trim(email)&"'")
session(SESSION_EMAIL) = trim(email)
response.Redirect(makeLink("start.asp"))
end if
%>
<table WIDTH="100%" align="center" class="BodyHeader" cellpading="0" cellspacing="0">

	<tr>
	<td>&nbsp;</td>
	<td align="center" class="BodyHeaderTitle" width="302">Update Email</td>
	<td>&nbsp;</td>
	</tr>

</TABLE>
<br><br>
<form action="<%=makeLink("UpdateEmail.asp")%>" method="post" name="form_update_email" id="form_update_email">
<table>
	<tr><td colspan="2">Your account doesn't have an email, please update your email so you can receive notifications.</td></tr>
	<tr>
		<td>
			Email:
		</td>
		<td>
			<input type="text" name="email">
		</td>
	</tr>
	<tr><td colspan="2"><input type="submit" value="Update Email"> </td></tr>
</table>
</form>