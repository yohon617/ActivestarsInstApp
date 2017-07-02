<!--#include file="global.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by William Tam December, 2001/June, 2003
' Powered by Meiotic Inc.
'************************************************

dim conn
dim strSQL
dim rs
dim code
dim cat
dim base

code = request("checkCode")
cat = request("cat")
base = request("base")

set conn = Server.CreateObject("ADODB.connection")
conn.Open Application("strConn")
strSQL = "exec a_validate_Code '"&code&"', '"&cat&"'"
set rs = conn.execute(strSQL)
set conn = Nothing %>


<% if rs.EOF = false then %>

	<script language="JavaScript">
		window.close();
	</script>

<% else %>

	<HTML>
	<HEAD>
		<TITLE><%=Application("YCOA")%>, Inc.</TITLE>
	</HEAD>
	<BODY>
	
	<% if base = "cplu.asp" then %>
		<script language="JavaScript">
			window.opener.document.form_classreport_lookup.luInstructor.value="";
			window.opener.document.form_classreport_lookup.luInstructor.focus();
			window.focus();
			window.self.setTimeout('window.close()',2000);
		</script>
	<% end if %>
	
	<% if base = "AddOrderItems.asp" then %>
		<script language="JavaScript">
			var orgVal = window.opener.document.form_add_item.GrpInv.value
			window.opener.document.form_add_item.GrpInv.value="";
			window.opener.document.form_add_item.GrpInv.focus();
			window.focus();
			window.opener.document.form_add_item.GrpInv.value = orgVal
			window.self.setTimeout('window.close()',2000);
		</script>
	<% end if %>
<%if 1=2 then%>	
	<% if base = "FlyerStartUp.asp" then %>
		<script language="JavaScript">
			window.opener.document.form_flyer_startup.luTemplateName.value="";
			window.opener.document.form_flyer_startup.luTemplateName.focus();
			window.focus();
			window.self.setTimeout('window.close()',2000);
		</script>
	<% end if %>
<%end if%>
	
	
	<% 'if base <> "FlyerStartUp.asp" then %>
	<table>
		<tr><td>&nbsp;<br>&nbsp;&nbsp;<span class="redtext">'<%=ucase(code)%>' is not a valid code. Please re-enter!</span></td></tr>
	</table>
	<% 'else %> 
	<!--
	<table>
		<tr><td>&nbsp;<br>&nbsp;&nbsp;<span class="redtext">'<%=ucase(code)%>' already exist. Please re-enter!</span></td></tr>
	</table>
	-->
	<% 'end if %>
	</BODY>

<% end if %>


<SCRIPT language="javascript">
var mac = navigator.appVersion.indexOf("Mac")>-1		
    if (navigator.appName == "Netscape" && parseFloat(navigator.appVersion) > 5.00)
	{
		document.write ("<link rel=\"stylesheet\" href=\"/Styles/NSstyle6.css\" type=\"text/css\">")
	} 
	else if (navigator.appName == "Netscape" && parseFloat(navigator.appVersion) < 5.00)
	{
		document.write ("<link rel=\"stylesheet\" href=\"/Styles/NSstyle47.css\" type=\"text/css\">")
	}
	else if (navigator.appName == "Netscape" && navigator.appVersion=="4.7 [en] (WinNT; U)")
	{
		document.write ("<link rel=\"stylesheet\" href=\"/Styles/NSstyle47.css\" type=\"text/css\">")
	}
	else 
	{  
    	document.write ("<link rel=\"stylesheet\" href=\"/Styles/IEstyle.css\" type=\"text/css\">")
    }
</SCRIPT>

</HTML>