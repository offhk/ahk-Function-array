

FormatTime timestamp, A_Now, yyyy-MM-dd

; obj := MyFunction()
; MsgBox % "Name: " obj.name "`nAge: " obj.age "`nCity: " obj.city

varRc := 1

; hkData := getHkData(varRc)
; msgbox, % "Rc : " varRc
; .  "`nddd : " hkData.hari "`nmmm : " hkData.bln "`nyyy :" hkData.thn 
; .  "`n" hkData.vkod "`n" hkData.course
; .  "`n" hkData.xxx "`n" hkData.xxx "`n" hkData.xxx
; .  "`n" hkData.xxx "`n" hkData.xxx "`n" hkData.xxx


; outsiders := getOutsiders(varRc)
; msgbox, % outsiders

; hsSpeed := getHsSpeed(varRc)
; msgbox, % hsSpeed

; errlist := getHsErrList(varRc)
; msgbox, % errlist

; getHsNumAndGateAndJersey(varRc)

returnedArray  := getHsNumAndGateAndJersey(varRc)
; MsgBox,,, % returnedArray[0]


; for key, value in returnedArray {
;     MsgBox, % "Key: " key ", Value: " returnedArray.gate
; }


; msgbox, % horseNumAndGateAndJersey[1]
; msgbox,,show1, % show1[1][1]
; msgbox,,, % horseNumAndGateAndJersey

return

;===================================================================================================================================  func getHkData

getHkData(rcParam){

    url_get := "https://www.scmp.com/sport/racing/racecard/@"
    StringReplace, url_get, url_get, @ , %rcParam%
    ; msgbox,,, % url_get

    InOutData :=
    WinHttpRequest(url_get, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
    InOutData := RegExReplace(InOutData, "<script>.*DATA>")
    url_venue := 
    url_venue := InOutData
    ; msgbox,,url_get, % url_venue

    if (url_venue = "")
        {
        url_venue := URLDownloadToVar(url_get)
    ;  MsgBox % url_venue
        }

    ;=================================================================================================================================== get date stamp

    RegExMatch(url_venue, "s)<div id=""race-table-header"" class=page-racecard>`n\s+<h1>(?P<ddd>\d+) (?P<mmm>.*) (?P<yyy>\d+) - (?P<vne>Happy Valley|Sha Tin)</h1>", field1_)
    _yyy :=
    _yyy := field1_yyy

    month_ := {"January":"01","February":"02","March":"03","April":"04","May":"05","June":"06","July":"07","August":"08","September":"09","October":"10","November":"11","December":"12"}
    _mmm := 
    _mmm := month_[field1_mmm]

    _ddd :=
    if(field1_ddd <= 9)
    {
    _ddd .= 0 . field1_ddd
    ; GuiControl, %guiId%:, site_dd, %_ddd%
    }
    else
    {
    _ddd := field1_ddd
    ; GuiControl, %guiId%:, site_dd, %_ddd%
    }

    site_dd_mm_yy = %_ddd%-%_mmm%-%_yyy%
    odd_yy_mmm_dd = %_yyy%-%_mmm%-%_ddd% 
    ; msgbox % _ddd " - " _mmm " - " _yyy "`n" site_dd_mm_yy

    ;=================================================================================================================================== get venue

    If(field1_vne = "Happy Valley")
    {
    vneCode = HV
    ; msgbox HV
    }
    Else
    {
    vneCode = ST
    ; msgbox ST
    }

    ;=================================================================================================================================== get venue course

    RegExMatch(url_venue, "s)<h1>Race.*?</p>", data1)
    RegExMatch(data1, "s)<p>""(?P<course>.*)"" Course, (?P<dist>\d+)", field2_)
    IfInString, field2_, "All Weather Track"
    {
    field2_course := "AWT"
    }

    courseDist .= vneCode "," field2_course "," field2_dist
    IfInString, courseDist, +
    StringReplace, courseDist, courseDist, +, \+

    ; url_tv := "https://sites.google.com/view/shkhoo"

    ; courseDataURL := "https://docs.google.com/spreadsheets/d/1Gy5WU_Debw-RGS2-25qgY1y83Ihk11YLnqpJy8g0Vuw/export?format=csv"
    courseDataURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=846173712&single=true&output=csv"
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    whr.Open("GET", courseDataURL, true)
    whr.Send()
    whr.WaitForResponse()
    courseData := ""
    courseData := whr.ResponseText

    RegExMatch(courseData, "(" courseDist ").*", rc_data)

    ; GuiControl, %guiId%:, tv_data, %rc_data%
    ; if (field2_dist >= 1600 && field2_dist < 1800) 
    ; {
    ; Gui, %guiId%:Font, s16 cff9900
    ; GuiControl, %guiId%:Font, tv_data
    ; }
    ; else if (field2_dist >= 1800) 
    ; {
    ; Gui, %guiId%:Font, s16 cred
    ; GuiControl, %guiId%:Font, tv_data
    ; }

    hkjcData := {}

    hkjcData["hari"] := _ddd
    hkjcData["bln"] := _mmm
    hkjcData["thn"] := _yyy
    hkjcData["vkod"] := vneCode
    hkjcData["course"] := rc_data
    ; hkjcData["errlist"] := errorHorseList
    ; hkjcData["outsider"] := outsiderData2
    ; hkjcData["speedlist"] := hseSpeedList
    ; hkjcData["errlist"] := errorHorseList
    ; hkjcData["errlist"] := errorHorseList
    ; hkjcData["errlist"] := errorHorseList
    return hkjcData
}


;=================================================================================================================================== func get outsider

getOutsiders(rcParam) {

; outsider_url := "https://docs.google.com/spreadsheets/d/1Gy5WU_Debw-RGS2-25qgY1y83Ihk11YLnqpJy8g0Vuw/export?format=csv&gid=349905629"
outsider_url := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=694473226&single=true&output=csv"
outsiderListURL := outsider_url

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", outsiderListURL, true)
whr.Send()
whr.WaitForResponse()
outsiderList := ""
outsiderList := whr.ResponseText

RegExMatch(outsiderList, "r(" rcParam ")(.*)", outsiderData)
StringReplace, outsiderData2, outsiderData2, `,, 
; msgbox % outsiderData2
; GuiControl, %guiId%:, outsidetextbar, %outsiderData2%
return outsiderData2
}

;=================================================================================================================================== func get horse speed

getHsSpeed(rcParam) {

testurl01 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1645195912&single=true&output=csv"
testurl02 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1400065573&single=true&output=csv"
testurl03 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=2078346578&single=true&output=csv"
testurl04 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=693120304&single=true&output=csv"
testurl05 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1918743492&single=true&output=csv"
testurl06 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=729273759&single=true&output=csv"
testurl07 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1190431245&single=true&output=csv"
testurl08 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=2119382615&single=true&output=csv"
testurl09 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1139690273&single=true&output=csv"
testurl010 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=112767216&single=true&output=csv"
testurl011 := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=1672319615&single=true&output=csv"

hseSpeedURL := "testurl0" . rcParam
; msgbox % hseSpeedURL

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", %hseSpeedURL%, true)
whr.Send()
whr.WaitForResponse()
hseSpeedList := ""
hseSpeedList := whr.ResponseText

return hseSpeedList
}

;=================================================================================================================================== get errhorse

getHsErrList(rcParam) {

errorHorseListURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=0&single=true&output=csv"
; errorHorseListURL := "https://docs.google.com/spreadsheets/d/1gCXp8InLhB85mRZZiaLvKLytYAgW8ZmAgHMKzoYBOYU/export?format=csv"
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", errorHorseListURL, true)
whr.Send()
whr.WaitForResponse()
errorHorseList := ""
errorHorseList := whr.ResponseText

return errorHorseList
}

;=================================================================================================================================== getHsNumAndGateAndJersey

getHsNumAndGateAndJersey(rcParam) {

   horseNumAndGateAndJersey := {}

   url_get := "https://www.scmp.com/sport/racing/racecard/@"
   StringReplace, url_get, url_get, @ , %rcParam%
   ; msgbox,,, % url_get

   InOutData :=
   WinHttpRequest(url_get, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
   InOutData := RegExReplace(InOutData, "<script>.*DATA>")
   InOutData := RegExReplace(InOutData, "<script>.*DATA>")
   url_venue := 
   url_venue := InOutData

   if (url_venue = "")
      {
      url_venue := URLDownloadToVar(url_get)
   ;  MsgBox,,, % "UrldownloadToVar`n`n" url_venue
      }

    ; msgbox,,url_get, % url_venue

RegExMatch(url_venue, "s)<div class=""race-table"">(.*)<table class=""remarks"">", data2)
FileCreateDir, Jersey

loop, 5
    {
    RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
    StringReplace, data2, data2, % field3_, 

    RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
    StringReplace, data2, data2, % field4_,

    RegExMatch(data2, "s)<td align=""center"">(?P<gate>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)
    StringReplace, data2, data2, % field5_, 
    
    ; msgbox, % field3_hseNum " " field4_hsCode

    if (field3_hsenum > 0)
        {            
        ; msgbox,,field3_hsenum, % field3_hseNum " " field4_hsCode
        ; URLDownloadToFile, https://racing.hkjc.com/racing/content/Images/RaceColor/%field4_hsCode%.gif, %A_ScriptDir%\jersey\jersey%field4_hsCode%.gif

        horseNumAndGateAndJersey[field3_hsenum] := {"gate":field5_gate,"code":field4_hsCode}
        }
        
; MsgBox, ,array all, % horseNumAndGateAndJersey
MsgBox, ,array gate, % a_index "`t" horseNumAndGateAndJersey[A_Index].gate "`t" horseNumAndGateAndJersey[A_Index].code
    }
; MsgBox, ,array gate, % horseNumAndGateAndJersey[A_Index].gate 
; MsgBox, ,array code, % horseNumAndGateAndJersey[A_Index].code
MsgBox, , return array, Done, .5
return horseNumAndGateAndJersey
}

;=================================================================================================================================== reload

esc::reload

