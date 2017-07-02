<!--
This sample code is designed to connect to Authorize.net using the SIM method.
For API documentation or additional sample code, please visit:
http://developer.authorize.net

Most of this page can be modified using any standard html. The parts of the
page that cannot be modified are noted in the comments.  This file can be
renamed as long as the file extension remains .asp
-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
  "http://www.w3.org/TR/html4/loose.dtd">
<HTML lang='en'>
<HEAD>
	<TITLE> Sample SIM Implementation </TITLE>
</HEAD>
<BODY>

<!-- This section generates the "Submit Payment" button using ASP           -->
<!--#INCLUDE FILE="simlib.asp"-->
<%
' the parameters for the payment can be configured here
' the API Login ID and Transaction Key must be replaced with valid values
Dim loginID, transactionKey, amount, description, label, testMode, url
loginID			= "3p4mHN4L"
transactionKey	= "5cYE9t3RBD26a978"
amount			= "0.1"
description		= "Ian Test"
' The is the label on the 'submit' button
label			= "Submit Payment"
testMode		= "true"
' By default, this sample code is designed to post to our test server for
' developer accounts: https://test.authorize.net/gateway/transact.dll
' for real accounts (even in test mode), please make sure that you are
' posting to: https://secure.authorize.net/gateway/transact.dll
url				= "https://secure.authorize.net/gateway/transact.dll"

' If an amount or description were posted to this page, the defaults are overidden
If Request.Form("amount") <> "" Then
	amount = Request.Form("amount")
End If
If Request.Form("description") <> "" Then
	description = Request.Form("description")
End If

' also check to see if the amount or description were sent using the GET method
If Request.QueryString("amount") <> "" Then
	amount = Request.QueryString("amount")
End If
If Request.QueryString("description") <> "" Then
	description = Request.QueryString("description")
End If

' an invoice is generated using the date and time
Dim invoice
invoice	= Year(Date) & Month(Date) &  Day(Date) & Hour(Now) & Minute(Now) & Second(Now)
' a sequence number is randomly generated
Dim sequence
Randomize
sequence	= Int(1000 * Rnd)
' a time stamp is generated (using a function from simlib.asp)
Dim timeStamp
timeStamp = simTimeStamp()
' a fingerprint is generated using the functions from simlib.asp and md5.asp
Dim fingerprint
fingerprint = HMAC (transactionKey, loginID & "^" & sequence & "^" & timeStamp & "^" & amount & "^")

' Print the Amount and Description to the screen.
Response.Write("Amount: " & amount & " <br />")
Response.Write("Description: " & description & " <br />")

' Create the HTML form containing necessary SIM post values
Response.Write("<FORM method='post' action='" & url & "' >")
' Additional fields can be added here as outlined in the SIM integration guide
' at: http://developer.authorize.net
Response.Write("	<INPUT type='hidden' name='x_login' value='" & loginID & "' />")
Response.Write("	<INPUT type='hidden' name='x_amount' value='" & amount & "' />")
Response.Write("	<INPUT type='hidden' name='x_description' value='" & description & "' />")
Response.Write("	<INPUT type='hidden' name='x_invoice_num' value='" & invoice & "' />")
Response.Write("	<INPUT type='hidden' name='x_fp_sequence' value='" & sequence & "' />")
Response.Write("	<INPUT type='hidden' name='x_fp_timestamp' value='" & timeStamp & "' />")
Response.Write("	<INPUT type='hidden' name='x_fp_hash' value='" & fingerprint & "' />")
Response.Write("	<INPUT type='hidden' name='x_test_request' value='" & testMode & "' />")
Response.Write("	<INPUT type='hidden' name='x_show_form' value='PAYMENT_FORM' />")
Response.Write("	<INPUT type='hidden' name='x_relay_url' value='https://az.youngchampionsofamerica.com/eventsauthorizepaid.asp' />")
Response.Write("	<input type='submit' value='" & label & "' />")
Response.Write("</FORM>")
%>
<!-- This is the end of the code generating the "submit payment" button.    -->

</BODY>
</HTML>