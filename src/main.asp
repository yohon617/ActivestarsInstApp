<!--#include file="global.asp"-->
<%
'*************** [ NOTICE ] *********************
' All Rights reserved.
' Unlawful use of this code is prohibited
' Written by William Tam December, 2001
' Powered by Meiotic Inc.
'************************************************

dim base
base = request.QueryString("v1")
base = replace (base, "/", "")

'if left(Application("CR_database"), 2) = "yo" then
	'response.redirect(makeLink("main_CA.asp"))
'end if
%>

<table WIDTH="100%" align="center" class="BodyHeader" cellpading="0" cellspacing="0">

	<tr>
	<td>&nbsp;</td>
	<td align="center" class="BodyHeaderTitle" width="256">Main Console</td>
	<td>&nbsp;</td>
	</tr>

</TABLE>

<table WIDTH="100%" align="center" border=0 cellpading="0" cellspacing="0">
	<tr>
	<td>&nbsp;</td>
	<td width="260">
		
<SCRIPT>
	var menuTop;
	var menuWidth;
	menuTop=112;menuWidth=260;
	
	// Special effect string for IE5.5 or above please visit http://www.milonic.co.uk/menu/filters_sample.php for more filters
	timegap=500					// The time delay for menus to remain visible on mouse off
	followspeed=7				// Follow Scrolling speed (higher number makes the scrolling smoother but slower)
	followrate=30				// Follow Scrolling Rate (use a minimum of 40 or you may experience problems)
	suboffset_top=0;			// Sub menu offset Top position 
	suboffset_left=12;			// Sub menu offset Left position
	
	effect = "Fade(duration=0.2);Shadow(color='#999999', Direction=135, Strength=5)" 
	
	menunum=0;
	menus=new Array();
	_d=document;
	
	function addmenu()
	{
		menunum++;
		menus[menunum]=menu;
	}
	
	function dumpmenus()
	{
		mt="<script language=javascript>";
		for(a=1;a<menus.length;a++)
		{
			mt+=" menu"+a+"=menus["+a+"];"
		}
		mt+="<\/script>";
		_d.write(mt)
	}
	
	
	style1=[					// style1 is an array of properties. You can have as many property arrays as you need. This means that menus can have their own style.
	"378097",					// Mouse Off Font Color
	"CCCC9A",					// Mouse Off Background Color
	"378097",					// Mouse On Font Color
	"FFFFFF",					// Mouse On Background Color
	"000000",					// Menu Border Color 
	17,							// Font Size in pixels
	"normal",					// Font Style (italic or normal)
	"bold",						// Font Weight (bold or normal)
	"Helvetica, Arial, Verdana, Tahoma, sans-serif;",	// Font Name
	6,							// Menu Item Padding
	"",							// Sub Menu Image (Leave this blank if not needed)
	,							// 3D Border & Separator bar
	"66ffff",					// 3D High Color
	"000099",					// 3D Low Color
	,							// Referer Item Font Color (leave this blank to disable)
	,							// Referer Item Background Color (leave this blank to disable)
	"arrowdn.gif",				// Top Bar image (Leave this blank to disable)
	"ffffff",					// Menu Header Font Color (Leave blank if headers are not needed)
	"000099",					// Menu Header Background Color (Leave blank if headers are not needed)
	]
	
	
	
	addmenu(menu=[
	"sidemenu",
	menuTop,					// Menu Top - The Top position of the menu in pixels
	,							// Menu Left - The Left position of the menu in pixels
	menuWidth,					// Menu Width - Menus width in pixels
	1,							// Menu Border Width 
	,
	style1,
	1,
	"left",
	effect,
	,
	,
	,
	,
	,
	,
	,
	,
	,
	,
	,
	,"Classes","show-menu=classes",,"",0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Ops","show-menu=classops",,"",0
	<%end if%>
	,"Inv. Transactions","show-menu=invtrans",,"",0
	<%if CByte(Session(SESSION_INSTRUCTOR)) = 1 then%>
	,"Order Requests","show-menu=rfos",,"",0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Purchase Orders","show-menu=porders",,"",0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 or _
		 CByte(Session(SESSION_INSTRUCTOR)) = 1 then%>
	,"Inventory","show-menu=inventory",,"",0
	<%end if%>
	<%if CByte(Session(SESSION_INSTONLY)) = 0 then%>
	,"Class Reports","show-menu=classreports",,"",0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Ops Reports","show-menu-opsreports",,"",0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTINGMGR)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORYMGR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Accounting Reports","show-menu=areports",,"",0
	,"Inventory Reports","show-menu=ireports",,"",0
	<%end if%>
	<%if CByte(SESSION(SESSION_INSTONLY)) = 1 then%>
	,"Instructor Reports","show-menu=instreports",,"",0
	<%end if%>
	,"Utilities","show-menu=utilities",,"",0
	])


	addmenu(menu=["classes",,,200,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"Class Reports","<%=makeLink("cplu.asp")%>",,,0
	,"Class Roster","<%=makeLink("crlu.asp")%>",,,0
	,"Team Roster","<%=makeLink("srlu.asp")%>",,,0
	])
	
	
	addmenu(menu=["instreports",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"Class-Related Report","<%=makeLink("CR_InstructorClassUseReportDoor.asp")%>",,,0
	,"Awards Report","<%=makeLink("")%>",,,0		
	,"Sales & Retention","<%=makeLink("CR_ClassRetentionInstructorSalesReportDoor.asp")%>",,,0
	])
	
	
	addmenu(menu=["classops",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Classes","<%=makeLink("aemclu.asp")%>",,,0
	,"View\/Edit Districts","<%=makeLink("aemdlu.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Instructors","<%=makeLink("aemilu.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Locations","<%=makeLink("aemllu.asp" & "&base=" & base)%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Parent Helpers","<%=makeLink("aemphlu.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Schools","<%=makeLink("aemschlu.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_FACILITYOPSMGR)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPSMGR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Sponsors","<%=makeLink("aemsplu.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Students","<%=makeLink("aemstlu.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_FACILITYOPSMGR)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPSMGR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"View\/Edit Tournaments","<%=makeLink("RepTournaments.asp")%>",,,0
	<%end if%>
	])
	
	
	addmenu(menu=["opsreports",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Locations & Times","<%=makeLink("CR_ClassLocationAndTimes.asp")%>",,,0
	<%end if%>
	,"Class Rpt. Env. Label","<%=makeLink("CR_PrintClassReportLabelDoor.asp")%>",,,0
	,"Inst Addr Label","<%=makeLink("CR_InstructorAddressLabelDoor.asp")%>",,,0
	,"Inst Box Label","<%=makeLink("CR_PrintInstructorsLabelDoor.asp")%>",,,0
	,"Instructors Database","<%=makeLink("InstructorDBDoor(4x3).asp")%>",,,0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Key Tracking","<%=makeLink("CR_KeyTracking.asp")%>",,,0		 
	,"Master Class Schedule","<%=makeLink("CR_MasterClassScheduleDoor.asp")%>",,,0
	,"Master Class Schedule (Enhanced)","<%=makeLink("CR_MasterClassScheduleEnhancedDoor.asp")%>",,,0
	<%end if%>
	,"Print Calendars","/PrintCalendar/Classes.aspx target=\"_blank\"",,,0
<%if Application("dbnConn")="YCOA_AZ" or Application("dbnConn")="YCOA_CO" or left(Application("dbnConn"),2)="yo" or Application("dbnConn")="YCOA_KS" or Application("dbnConn")="YCOA_NC" or Application("dbnConn")="YCOA_TEST" then%>	
	,"Schools Label","<%=makeLink("PrintSchoolLabelByDistrict.asp")%>",,,0
<%end if%>	
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Student Count By Age","<%=makeLink("CR_StudentCountByAge.asp")%>",,,0
	<%end if%>
	])
	
	
	addmenu(menu=["classreports",,,350,1,,style1,,"left",effect,,,,,,,,,,,,
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"All Classes","<%=makeLink("RepAllClass.asp&rep=1")%>",,,0
	,"Class Attendance Report - Detailed","<%=makeLink("RepAttendance.asp&rep=1")%>",,,0
	,"Class Attendance Report - Summary","<%if Application("dbnConn")="yo" then response.write (makeLink("CR_StudentAttendenceAnalysis.asp")) else response.write (makeLink("RepAttendance_Summary.asp&rep=1")) end if%>",,,0	
	,"Class Cancellation Report","<%=makeLink("RepClassCancel.asp&rep=1")%>",,,0
	,"Class Demographics Report","<%=makeLink("CR_ClassDemographics.asp")%>",,,0	
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INSTRUCTOR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Report Detail","<%=makeLink("CR_ClassReportDetailDoor.asp")%>",,,0
	<%end if%>	
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Report Detail - Instr.","<%=makeLink("CR_ClassReportDetailDoor_Instructor.asp")%>",,,0
	<%end if%>	
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INSTRUCTOR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Sales & Retention","<%=makeLink("CR_ClassRetentionInstructorSalesReportDoor.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Reports Collected","<%=makeLink("CR_ClassReportCollectedSummary.asp")%>",,,0			 
	,"Class Schedule","<%=makeLink("CR_ClassScheduleDoor.asp")%>",,,0
	,"Class Startup Schedule","<%=makeLink("RepClassStartup.asp&rep=1")%>",,,0
	,"Flyer Printing Schedule","<%=makeLink("CR_FlierPrintingDoor.asp")%>",,,0	
	,"Instructor HotList Report","<%=makeLink("CR_InstructorHotList.asp")%>",,,0		
	,"Location HotList Report","<%=makeLink("CR_LocationHotList.asp")%>",,,0		
	,"New Flyer Tracking","<%=makeLink("NewFlyerTracking.asp&rep=1")%>",,,0
	,"Semester Start Comparison Report","<%=makeLink("CR_SemesterStartComparison.asp")%>",,,0	
	,"Student Attendance Analysis","<%if Application("dbnConn")="yo" then response.write (makeLink("CR_ClassAttendance.asp")) else response.write (makeLink("CR_StudentAttendenceAnalysis.asp")) end if%>",,,0
	<%end if%>
	])
	
	
	addmenu(menu=["invtrans",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"Look-up Transactions","<%=makeLink("LookupTrans.asp")%>",,,0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 then%>
	,"Add new Order","<%=makeLink("AddOrder.asp&ora=1")%>",,,0
	,"Add Order from Request","<%=makeLink("LookupRFOs.asp")%>",,,0
	,"Add Order from Template","<%=makeLink("AddOrder3.asp&or=1")%>",,,0
	,"Add new Return","<%=makeLink("AddOrder.asp&ora=2")%>",,,0
	,"Add Return from Order","<%=makeLink("AddOrder3.asp&or=2")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
	 	 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Add new Raffle Sale","<%=makeLink("DirectAddRaffle.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTINGMGR)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORYMGR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Add new Direct Sale","<%=makeLink("AddDSale.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
		,"Batch-Posting","<%=makeLink("LookupUnposted.asp")%>",,,0
	<%end if%>
	,"Look-up Shipments","<%=makeLink("LookupShipments2.asp")%>",,,0
	])
	
	
	addmenu(menu=["areports",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 then%>
	,"Bad Check Table","<%=makeLink("RepBadChecks.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Class Fee Refunds","<%=makeLink("RepClassFeeRefunds.asp&rep=1")%>",,,0
	<%end if%>
	,"Deposit Detail","<%=makeLink("CR_DepositDetailReportDoor.asp")%>",,,0
	,"Employee Payments","<%=makeLink("LookupEmpWage.asp")%>",,,0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Facility Payments","<%=makeLink("FacilityPayments.asp")%>",,,0
	<%end if%>
	,"Late Class Reports","<%=makeLink("RepLateClassReports.asp&rep=1")%>",,,0
	,"Payroll Report","<%=makeLink("CR_PayrollReportDoor.asp")%>",,,0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Sales By Category","<%=makeLink("CR_SalesByCategory.asp")%>",,,0	
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
	 	 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"State Sales Tax","<%=makeLink("CR_StateSalesTaxReportDoor.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Student Equipment Returns","<%=makeLink("RepEquipReturns.asp&rep=1")%>",,,0
	,"Student/Location Reports","<%=makeLink("CR_StudentFromLocationDoor.asp")%>",,,0	
	<%end if%>
	,"Student Returns & Refunds","<%=makeLink("LookupClasses.asp")%>",,,0
	])
	
	
	addmenu(menu=["ireports",,,300,1,"",style1,,"left",effect,,,,,,,,,,,,
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
 	,"Consumption Report","<%=makeLink("CR_Consumption.asp")%>",,,0				 			 
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Display Inventory Report","<%=makeLink("CR_DisplayInventoryDoor.asp")%>",,,0
	<%end if%>	
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Exception Report","<%=makeLink("CR_Exception.asp")%>",,,0				 
	,"Hot Items Report","<%=makeLink("CR_HotItem.asp")%>",,,0				 	
	,"Inventory Alert Report","<%=makeLink("CR_InventoryAlert.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Inventory Analysis Report","<%=makeLink("CR_InventoryOnHand.asp")%>",,,0	
	,"Inventory Detail Report","<%=makeLink("CR_InventoryDetail.asp")%>",,,0		
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Inventory Reorder Report","<%=makeLink("CR_InventoryReorder.asp")%>",,,0	 		 
	,"Inventory Transaction Report","<%=makeLink("RepInvTransactions.asp")%>",,,0
	,"Inventory Transaction Report - SE","<%=makeLink("RepInvTransactions_SE.asp")%>",,,0
	,"Inventory Value History","<%=makeLink("RepInventoryValue.asp")%>",,,0
	,"Inventory Value Report","<%=makeLink("CR_InventoryValue.asp")%>",,,0				
	,"Vendor Comparison","<%=makeLink("CR_VendorComparison.asp")%>",,,0		
	<%end if%>
	])

	
	addmenu(menu=["rfos",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"Look-up Order Requests","<%=makeLink("LookupRFOs.asp")%>",,,0
	,"Add new Order Request","<%=makeLink("AddRFO.asp")%>",,,0
	])
	
	
	addmenu(menu=["porders",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	,"Look-up Purchase Orders","<%=makeLink("LookupPOrder.asp")%>",,,0
	,"Add new Purchase Order","<%=makeLink("AddPOrder.asp")%>",,,0
	,"Manage Vendors","<%=makeLink("ModVendors.asp")%>",,,0
	])
	

	addmenu(menu=["inventory",,,250,1,"",style1,,"left",effect,,,,,,,,,,,,
	<%if CByte(SESSION(SESSION_INVENTORY)) = 1 then%>
	,"Shipment Screen","<%=makeLink("LookupShipments1.asp")%>",,,0
	<%end if%>
	<%if left(Application("dbnConn"),2)="yo" then%>
		<%if not CByte(SESSION(SESSION_INSTONLY)) = 1 then%>
			,"Inventory Lookup","<%=makeLink("LookupInventory.asp")%>",,,0
		<%end if%>	
	<%else%>
		,"Inventory Lookup","<%=makeLink("LookupInventory.asp")%>",,,0
	<%end if%>
	,"Item Non-Availability Screen","<%=makeLink("LookupNAItems.asp")%>",,,0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Items on Back-Order","<%=makeLink("LookupBOItems.asp")%>",,,0
	<%end if%>
	
	<%if CByte(SESSION(SESSION_ACCOUNTINGMGR)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORYMGR)) = 1 then%>
	,"Add new Adjustment","<%=makeLink("AddOrder.asp&ora=3")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_INVENTORYMGR)) = 1 then%>
	,"Add new Transfer","<%=makeLink("AddSale.asp&crt=3")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Manage Inventory Items","<%=makeLink("RepInvReport.asp&rep=1")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTINGMGR)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORYMGR)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Manage Inventory Items+","<%=makeLink("ModInvItems.asp")%>",,,0	
	,"Manage Inventory Groups","<%=makeLink("ModInvGroups.asp")%>",,,0
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Manage Order Templates","<%=makeLink("ModOrderTemplates.asp")%>",,,0
	,"Print Labels","<%=makeLink("PrintBarcodes.asp")%>",,,0
	<%end if%>
	])


	addmenu(menu=["utilities",,,250,1,,style1,,"left",effect,,,,,,,,,,,,
	,"Document Center","<%=makeLink("dc.asp")%>",,,0
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Document Schedule","<%=makeLink("DocumentSchedule.asp")%>",,,0	
<%if Application("dbnConn")="YCOA_AZ" or Application("dbnConn")="YCOA_CO" or left(Application("dbnConn"),2)="yo" or Application("dbnConn")="YCOA_KS" or Application("dbnConn")="YCOA_NC" or Application("dbnConn")="YCOA_TEST" then%>		
	,"Flyer Distribution","<%=makeLink("FlyerStartUp.asp")%>",,,0		
<%end if%>	
	<%end if%>
	,"Instructor Notes","<%=makeLink("InstructorNotes.asp")%>",,,0		
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_INVENTORY)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Instructor Rankings","<%=makeLink("CR_InstructorRanking.asp")%>",,,0				 
	<%end if%>
	<%if CByte(SESSION(SESSION_ACCOUNTING)) = 1 or _
		 CByte(SESSION(SESSION_FACILITYOPS)) = 1 or _
		 CByte(SESSION(SESSION_FIELDOPS)) = 1 or _
		 CByte(SESSION(SESSION_EXECUTIVE)) = 1 then%>
	,"Office Reminders","<%=makeLink("OfficeReminders.asp")%>",,,0	
	<%end if%>	
	])
	

	dumpmenus();
</SCRIPT>

<SCRIPT language=JavaScript src="js/mmenu.js" type=text/javascript></SCRIPT>

	</td>
	<td>&nbsp;</td>
	</tr>
</TABLE>
<table height="100%" border="0" width="100%">
<%
                          if CByte(SESSION(SESSION_INSTRUCTOR)) = 1 then
				response.write( _
				"<tr><td align='right'><a href='" & _
				makeLink("menu.asp&menuid=2") & _
				"'>Main Console v3</a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>")
                          else
				response.write( _
				"<tr><td align='right'><a href='" & _
				makeLink("menu.asp&menuid=1") & _
				"'>Main Console v3</a>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>")
                          end if
%>
	<tr><td align="center"><a href="<%=makeLink("main_CA.asp")%>">Main Console v2.0</a></td></tr>
</table>


