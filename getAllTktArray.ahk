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

myarray := {}  ; initialize main object

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
myarray[(hsenum)] := {}  ; nested object at varNum key
prc_lmt := 78
Loop, 23
    {
    myarray[(hsenum)][(prc_lmt)] := {}  ; nested object at varPrc key
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
            break   
            }           
        }  


            ; MsgBox,,arraytest, % hsenum " : " prc_lmt "`n`n" tktEatArrayWW[hsenum].prc_lmt



;....................................................................................................................................


    wp_bet := 0
    Loop,
        {

        RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
        if(s_tkt3 != "")
            {         
            wp_bet  += %s_tkt3%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
        else
            {
            break   
            }           
        }

        ; tktBetArray[hsenum] := {(prc_lmt):wp_bet }
        ; MsgBox,,arraytest, % hsenum " : " prc_lmt "`n`n" tktBetArray[hsenum].prc_lmt

        wp_eat := 0
        loop
        {
        RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
        if(s_tkt3 != "")
            {         
            wp_eat += %s_tkt3%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
        else
            {
            break   
            }           
        } 



;....................................................................................................................................


        pp_bet := 0
        Loop,
            {

            RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
            if(s_tkt3 != "")
                {         
                pp_bet  += %s_tkt4%    
                StringReplace, bethtml, bethtml, %s_tkt%
                }
            else
                {
                break   
                }           
            }

            ; tktBetArray[hsenum] := {(prc_lmt):pp_bet }
            ; MsgBox,,arraytest, % hsenum " : " prc_lmt "`n`n" tktBetArray[hsenum].prc_lmt

            pp_eat := 0
            loop
            {
            RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
            if(s_tkt3 != "")
                {         
                pp_eat += %s_tkt4%    
                StringReplace, eathtml, eathtml, %s_tkt%
                }
            else
                {
                break   
                }           
            } 

;....................................................................................................................................

    myarray[(hsenum)][(prc_lmt)].bet := {"ww": [ww_bet],"wp": [wp_bet],"pp": [pp_bet]}

    myarray[(hsenum)][(prc_lmt)].eat := {"ww": [ww_eat],"wp": [wp_eat],"pp": [pp_eat]}

    ; msgbox,,, % hsenum " " prc_lmt
    prc_lmt += 1
    }

}



for key1, val1 in myarray
{
    for key2, val2 in val1
    {
        for key3, val3 in val2
        {
            ; val3 is an object with keys "ww", "wp", etc.
            for subkey, subval in val3
            {
                ; subval is an array containing one element each
                MsgBox % "myarray[" key1 "][" key2 "][" key3 "][" subkey "] = " subval[1]
            }
        }
    }
}



return myarray
}

;=================================================================================================================================== reload

alt & esc::reload

