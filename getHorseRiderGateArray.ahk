#SingleInstance, Force
#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

f1::

varRc := 1

result := getHsNumAndGateAndJersey(varRc)
for horseNum, details in result
    {
    gate := details.gate
    code := details.code
    rider := details.rider
    pace := details.pace
    MsgBox, Horse Number: %horseNum%`nGate: %gate%`nCode: %code%`nRider: %rider%`nPace: %pace%
    }

;---------------------------------------------------------------------------------------------------------------------

msgbox, Completed
exitApp
return

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

getHsNumAndGateAndJersey(rcParam) {

    hcodeurl := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=660322945&single=true&output=csv"

    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", hcodeurl, true)
    whr.Send()
    whr.WaitForResponse()
    hseCodeList := ""
    hseCodeList := whr.ResponseText
    ; msgbox,,, % hseCodeList, 


   horseNumAndGateAndJersey := {}

   url_get := "https://www.scmp.com/sport/racing/racecard/@"
   StringReplace, url_get, url_get, @ , %rcParam%

    http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    http.Open("GET", url_get, false)
    http.Send()

    InOutData :=
    InOutData := http.ResponseText

   if (InOutData = "")
      {
      InOutData := URLDownloadToVar(url_get)
      }


RegExMatch(InOutData, "s)<div class=""race-table"">(.*)<table class=""remarks"">", data2)
FileCreateDir, Jersey

loop, 14
    {
    RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
    StringReplace, data2, data2, % field3_, 

    RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
    StringReplace, data2, data2, % field4_,

    RegExMatch(data2, "s)<td align=""center"">(?P<gate>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)
    StringReplace, data2, data2, % field5_, 
    
    RegExMatch(data2, "s)<a href=""/sport/racing/stats/jockey/\d+/(?P<rider>.*?)<", field5_)
    ; msgbox, % field5_rider
    StringReplace, data2, data2, % field5_, 
    StringSplit, namefield, field5_rider, "
    ; msgbox, % namefield1


    RegExMatch(hseCodeList, "s)(" field4_hsCode ")\,(?P<pace>.*?)\s", field6_)
    ; msgbox,,pace, %pace_% `n%A_index% `n%field4_hsCode% `n%pace_2%,


    if (field3_hsenum > 0)
        {
        horseNumAndGateAndJersey[field3_hsenum] := {"gate":field5_gate,"code":field4_hsCode,"rider":namefield1,"pace":field6_pace}
        }
        
    }
return horseNumAndGateAndJersey
}

;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

alt & esc::reload