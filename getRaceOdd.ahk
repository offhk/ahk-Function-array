#SingleInstance, Force
#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

f1::

FormatTime timestamp, A_Now, yyyy-MM-dd

global varRc := 1
global tahun := 2025
global bulan := 10
global hari := 04
global kod := "ST"

oddData := getRaceOdd(varRc,tahun,bulan,hari,kod)

; msgbox,,, % oddData.1

show :=
for k, v in oddData
    {
    ; msgbox, % k " : " v
    show .= k " : " v "`n"
    }

msgbox ,,show, % show

return

;=================================================================================================================================== reload

getRaceOdd(rcParam,thnParam,blnParam,hariParam,kodParam) {

hseOddArray := {}

; URL for the request (replace with your actual API endpoint)
url := "https://info.cld.hkjc.com/graphql/base/"

; Create the COM Object for XMLHTTP
http := ComObjCreate("MSXML2.XMLHTTP")

; GraphQL query and variables payload
payload := "{" 
payload .= """operationName"": ""racing"","
payload .= """variables"": {"
payload .= """date"": """ thnParam "-" blnParam "-" hariParam ""","
payload .= """venueCode"": """ kodParam ""","
payload .= """raceNo"": " rcParam ","
payload .= """oddsTypes"": [""WIN"", ""PLA""]"
payload .= "},"
payload .= """query"": ""query racing($date: String, $venueCode: String, $oddsTypes: [OddsType], $raceNo: Int) {"
payload .= "  raceMeetings(date: $date, venueCode: $venueCode) {"
payload .= "    pmPools(oddsTypes: $oddsTypes, raceNo: $raceNo) {"
payload .= "      id"
payload .= "      status"
payload .= "      sellStatus"
payload .= "      oddsType"
payload .= "      lastUpdateTime"
payload .= "      guarantee"
payload .= "      minTicketCost"
payload .= "      name_en"
payload .= "      name_ch"
payload .= "      leg {"
payload .= "        number"
payload .= "        races"
payload .= "      }"
payload .= "      cWinSelections {"
payload .= "        composite"
payload .= "        name_ch"
payload .= "        name_en"
payload .= "        starters"
payload .= "      }"
payload .= "      oddsNodes {"
payload .= "        combString"
payload .= "        oddsValue"
payload .= "        hotFavourite"
payload .= "        oddsDropValue"
payload .= "        bankerOdds {"
payload .= "          combString"
payload .= "          oddsValue"
payload .= "        }"
payload .= "      }"
payload .= "    }"
payload .= "  }"
payload .= "}"""
payload .= "}"

; msgbox,,Payload, % payload,

; Open the POST request
http.Open("POST", url, false)

; Set the request headers
http.SetRequestHeader("Content-Type", "application/json")

; Send the POST request with the payload
http.Send(payload)

; Get the response text (JSON)
response := http.ResponseText

; Display the response in a message box
; msgbox % "Response from the server:`n" response

; FileAppend, %response%, %A_ScriptDir%\httpPostData_%A_MM%%A_DD%.json

; Parse JSON data
parsedJSON := JSON.Load(response)  

loop, 14
   {
   ; Accessing values
   raceMeeting := parsedJson.data.raceMeetings[1]  ; Access the first race meeting
   pmPools := raceMeeting.pmPools[2]  ; Access the first pmPool of that meeting

   ; Accessing odds for specific horses
   firstHorseCombString := pmPools.oddsNodes[A_Index].combString
   firstHorseOddsValue := pmPools.oddsNodes[A_Index].oddsValue
   ; firstHorseHotFavourite := pmPools.oddsNodes[1].hotFavourite

   ; Output the results
   ; MsgBox, Horse 1 combString: %firstHorseCombString%`nOdds Value: %firstHorseOddsValue%`nHot Favourite: %firstHorseHotFavourite%
;    MsgBox, Horse 1 combString: %firstHorseCombString%`nOdds Value: %firstHorseOddsValue%
   hseOddArray[firstHorseCombString] := firstHorseOddsValue
   }


; Access raceMeetings
; raceMeetings := parsedJSON["data"]["raceMeetings"]

; ; Loop through raceMeetings and filter "WIN"
; for _, raceMeeting in raceMeetings
; {
;     pmPools := raceMeeting["pmPools"]
;     for _, pool in pmPools
;     {
;         ; Correctly access the oddsType
;         if (pool["oddsType"] = "WIN")
;         {
;             data := pool["oddsType"]
;             MsgBox, 64, WIN Pool,  %data%
;         }
;     }
; }

; rcNumbor := site_race
; kuda :=

; Loop, 14 ; Loop 14 times
;    {
;    ; Access data inside the loop
;    raceMeetings := parsedJSON["data"]["raceMeetings"]
;    firstPool := raceMeetings[rcNumbor]["pmPools"][2]
;    firstOdds := firstPool["oddsNodes"][A_index]["oddsValue"]

;    ; Display the odds for the first horse in the first pool
;    MsgBox, 64, Loop Iteration %A_Index%, Iteration: %A_Index%`nFirst Odds Value: %firstOdds%
;    hseOddArray[A_Index] := firstOdds
;    }

; url_get := "https://bet2.hkjc.com/racing/getJSON.aspx?type=winplaodds&date=@&venue=#&start=$&end=$"
; ; StringReplace, url_get, url_get, ~ , %A_YYYY%
; ; StringReplace, url_get, url_get, ! , %A_MM%
; ; StringReplace, url_get, url_get, @, %site_date%

; StringReplace, url_get, url_get, @, %odd_yy_mmm_dd%
; StringReplace, url_get, url_get, #, %site_odd_venue%, All
; StringReplace, url_get, url_get, $, %site_race%, All
; ; msgbox % url_get

; InOutData :=
; WinHttpRequest(url_get, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
; RegExMatch(InOutData, "s)WIN;(.*)#PLA", url_data)
; ; msgbox % url_data1
; StringSplit, url_data1, url_data1, `;
; loop, %total_hs_number%
;     {
;     StringSplit, odd_data, url_data1%A_Index%, `=
;     hseOddArray[odd_data1] := odd_data2
;    ;  msgbox,,url_get, % odd_data1 " "  odd_data2 " "  odd_data3
;     }

; ; For index, value in hseOddArray
; ;    {
; ;    MsgBox % "index : " index ", value : " value 
; ;    }
return hseOddArray
}

;=================================================================================================================================== reload

alt & esc::reload

