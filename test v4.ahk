

varRc := 2

result := getHsNumAndGateAndJersey(varRc)
for horseNum, details in result
{
    gate := details.gate
    code := details.code
    MsgBox, Horse Number: %horseNum%`nGate: %gate%`nCode: %code%
}


return

getHsNumAndGateAndJersey(rcParam) {

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

loop, 5
    {
    RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
    StringReplace, data2, data2, % field3_, 

    RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
    StringReplace, data2, data2, % field4_,

    RegExMatch(data2, "s)<td align=""center"">(?P<gate>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)
    StringReplace, data2, data2, % field5_, 
    
    if (field3_hsenum > 0)
        {
        horseNumAndGateAndJersey[field3_hsenum] := {"gate":field5_gate,"code":field4_hsCode}
        }
        
    }
return horseNumAndGateAndJersey
}
