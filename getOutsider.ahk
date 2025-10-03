#SingleInstance, Force
#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

f1::

FormatTime timestamp, A_Now, yyyy-MM-dd

global varRc := 1

outSiders := getOutsiders(varRc)

msgbox ,,outSiders, % outSiders


return

;===================================================================================================================================  

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

;=================================================================================================================================== reload

alt & esc::reload

