#SingleInstance, Force
#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

f1::

FormatTime timestamp, A_Now, yyyy-MM-dd

global tailUrl := "100.100.108.127:8080"


varRc := 1

dataArray := tktDataArray(varRc)

; MsgBox,,dataArray, % dataArray[2 ].80

; for outerKey, innerObject in dataArray
; {
;     MsgBox % "Outer key: " outerKey
;     for innerKey, innerValue in innerObject
;         MsgBox % innerKey " = " innerValue
; }

return

;===================================================================================================================================  

tktDataArray(rcParam) {

; URLb := "http://@/eat"
; StringReplace, URLb, URLb, @, %rcParam%

getserver := "riding168.com"
site_dd_mm_yy := "04-10-2025"
site_venue := "3H"

tktBetArray := {}
tktEatArray := {}

URLb := "https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

      StringReplace, URLb, URLb, * , %getserver%      
      StringReplace, URLb, URLb, @, %site_dd_mm_yy%
      StringReplace, URLb, URLb, # , %site_venue%
      StringReplace, URLb, URLb, $ , %rcParam%

InOutData :=
WinHttpRequest(URLb, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")

bethtml := ""
RegExMatch(InOutData, """pendingData"":""([^""]+)""", betDataMatch)
bethtml := betDataMatch1

URLe := "https://datas.*/eatdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

      StringReplace, URLe, URLe, * , %getserver%      
      StringReplace, URLe, URLe, @, %site_dd_mm_yy%
      StringReplace, URLe, URLe, # , %site_venue%
      StringReplace, URLe, URLe, $ , %rcParam%

InOutData :=
WinHttpRequest(URLe, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")

eathtml := ""
RegExMatch(InOutData, """pendingData"":""([^""]+)""", eatDataMatch)
eathtml := eatDataMatch1


loop, 14
{    
hsenum := A_Index
prc_lmt := 78
Loop, 23
    {
      ww_bet := 0
      Loop,
            {
            RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
            if(s_tkt3 != "")
                {         
                ww_bet += %s_tkt3%    
                StringReplace, bethtml, bethtml, %s_tkt%
                }
            else
                {
                ; msgbox,,, done, .2
                tktBetArray := { (hsenum): { prc_lmt: ww_bet } }
                break   
                }           
            }

            ; tktBetArray[hsenum] := {(prc_lmt):ww_bet}
            ; MsgBox,,arraytest, % hsenum " : " prc_lmt "`n`n" tktBetArray[hsenum].prc_lmt

            ww_eat := 0
            loop
            {
            RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
            if(s_tkt3 != "")
                {         
                ww_eat += %s_tkt3%    
                StringReplace, eathtml, eathtml, %s_tkt%
                }
            else
                {
                ; msgbox,,, done, .2
                tktEatArray := { (hsenum): { prc_lmt: ww_eat } }
                break   
                }           
            }  


            MsgBox,,arraytest, % hsenum " : " prc_lmt "`n`n" tktEatArray[hsenum].prc_lmt




    ; msgbox,,, % hsenum " " prc_lmt
    prc_lmt += 1
    }

}

; loop, 23
; {
; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
;          if(s_tkt3 != "")
;          {
;         msgbox,,, % prc_lmt "`n" s_tkt, 
;          }
; }

; return pendingDataArray
}

;=================================================================================================================================== reload

alt & esc::reload

