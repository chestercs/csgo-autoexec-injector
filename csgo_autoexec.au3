#include <FileConstants.au3>
#include <MsgBoxConstants.au3>



const $csgoPath = getCsGoPath()
const $cfgPath = $csgoPath & "\csgo\cfg\autoexec.cfg"
writeAutoExec($cfgPath)



;; Functions
Func getCsGoPath()
   Local $scsgoPath64 = RegRead("HKEY_LOCAL_MACHINE64\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 730", "InstallLocation")
   Local $scsgoPath32 = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 730", "InstallLocation")

   if $scsgoPath64 == "" then
	  return $scsgoPath32
   else
	  return $scsgoPath64
   endIf
EndFunc

Func writeAutoExec($cfgPath)
   Local $iFileExists = FileExists($cfgPath)
   ConsoleWrite($cfgPath & @CRLF)
   ConsoleWrite($iFileExists & @CRLF)

   If $iFileExists Then
	  MsgBox($MB_SYSTEMMODAL, "", "The autoexec.cfg file already exists.")
	  If Not IsDeclared("iMsgBoxAnswer") Then Dim $iMsgBoxAnswer
	  $iMsgBoxAnswer = MsgBox(33,"You already have autoexec.cfg","Would you like me to overwrite it?")
	  if $iMsgBoxAnswer == 1 then burnTheCfg($cfgPath)
	  ConsoleWrite($iMsgBoxAnswer)
   Else
	  burnTheCfg($cfgPath)
   EndIf

   ShellExecute($cfgPath) ; Open autoexec.cfg
EndFunc


Func burnTheCfg($cfgPath)
   FileCopy("autoexec.cfg", $cfgPath, $FC_OVERWRITE + $FC_CREATEPATH)
   MsgBox($MB_SYSTEMMODAL, "", "The autoexec.cfg written" & @CRLF & "Have Fun! :)" & @CRLF & "PetyusPolisz@2018")
EndFunc