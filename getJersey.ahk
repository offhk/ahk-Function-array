
#SingleInstance force
#NoEnv
#Persistent
SendMode Input

#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#Include <JSON>
FileRemoveDir, Jersey, 1

f1::

FormatTime timestamp, A_Now, yyyy-MM-dd

global varRc := 1

getRiderColor(varRc)

return

;===================================================================================================================================  

getRiderColor(rcParam) {
    
url_get := "https://www.scmp.com/sport/racing/racecard/@"
StringReplace, url_get, url_get, @ , %varRc%

InOutData :=
WinHttpRequest(url_get, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")

url_venue := 
url_venue := InOutData

RegExMatch(url_venue, "s)<div class=""race-table"">(.*)<table class=""remarks"">", data2)
FileCreateDir, Jersey

loop, 14
    {
    RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
    StringReplace, data2, data2, % field3_, 

    RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
    StringReplace, data2, data2, % field4_, 
    if (field3_hsenum > 0)
        {
        URLDownloadToFile, https://racing.hkjc.com/racing/content/Images/RaceColor/%field4_hsCode%.gif, %A_ScriptDir%\jersey\%field4_hsCode%.gif
        }
    }

}
;=================================================================================================================================== reload

alt & esc::reload

