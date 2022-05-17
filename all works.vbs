Option Explicit
Const ForAppending = 8


Dim  objFSO 
Dim WshShell
Dim objTextFile 
Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objTextFile = objFSO.OpenTextFile("C:\log.txt", ForAppending, True) 'ORG sol at ROTEM new PC
	'Set objTextStream = objFSO.OpenTextFile("C:\log_exe.txt", fsoForAppend) 'ORG sol at ROTEM laptop

Set WshShell = WScript.CreateObject("WScript.Shell")

Dim dd, mm, yy, hh, nn, ss , datevalue, timevalue, dtsnow, dtsvalue ,milliseconds , t, temp , dot
dot = "." 

' MMS SECTION !!!!!!!!!!!!!!!!!
' PPT #1

	'MMS Arbel - v.6.4.0.30.36.2
    'WshShell.AppActivate("Pathway.WPF (32 bit)")
	'WshShell.AppActivate("מנהל המשימות")

	'WshShell.AppActivate("MMS Arbel - v.6.2.0.30.36.2")' see the descending process in task manager 
	WshShell.AppActivate("MMS - v.6.2.21.2")' see the descending process in task manager 
	 'WScript.Sleep 100
	'WshShell.SendKeys {BkSp}' Doesn't work
	'WshShell.SendKeys {BS} ' Doesn't work
	'WshShell.SendKeys {BackSpace}' Doesn't work
	'WshShell.SendKeys "^{ }"' Doesn't work
	WshShell.SendKeys " " ' WORKS !!!!

' PPT #2	
	t = Timer
	temp = Int(t)
	milliseconds = Int((t-temp) * 1000)
	'Store DateTimeStamp once.
	dtsnow = Now()
	'Individual date components
	hh = Right("00" & Hour(dtsnow), 2)
	nn = Right("00" & Minute(dtsnow), 2)
	ss = Right("00" & Second(dtsnow), 2)
	'Build the time string in the format hh:mm:ss
	timevalue = hh & ":" & nn & ":" & ss
	'Concatenate both together to build the timestamp yyyy-mm-dd hh:mm:ss
	'dtsvalue = datevalue & " " & timevalue & " " &  dot & " " & milliseconds 
	dtsvalue = timevalue &  dot  & milliseconds  & " -MMS"
	objTextFile.WriteLine (dtsvalue)

'PSY SECTION !!!!!!!!!!!!!!!!!
' PPT #3
'WshShell.AppActivate("Psy 4.57 (after Jun 7 2020) W7-VC++2010 CP=ROTEM-PC")
'WshShell.AppActivate("Psy 4.62 (after Dec 17 2020) W7-VC++2010 CP=ROTEM-PC")
WshShell.AppActivate("Psy 4.67 (after Feb 28 2021) W7-VC++2010 CP=USER-PC")

'WshShell.AppActivate("Psy  psychophysical tool") 'DOUBLE SPACE GD!!!!!!
'WshShell.AppActivate("Ppt MFC Application (32 bit)")
'WScript.Sleep 100
WshShell.SendKeys " "

' PPT #4	
	t = Timer
	temp = Int(t)
	milliseconds = Int((t-temp) * 1000)
	'Store DateTimeStamp once.
	dtsnow = Now()
	'Individual date components
	hh = Right("00" & Hour(dtsnow), 2)
	nn = Right("00" & Minute(dtsnow), 2)
	ss = Right("00" & Second(dtsnow), 2)
	'Build the time string in the format hh:mm:ss
	timevalue = hh & ":" & nn & ":" & ss
	'Concatenate both together to build the timestamp yyyy-mm-dd hh:mm:ss
	'dtsvalue = datevalue & " " & timevalue & " " &  dot & " " & milliseconds 
	dtsvalue = timevalue &  dot  & milliseconds  & " -PSY"
	objTextFile.WriteLine (dtsvalue)

objTextFile.Close 
WshShell.Run ("C:\Windows\System32\PhotoScreensaver.scr")  
'msgBox ( "ggf")