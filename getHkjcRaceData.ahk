#SingleInstance, Force
#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

f1::

FormatTime timestamp, A_Now, yyyy-MM-dd

global varRc := 1


hkData := getHkData(varRc)

; msgbox, % hkData.bln

show :=
for k, v in hkdata
    {
    ; msgbox, % k " : " v
    show .= k " : " v "`n"
    }

msgbox ,,show, % hkData.hari
. "`n" hkData.bln
. "`n" hkData.thn
. "`n" hkData.vneKod
. "`n" hkData.race
. "`n" hkData.distance
. "`n" hkData.course



return

;===================================================================================================================================  

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

    hkjcData := {}

    hkjcData["hari"] := _ddd
    hkjcData["bln"] := _mmm
    hkjcData["thn"] := _yyy
    hkjcData["vnekod"] := vneCode
    hkjcData["race"] := rcParam
    hkjcData["course"] := field2_course
    hkjcData["distance"] := field2_dist
    return hkjcData
}

;=================================================================================================================================== reload

alt & esc::reload

