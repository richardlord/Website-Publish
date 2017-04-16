<?php
/*	Richard's PHP script to write an xml object to a file.
	For this to work, the contentType property of the
	xml object in flash must be set to texl/xml...
	
		myxml.contentType = "text/xml";
	
	because this script doesn't work with the default type 
	(application/x-www-form-urlencoded) unless you
	set the PHP server to retain the $HTTP_RAW_POST_DATA 
	global variable even with application/x-www-form-urlencoded data. 
	
	If the script is, for example, at uploadxml.php, call the script as
	
		uploadxml.php?filename=somefile 
	
	where somefile is the location of the relative or absolute location
	of the file you wish to write to on the server.
	
	You must have permissions to write to the file (if it doesn't work, 
	check that the chmod settings for the directory you're saving the 
	file in allow you to save files there).
	
	Any current contents of the file will be overwritten, and if the
	file doesn't exist it will be created.
	
	It returns an XML file containing
		<success>yes</success>
	or
		<success>no</success>
	depending whether the file was saved successfully or not.
	
	Example code to create and save a very simple XML file in flash...
	
	myxml = new XML("<test>some text</test>");
	myxml.contentType = "text/xml";
	successxml = new XML();
	successxml.onLoad = loaded;
	myxml.sendAndLoad("uploadxml.php?filename=flashtest.xml", successxml);

	function loaded(success) {
		if (success) {
			if(successxml.firstchild.firstchild.nodevalue = "yes") {
				// it worked
			} else {
				// something went wrong
			}
		}
	}
	
	
	Copyright Big Room Ventures Limited 2003.
	http://www.bigroom.co.uk/
	
	Use this script wherever you like, but leave this copyright notice in.
	
	-- Richard Lord (richard@bigroom.co.uk)

*/

// here's the actual php code.

	$filename = $_GET['filename'];
	@$f = fopen($filename, "w+");
	if ($f) {
   	fwrite ( $f, "$HTTP_RAW_POST_DATA" );
   	fclose( $f );
		print '<success>yes</success>';
	} else { 
		print '<success>no</success>';
	} 

?>