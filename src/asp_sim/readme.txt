--------------------------------------------------------------------------------
DOCUMENTATION
--------------------------------------------------------------------------------

This code sample has been successfully tested on the following server
configurations and performed according to Authorize.Net's documented Server
Integration Method (SIM) standards.
  Microsoft-IIS/5.1 using VBScript Version 5.7

Last updated January 2009

For complete documentation, please visit the Authorize.Net developer website at:
http://developer.authorize.net

--------------------------------------------------------------------------------
DISCLAIMER
--------------------------------------------------------------------------------

WARNING: ANY USE BY YOU OF THE SAMPLE CODE PROVIDED IS AT YOUR OWN RISK

Authorize.Net provides this code "as is" without warranty of any kind, either
express or implied, including but not limited to the implied warranties of
suitability and/or fitness for a particular purpose.

This sample code is provided merely as a blueprint demonstrating one possible
approach to integrating with Authorize.Net using our Server Integration
Method.

This sample code is not a tutorial.  If you are unfamiliar with specific
programming functions and concepts, please consult the appropriate reference
materials.

--------------------------------------------------------------------------------
PREREQUISITES
--------------------------------------------------------------------------------

- In order to establish a successful connection to Authorize.Net, it is required
  that you obtain a valid API Login ID and Transaction Key and enter these
  values into the appropriate places within this sample code.  This is obtained
  within the Settings section of your Authorize.Net account.  If you do not have
  an Authorize.Net account or prefer not to use it for testing, you can obtain
  a free developer test account by using the form at:
  http://developer.authorize.net
  
- The default amount and description in this sample code can be overridden by
  submitting new "amount" or "description" variables to the code using either
  either a POST or GET.

- The files included in asplibs.zip are required for this code to function. 
  Classic ASP does not provide built in support for generating an HMAC MD5 hash,
  the simlib.asp and md5.asp provide this functionality.  Simlib.asp also is
  used to generate the necessary timestamp. By default, sample.asp, md5.asp, and
  simlib.asp must all be placed in the same folder.

--------------------------------------------------------------------------------
TROUBLESHOOTING
--------------------------------------------------------------------------------

ERROR: 
  13 - The merchant Login ID is invalid or the account is inactive.

RESOLUTION:
  This error is caused by one of two things.
	
  First, the "API Login ID" entered	is invalid. Please ensure that you have
  updated the sample code with your valid API Login ID. (see PREREQUISITES)
	
  Second, the wrong posting URL is being used. For developer accounts, ensure
  that you are posting to: https://test.authorize.net/gateway/transact.dll
  For live accounts (even in test mode) ensure that you are posting to:
  https://secure.authorize.net/gateway/transact.dll
	
ERROR:
  99 - This transaction cannot be accepted.
	
RESOLUTION:
  This error is most commonly caused by an invalid Transaction Key. Please
  ensure that you have updated the sample code with your valid Transaction key.
  (see PREREQUISITES)
  
  Alternatively, changes to this code or differences in your server
  configuration could be preventing the successful creation of a fingerprint.
  You can find additional information on this error at:
  https://developer.authorize.net/response_code_99.asp
  
ERROR:
  97 - This transaction cannot be accepted.
  
RESOLUTION:
  This error occurs when your server is not set to the correct time or does not
  have its time zone properly configured.  This can be avoided by correctly
  setting your server clock.
  
  For additional details on error 97 see:
  http://developer.authorize.net/tools/responsecode97/
  
DEVELOPER TOOLS:
  Authorize.Net's developer site provides tools for helping diagnose any error
  that you may encounter.  Here are some tools that may help you.
  
 RESPONSE REASON CODE TOOL:
  This tool can be used to look up the meaning of any error code returned by
  the Authorize.Net SIM or AIM APIs.  The most common errors also include
  troubleshooting steps:
  http://developer.authorize.net/tools/responsereasoncode/

 DATA VALIDATION URL TOOL:
  The data validation tool allows you to double check all of the data that you
  are sending to Authorize.Net with your SIM request.  This can often make it
  easy to see errors that are otherwise difficult to locate:
  http://developer.authorize.net/tools/datavalidation/
  
 DOCUMENTATION:
  Documentation for all of our integration methods can be found on our
  developer site.  Please review this documentation for additional
  details on the integration process:
  http://developer.authorize.net/guides/
  
OTHER ERRORS:
  If all else fails, you can contact our integration support department at:
  integration@authorize.net
  
  Please provide clear details on the error that you are receiving and the
  steps that you are taking to produce the error.  Also remember that we cannot
  support individual e-commerce developers with programming problems and other
  issues that are not directly caused by, or related to, our APIs.