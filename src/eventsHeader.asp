<%
'*************** [ NOTICE ] *********************
' COPYRIGHT (c) 2001 TradeBonds.com 
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by Ian Chan October, 2005
' Powered by Meiotic Inc.
'************************************************
%>
<%
const SES_INSTONLY = "IOLY"

dim headerconn
dim headerstrSQL
dim headerRS

set headerconn = Server.CreateObject("ADODB.Connection")
headerconn.Open Application("strConn")

if session(SESSION_LOGGED) = 1 then 
set headerRS = headerconn.execute("a_prereg_getOpenCartCount "&session(SESSION_PUSERID))
end if

%>

<form method="post" name="form_children" id="form_children"> 
    <nav class="navbar navbar-inverse fixed-top bg-inverse">
      <div class="container">
        <div class="navbar-header">
          <!--<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>-->
          <a class="navbar-brand" href="#">
			<%if Application("YC") = "Michigan" then%>
			<img src="assets/img/MILogo_White.png" alt="<%=Application("YCOA")%>" height="50" hspace="0" vspace="0" border="0"><BR>
			<%elseif Application("YC") = "Arizona / Texas" or Application("YC") = "Kansas" or Application("YC") = "Northwest" then%>
			<img src="assets/img/ActivStarsLogo.png" alt="<%=Application("YCOA")%>" height="50" hspace="0" vspace="0" border="0"><BR>
			<%elseif Application("YC") = "North Carolina" then%>s
			<img src="assets/img/ncLogo.png" alt="<%=Application("YCOA")%>" height="120" hspace="0" vspace="0" border="0"><BR>
			<%else%>
			<img src="assets/img/Logo.png" alt="<%=Application("YCOA")%>" height="50" hspace="0" vspace="0" border="0"><BR>
			<%end if%>
          </a>
        </div>
        
		<div id="navbar" class="collapse navbar-collapse">
		<% if session(SESSION_LOGGED) = 1 then %>
		  <ul class="nav navbar-nav">
			<li><a href="<%=makelink("start.asp")%>">Home</a></li>
			<li><a href="<%=makelink("eventsLookUp.asp")%>">Events</a></li>
			<li><a href="<%=makelink("RegClassLookUp.asp")%>">Classes</a></li>
			<!--<li><a href="<%'=makelink("RegClassSRFO.asp")%>">Orders</a></li>-->
			<li><a href="<%=makelink("cart.asp")%>"><span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Cart(<%=headerRS("cartCount")%>)</a></li>
		  </ul>
		  <div class="nav navbar-nav navbar-right">
		   <span class="headerName">user:&nbsp;<strong><%=session(SESSION_NAME)%></strong>&nbsp;&nbsp;
	   		<div class="btn-group">
			  <a href="#" id="headerAccountBtn" role="button" class="btn btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				Account <span class="caret"></span>
			  </a>
			  <ul class="dropdown-menu">
				<li><a href="<%=makeLink("eventsUserRegister.asp&userID=" & session(SESSION_PUSERID))%>">Profile</a></li>
				<li><a href="<%=makeLink("cartHistoryList.asp")%>">Cart History</a></li>
			  </ul>
			</div>
		   
		   </span>
		   <br/>
		   <span style="color: #ffffff;">(If you're not <%=SESSION(SESSION_NAME)%>, <a href="<%=makeLink("eventsLo.asp")%>" class="greentext">LOG OUT</a>.)</span>
		  </div>
		<%else%>
		  <ul class="nav navbar-nav navbar-right">
		   <li><a href="<%=makelink("eventslogin.asp")%>">Login</a></li>
		   </ul>
		<%end if%>
		</div><!--/.nav-collapse -->
      </div>
    </nav>
    <INPUT NAME="UserStudentID" TYPE="hidden" value="">
    
</form>

<script language="JavaScript">
function printPage(param)
{
	// If the page doesn't have the typical headline, print without further action.
	if (!document.getElementById("Headline"))
	{
		window.print();
		return;
	}

	// Declare variables and set up the arrays containing the elements to hide/show.
	var PrintArray1 = new Array("PageHeader","PageFooter","Headline");
	var PrintArray2 = new Array("PrintHeader");
	

	var elementIndex, printElement;

	// Check if the page has more sections to hide for printing than the standard three.
	if 	(document.getElementById("HideForPrinting1")) PrintArray1[3] = "HideForPrinting1";
	if 	(document.getElementById("HideForPrinting2")) PrintArray1[4] = "HideForPrinting2";
	
	// If 'param' = 1 the print mode is activated, if not, the normal mode is restored.
	if (param == 1)
	{
		var HideArray = PrintArray1;
		var ShowArray = PrintArray2;
		printElement = document.getElementById("PageHeadline");
		printElement.innerHTML = document.getElementById("Headline").innerText;
	}
	else
	{
		var HideArray = PrintArray2;
		var ShowArray = PrintArray1;
	}
	
	// Hide/show the elements in the arrays (which vary depending on the target mode).
	for (elementIndex in HideArray)
	{
		printElement = document.getElementById(HideArray[elementIndex]);
		printElement.style.visibility = "hidden";
		printElement.style.display = "none";
	}
	
	for (elementIndex in ShowArray)
	{
		<%if instr(request("v1"),"InstructorDB")<>0 then%>
			if (ShowArray[elementIndex]!="PrintHeader")
			{
				printElement = document.getElementById(ShowArray[elementIndex]);
				printElement.style.visibility = "visible";
				printElement.style.display = "block";
			}
		<%else%>
			printElement = document.getElementById(ShowArray[elementIndex]);
			printElement.style.visibility = "visible";
			printElement.style.display = "block";
		<%end if%>
	}
	
	if (param == 1) window.print();
}

//Added by Mike on June 2003
function openHelp()
{
	window.open('eventsHelp.asp',"Help",'directories=0,height=450,width=600,scrollbars=yes');
}

/*
//Took out on 7/26/2002 Will
function excelPop()
{
	var excelPrint = window.open("<%'=makeExcelable()%>", "excelPrint");	
}
*/
//Added by Mamoru on 2/7/2005
function changeUser()
{
	var usr = document.getElementById("luInstructor");
	
	window.location.replace('<%=makelink("login.asp") & "&usr="%>'+ usr.value);
}
function popInstructor()
{
	var instructorList = window.open("popinst.asp?letter=a&base=header.asp", "instructorList", 'directories=0,height=450,width=600,scrollbars=yes');
}
function validate()
{
	var usr = document.getElementById("luInstructor");
	validateCode(usr.value, 'inst', 'header.asp');
}
function changeChild()
{
		var saveStudent = window.open("", "changeChild", 'directories=0,height=100,width=300,scrollbars=yes');
		document.form_children.target = "changeChild";
		document.form_children.submit();
}
</script>