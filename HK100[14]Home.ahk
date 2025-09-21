;20250913 1500
;this is a test
;this is the 2nd test
;this is the 3rd test


#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

#SingleInstance
#Include <JSON>
FileRemoveDir, Jersey, 1

SetTitleMatchMode 2
SetFormat, float, 6.1
WinGetActiveTitle, winct
WinGet, active_winct, ID, A

;===================================================================================================================================

tailUrl := "100.100.108.127:8080"

citiKod := "3H"
; citiKod := "172H"

tkt_font := 9
odd_font := 15

combo_num =  ||1|2|3|4|5|6|7|8|9|10|11|12|13|14|

hseOddArray := {}

hse78_array := {}

horse_combobox_set_start_box := 980

color_ready = 0
loopcount = 0

sleepTime := 1000

; Gui Show coord ____________________________________________________________________________

gui_xpos = 0

gui_ypos = -1080

; ____________________________________________________________________________

guiId := 14
total_hs_number = %guiId%

Gui, %guiId%:Color, Black, Black
Gui, %guiId%:Margin, 0, 5

;=================================================================================================================================== Vertical Line 

line_height := 557
Gui, %guiId%:Add, Text, x25 y0 h%line_height% 0x11   ;Vertical Line > Etched Gray
Loop, %total_hs_number%
  {
   Gui, %guiId%:Add, Text, xp+135 yp+0 hp+0 0x11   ;Vertical Line > Etched Gray
  }

;=================================================================================================================================== Horizontal Line 

line_length := 1920
; Gui, %guiId%:Add, Text, x1 y130 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_94
Gui, %guiId%:Add, Text, x1 y218 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_91
Gui, %guiId%:Add, Text, x1 y327 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_86
Gui, %guiId%:Add, Text, x1 y502 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_78

;=================================================================================================================================== prcindex 1

prc_box_width   = 22
prc_box_height  = 18
prc_row_xinit   = 0
prc_row_xpos    = 0
prc_row_yinit   = 0
row_gap = 22

Gui, %guiId%:Font, s11 wbold, Arial
prcindex := 100
Gui, %guiId%:Add, Text, x%prc_row_xinit% y%prc_row_yinit% w%prc_box_width% h%prc_box_height% cwhite +Center, %prcindex%
cntprc = 1
Loop, 22
    {
    prcindex -= 1
    cntprc += 1
    Gui, %guiId%:Add, Text, xp%prc_row_xpos% yp%row_gap% w%prc_box_width% h%prc_box_height% cwhite +Center, %prcindex%
    }    
    
;=================================================================================================================================== Tkt Show Box

tkt_box_width  = 43     ; main width
tkt_box_height = 18     ; main height

tktww_xpos     = +27     ; position for first ww xpos
tktww_ypos     = -484    ; position for first ww ypos

next_xpos      = +135    ; x position for next column
next_ypos      = -484    ; x position for next column

col_gap = +0      ; x spacing between column box
row_gap = +22     ; y spacing between each row

;=================================================================================================================================== Column ww

Gui, %guiId%:Font, s%tkt_font% wbold, Arial

box_cntt = 0
loop, %total_hs_number%
   {
   box_cntt += 1
   cntedit = 100
   if (box_cntt = 1)
      {
      Gui, %guiId%:Add, Edit, xp%tktww_xpos% yp%tktww_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   else
      {
      Gui, %guiId%:Add, Edit, xp%next_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   }

;=================================================================================================================================== Column wp

tktwp_xpos     = -1710   ; position for first wp xpos

box_cntt = 0
loop, %total_hs_number%
   {
   box_cntt += 1
   cntedit = 100
   if (box_cntt = 1)
      {
      Gui, %guiId%:Add, Edit, xp%tktwp_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   else
      {
      Gui, %guiId%:Add, Edit, xp%next_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   }

;=================================================================================================================================== Column pp

tktpp_xpos     = -1710   ; position for first pp xpos

box_cntt = 0
loop, %total_hs_number%
   {
   box_cntt += 1
   cntedit = 100
   if (box_cntt = 1)
      {
      Gui, %guiId%:Add, Edit, xp%tktpp_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   else
      {
      Gui, %guiId%:Add, Edit, xp%next_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   }

;=================================================================================================================================== oddbox

box_width = 30
box_height = 25 

row_xinit = -1840
row_yinit = +33
row_xpos  = %next_xpos%
row_ypos  = +0

Gui, %guiId%:Font, s%odd_font%
cntt = 1
Gui, %guiId%:Add, Edit, xp%row_xinit% yp%row_yinit% w%box_width% h%box_height% v%cntt%oddbox cwhite +Center -E0x200 -VScroll, 
Loop, 13
   {
    cntt += 1
    Gui, %guiId%:Add, Edit, xp%row_xpos% yp%row_ypos% wp+0 hp+0 v%cntt%oddbox cwhite +Center -E0x200 -VScroll, 
   }

;=================================================================================================================================== Horse Number

horse_number_box_width = 60
horse_number_row_xinit = -1720
horse_number_row_yinit = -12
horse_number_row_xpos  = %next_xpos%
horse_number_row_ypos  = +0

Gui, %guiId%:Font, s25 wbold, Arial
cntt = 1
Gui, %guiId%:Add, ComboBox, xp%horse_number_row_xinit% yp%horse_number_row_yinit% w%horse_number_box_width% v%cntt%horse_number +Center, %combo_num%
Loop, 13
   {
    cntt += 1
    Gui, %guiId%:Add, ComboBox, xp%horse_number_row_xpos% yp%horse_number_row_ypos% w%horse_number_box_width% v%cntt%horse_number +Center, %combo_num%
   }

;=================================================================================================================================== Horizontal Line 

Gui, %guiId%:Add, Text, x1 y553 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_horse num

;=================================================================================================================================== Add_Del_radio

Gui, %guiId%:Font, s8 wbold, Arial
Gui, %guiId%:Add, Radio, w33 h15 x30 yp+8 vcol_2  gcol_show2 cwhite, 2
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_3  gcol_show3 cwhite, 3
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_4  gcol_show4 cwhite, 4
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_5  gcol_show5 cwhite, 5
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_6  gcol_show6 cwhite, 6
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_7  gcol_show7 cwhite, 7
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_8  gcol_show8 cwhite, 8
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_9  gcol_show9 cwhite, 9
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_10  gcol_show10 cwhite, 10
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_11  gcol_show11 cwhite, 11
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_12  gcol_show12 cwhite, 12
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_13  gcol_show13 cwhite, 13    ;.....not shown if 2 horses
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_14  gcol_show14 cwhite, 14    ;.....not shown if 2 horses

Gui, %guiId%:Add, Edit, cwhite  vsite_odd_venue +Center  w40 h20 xp+50 yp-3, Vne

Gui, %guiId%:Font, s8
Gui, %guiId%:Add, Radio, cwhite vserver1  +Center w70 h15 xp+60 yp+3 checked, 168com
Gui, %guiId%:Add, Radio, cwhite vserver2  +Center w65 hp+0 xp+80 yp+0, 168net
Gui, %guiId%:Add, Radio, cwhite vserver3  +Center w68 hp+0 xp+80 yp+0, kle009
Gui, %guiId%:Add, Radio, cwhite vserver4  +Left w65 hp+0 xp+85 yp+0, lk988
Gui, %guiId%:Add, Radio, cwhite vserver5  +Left w75 hp+0 xp+70 yp+0, ctcom
Gui, %guiId%:Add, Radio, cwhite vserver6  +Left w75 hp+0 xp+70 yp+0, ctnet
Gui, %guiId%:Add, Progress, cred vprogressStatus Backgroundlime Range0-50 w40 hp+0 xp+80 yp+0,  
Gui, %guiId%:Add, Checkbox, cwhite vshowOutsider w80 w100 hp+0 xp+60 yp+0 , Outsider  

Gui, %guiId%:Font, s10 wbold, Arial
Gui, %guiId%:Add, Edit, cwhite  vsite_date +Center  w40 h22 x30 yp+25, 
Gui, %guiId%:Add, Edit, cwhite  vsite_venue +Center  w40 hp+0 xp+50 yp+0, %citiKod%
Gui, %guiId%:Add, Text, cwhite   +Center  w20 hp+0 xp+50 yp+2, Rc
Gui, %guiId%:Add, ComboBox, vsite_race +Center  w40 xp+20 yp-3, %combo_num%

Gui, %guiId%:Add, Radio, cwhite vhk_get_info_radio gget_hk_data +Center w55 hp+0 xp+70 yp+2, Start
Gui, %guiId%:Add, Checkbox, cwhite w80 hp+0 xp+80 yp+0 vselectionAuto  checked, Auto 

Gui, %guiId%:Font, s10 wbold, Arial
Gui, %guiId%:Add, Button, grerun +Center w80 h20 xp+100 yp+0, NewGui
Gui, %guiId%:Add, Button, ge_xit +Center w40 h20 xp+85 yp+0, X

; Gui, %guiId%:Font, s16 wbold, Arial
; Gui, %guiId%:Add, Edit, cyellow  vtv_data +Left  w800 h22 xp+55 yp+0 -E0x200 -VScroll, 
; Gui, %guiId%:Font, s14 wbold, Arial
; Gui, %guiId%:Add, Edit, cyellow  voutsidetextbar +Center  w250 h25 xp+850 yp+0, 


Gui, %guiId%:Font, s14 wbold, Arial
Gui, %guiId%:Add, Edit, cyellow  voutsidetextbar +Center  w250 h25 xp+55 yp+0, 
Gui, %guiId%:Font, s16 wbold, Arial
Gui, %guiId%:Add, Edit, cyellow  vtv_data +Left  w800 h22 xp+260 yp+0 -E0x200 -VScroll, 

;=================================================================================================================================== Horizontal Line 

line_below_navigation := 615
Gui, %guiId%:Add, Text, x1 y%line_below_navigation% w%line_length% 0x10   ;Horizontal Line > Etched Gray below_navigation

;=================================================================================================================================== gate

Gui, %guiId%:Font, s10 wbold, Arial
xx_pos  := 5
yy_pos  := line_below_navigation + 5
xx_next_pos := 82

col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h20 v%col_cntt%br cE9E6E5 +Center -E0x200 -VScroll, Gate_%col_cntt%
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== picture

xx_pos  = 20
yy_pos  := yy_pos + 25
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Picture, x%xx_pos% y%yy_pos% w50 h50 v%col_cntt%pic, 
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== issueBox

Gui, %guiId%:Font, s10 wbold, Arial
xx_pos  := 5
yy_pos  := yy_pos + 55
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h18 v%col_cntt%issueBox cblack +Center -E0x200 -VScroll, ???
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== jerseyNum

Gui, %guiId%:Font, s16 wbold, Arial
xx_pos  := 5
yy_pos  := yy_pos + 20
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h20 v%col_cntt%jerseyNum cAqua +Center -E0x200 -VScroll,
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== ttl_tkt

Gui, %guiId%:Font, s10 wbold, Arial
xx_pos  := 5
yy_pos  := yy_pos + 22
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h17 v%col_cntt%ttl_tkt cA9F2A9 +Center -E0x200 -VScroll,
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== rider

Gui, %guiId%:Font, s10
xx_pos  := 5
yy_pos  := yy_pos + 15
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h15 v%col_cntt%rider cwhite +Center -E0x200 -VScroll, 
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== horseSpeed

Gui, %guiId%:Font, s10
xx_pos  := 5
yy_pos  := yy_pos + 17
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 v%col_cntt%speedbox cwhite +Center -E0x200 -VScroll, 
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== green box

; green_box_width = 60
; green_box_row_xinit = -1720
; green_box_row_yinit = -12
; green_box_row_xpos  = %next_xpos%
; green_box_row_ypos  = +0

Gui, %guiId%:Font, s9
xx_pos  = 127
yy_pos  := yy_pos - 255
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w30 h20 v%col_cntt%greenbox clime +Center -E0x200 -VScroll, 
    xx_pos += %next_xpos%
    col_cntt += 1
    }

;=================================================================================================================================== Gui display location

; Gui, %guiId%:+AlwaysOnTop 
; Gui +OwnDialogs 

SysGet, Mon1, Monitor, 1
; MsgBox, Left: %Mon1Left% -- 
; . Top: %Mon1Top% -- 
; .  Right: %Mon1Right% -- 
; . Bottom %Mon1Bottom%.

SysGet, Mon2, Monitor, 2
; MsgBox, Left: %Mon2Left% -- 
; . Top: %Mon2Top% -- 
; .  Right: %Mon2Right% -- 
; . Bottom %Mon2Bottom%.

; SysGet, Mon3, Monitor, 3
; MsgBox, Left: %Mon3Left% -- 
; . Top: %Mon3Top% -- 
; .  Right: %Mon3Right% -- 
; . Bottom %Mon3Bottom%.

gui_height := 800
; gui_height := 900

; if (Mon1Top = -1080 || Mon2Top = -1080)
;    {
;    gui_xpos = 0
;    gui_xpos = -1080
;    }
   
Gui, %guiId%: -Caption
Gui, %guiId%: Show, x%gui_xpos% y%gui_ypos% w1920 h%gui_height%, BlackBoard_%total_hs_number%    ;show 12

return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

col_show2:
WinSet, Region, 0-0 W297 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show3:
WinSet, Region, 0-0 W432 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show4:
WinSet, Region, 0-0 W567 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show5:
WinSet, Region, 0-0 W702 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show6:
WinSet, Region, 0-0 W837 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show7:
WinSet, Region, 0-0 W972 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show8:
WinSet, Region, 0-0 W1107 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show9:
WinSet, Region, 0-0 W1242 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show10:
WinSet, Region, 0-0 W1377 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show11:
WinSet, Region, 0-0 W1512 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show12:
WinSet, Region, 0-0 W1647 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show13:
WinSet, Region, 0-0 W1782 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show14:
WinSet, Region, 0-0 W%line_length% h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

;  xxx   xxx  xxx   xxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx  xxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx xxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxx  xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxx  xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx xxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx  xxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx   xxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

get_hk_data:

Gui, %guiId%:Submit, nohide

;=================================================================================================================================== get source code from SCMP.COM

url_get := "https://www.scmp.com/sport/racing/racecard/@"
StringReplace, url_get, url_get, @ , %site_race%

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

;=================================================================================================================================== get date

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
   GuiControl, %guiId%:, site_date, %_ddd%
   }
else
   {
   _ddd := field1_ddd
   GuiControl, %guiId%:, site_date, %_ddd%
   }

site_dd_mm_yy = %_ddd%-%_mmm%-%_yyy%
odd_yy_mmm_dd = %_yyy%-%_mmm%-%_ddd% 
; msgbox % _ddd " - " _mmm " - " _yyy "`n" site_dd_mm_yy

;=================================================================================================================================== get venue

If(field1_vne = "Happy Valley")
   {
   vneCode = HV
   ; msgbox HV
   GuiControl, %guiId%:, site_odd_venue, %vneCode%
   GuiControl, %guiId%:, tvpos1, %hv_tv%
   }
Else
   {
   vneCode = ST
   ; msgbox ST
   GuiControl, %guiId%:, site_odd_venue, %vneCode%
   GuiControl, %guiId%:, tvpos1, %st_tv%
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

GuiControl, %guiId%:, tv_data, %rc_data%
if (field2_dist >= 1600 && field2_dist < 1800) 
   {
   Gui, %guiId%:Font, s16 cff9900
   GuiControl, %guiId%:Font, tv_data
   }
else if (field2_dist >= 1800) 
   {
   Gui, %guiId%:Font, s16 cred
   GuiControl, %guiId%:Font, tv_data
   }

;=================================================================================================================================== get errhorse

errorHorseListURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=0&single=true&output=csv"
; errorHorseListURL := "https://docs.google.com/spreadsheets/d/1gCXp8InLhB85mRZZiaLvKLytYAgW8ZmAgHMKzoYBOYU/export?format=csv"
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", errorHorseListURL, true)
whr.Send()
whr.WaitForResponse()
errorHorseList := ""
errorHorseList := whr.ResponseText

;=================================================================================================================================== get outsider

; outsider_url := "https://docs.google.com/spreadsheets/d/1Gy5WU_Debw-RGS2-25qgY1y83Ihk11YLnqpJy8g0Vuw/export?format=csv&gid=349905629"
outsider_url := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=694473226&single=true&output=csv"
outsiderListURL := outsider_url

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", outsiderListURL, true)
whr.Send()
whr.WaitForResponse()
outsiderList := ""
outsiderList := whr.ResponseText

RegExMatch(outsiderList, "r(" site_race ")(.*)", outsiderData)
; msgbox % outsiderList "`r`r" outsiderData
StringReplace, outsiderData2, outsiderData2, `,, 
; msgbox % outsiderData2
GuiControl, %guiId%:, outsidetextbar, %outsiderData2%

;=================================================================================================================================== get horse speed

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

if (site_race = 1)
   {
   hseSpeedURL :=  testurl01
   }
else if (site_race = 2)
   {
   hseSpeedURL :=  testurl02
   }
else if (site_race = 3)
   {
   hseSpeedURL :=  testurl03
   }
else if (site_race = 4)
   {
   hseSpeedURL :=  testurl04
   }
else if (site_race = 5)
   {
   hseSpeedURL :=  testurl05
   }
else if (site_race = 6)
   {
   hseSpeedURL :=  testurl06
   }
else if (site_race = 7)
   {
   hseSpeedURL :=  testurl07
   }
else if (site_race = 8)
   {
   hseSpeedURL :=  testurl08
   }
else if (site_race = 9)
   {
   hseSpeedURL :=  testurl09
   }
else if (site_race = 10)
   {
   hseSpeedURL :=  testurl010
   }
else if (site_race = 11)
   {
   hseSpeedURL :=  testurl011
   }

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", hseSpeedURL, true)
whr.Send()
whr.WaitForResponse()
hseSpeedList := ""
hseSpeedList := whr.ResponseText

;=================================================================================================================================== get jersey

RegExMatch(url_venue, "s)<div class=""race-table"">(.*)<table class=""remarks"">", data2)
FileCreateDir, Jersey

loop, %total_hs_number%
      {
      RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
      StringReplace, data2, data2, % field3_, 

      RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
      StringReplace, data2, data2, % field4_, 
      if (field3_hsenum > 0)
         {
         URLDownloadToFile, https://racing.hkjc.com/racing/content/Images/RaceColor/%field4_hsCode%.gif, %A_ScriptDir%\jersey\jersey%field4_hsCode%.gif

         RegExMatch(data2, "s)<td align=""center"">(?P<br>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)
         StringReplace, data2, data2, % field5_, 

         ; field3_ = horse number value
         ; field4_ = horse code number
         ; field5_ = rider
         ; MsgBox, , Show field, % "field3 (horse number value) = " field3_hsenum "`n`nfield4 (horse code number) = " field4_ "`n`nfield5 (rider) = " field5_ ,

         GuiControl, %guiId%:, %field5_br%pic, %A_ScriptDir%\jersey\jersey%field4_hsCode%.gif
         GuiControl, %guiId%:, %field5_br%horse_number, %field3_hsenum%
         GuiControl, %guiId%:, %field5_br%jerseyNum, %field3_hsenum%

         RegExMatch(errorHorseList, "s)(" field4_hsCode ")", hseErrorFound_)
         if (hseErrorFound_1 != "")
            {
            Gui, %guiId%:Font, s10 cred
            GuiControl, %guiId%:Font, %field5_br%issueBox
            }
         ;    {
         ;    GuiControl, %guiId%: Show, %field5_br%issueBox
         ;    }
         ; else
         ;    {
         ;    GuiControl, %guiId%: Hide, %field5_br%issueBox 
         ;    }
         }

      RegExMatch(data2, "s)<a href=""/sport/racing/stats/jockey/\d+/(?P<rider>.*?)<", field5_)
      StringReplace, data2, data2, % field5_, 
      StringSplit, namefield, field5_rider, "
      GuiControl, %guiId%:, %field5_br%rider, %namefield1%

      list_2 := ""
      ; RegExMatch(hseSpeedList, "(" field3_hsenum "),(.*)", list_)
      RegExMatch(hseSpeedList, "(" field3_hsenum ")`,(\w\d+)`,(\w+)", list_)   ;................................ammend hcode column
      ; msgbox,,, %list_1%   %list_2%   %list_3%                               ;........................change list_2 to list_3
      if (field3_hsenum != "")
         {
         ; msgbox % list_1 "`r" list_2
         GuiControl, %guiId%:, %field5_br%speedbox, %list_3%
         if (list_3 = "L1")
            {
            Gui, %guiId%:Font, s10 c00ff00
            GuiControl, %guiId%:Font, %field5_br%speedbox
            }
         else if (list_3 = "L2")
            {
            Gui, %guiId%:Font, s10 c00ff00
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if (list_3 = "L3")
            {
            Gui, %guiId%:Font, s10 c00ff00
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if list_3 contains Normal
            {
            Gui, %guiId%:Font, s10 cffff00
            GuiControl, %guiId%:Font, %field5_br%speedbox
            }   
         else if (list_3 = "Slow")
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %field5_br%speedbox
            }   
         else if (list_3 = "Slow_1") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %field5_br%speedbox
            }   
         else if (list_3 = "Slow_2") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %field5_br%speedbox
            }   
         else if (list_3 = "Slow_3") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if (list_3 = "V_Slow") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if (list_3 = "New") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if (list_3 = "New_X") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if (list_3 = "New_1") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         else if (list_3 = "New_2") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %field5_br%speedbox
            } 
         }

      }

;===================================================================================================================================

goto, get_citi_data
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

get_citi_data:
Gui, %guiId%:Submit, nohide

hari := _ddd
bulan := _mmm
tahun := _yyy
kod := vneCode
larian := site_race

;=================================================================================================================================== get_odd from HKJC

get_odd:

; URL for the request (replace with your actual API endpoint)
url := "https://info.cld.hkjc.com/graphql/base/"

; Create the COM Object for XMLHTTP
http := ComObjCreate("MSXML2.XMLHTTP")

; GraphQL query and variables payload
payload := "{" 
payload .= """operationName"": ""racing"","
payload .= """variables"": {"
payload .= """date"": """ tahun "-" bulan "-" hari ""","
payload .= """venueCode"": """ kod ""","
payload .= """raceNo"": " larian ","
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
   ; MsgBox, Horse 1 combString: %firstHorseCombString%`nOdds Value: %firstHorseOddsValue%
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

;=================================================================================================================================== select server 

if (server1 = 1)
   {
   getserver := "riding168.com"
   }
else if (server2 = 1)
   {
   getserver := "riding168.net"
   }
else if (server3 = 1)
   {
   getserver := "kle009.com"
   }
else if (server4 = 1)
   {
   getserver := "lk988.net"
   }
else if (server5 = 1)
   {
   getserver := "citibet.com"
   }
else if (server6 = 1)
   {
   getserver := "citibet.net"
   }

; URLb := "http://@/bet"
; StringReplace, URLb, URLb, @, %tailUrl%

URLb := "https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

      StringReplace, URLb, URLb, * , %getserver%
      ; StringReplace, url_get, url_get, ~ , %A_YYYY%
      ; StringReplace, url_get, url_get, ! , %A_MM%
      ; StringReplace, url_get, url_get, @, %site_date%
      
      StringReplace, URLb, URLb, @, %site_dd_mm_yy%
      StringReplace, URLb, URLb, # , %site_venue%
      StringReplace, URLb, URLb, $ , %site_race%

; MsgBox % URLb

InOutData :=
WinHttpRequest(URLb, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")
bethtml := 
bethtml := InOutData  
; MsgBox % bethtml

;=================================================================================================================================== get horse count

hseCntt = 0
combox_num := horse_combobox_set_start_box

loop, %total_hs_number%
   {
   if (%A_Index%jerseyNum > 0)
      {
      Gate_get := %A_Index%br 
      StringReplace, Gate_get, Gate_get, Gate_, 
      barrier_array%A_Index% := Gate_get
      horse_array%A_Index% := %A_Index%jerseyNum   
      hseCntt++
      ; msgbox % barrier_array%A_Index% " - " horse_array%A_Index%
      }
   }

;=================================================================================================================================== show total bet tkt

loop, % hseCntt
	{
	hse_num := horse_array%A_Index%	
	barrier_num := barrier_array%A_Index%	
	; MsgBox,,Line 9xx, % "gate_num = " gate_num "`nhse_num = " hse_num 

;=================================================================================================================================== ww tkt
	
		ww_bet := 0
		Loop,
			{
			; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d+)\\t(0)\\t(\d+|\d+.\d+)\\t([!]*\d+[.]*[\d]*\/0)", s_tkt)
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([0])", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d|\d+)\\t([^1-9])", s_tkt)
			if(s_tkt != "")
				{       
				ww_bet += %s_tkt3% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			}

;=================================================================================================================================== wp tkt
	
		wp_bet := 0
		Loop,
			{
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d+)\\t(\d+)\\t(\d+|\d+.\d+)\\t(.\d+\/\d+)", s_tkt)
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([^0]\d+)", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([^0]\d+)", s_tkt)
			if(s_tkt != "")
				{
				wp_bet += %s_tkt3% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			} 

;=================================================================================================================================== pp tkt
	
		pp_bet := 0
		Loop,
			{	
		   ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(0)\\t(\d+)\\t(\d+|\d+.\d+)\\t([!]*0\/\d+)", s_tkt)
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([0])\\t([^0]\d+)", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^1-9])\\t([^0]\d+)", s_tkt)
			if(s_tkt != "")
				{         
				pp_bet += %s_tkt4% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			}
         
;===================================================================================================================================
	
	ttltkt := 0
	ttltkt := ww_bet + wp_bet + pp_bet

	if (ttltkt >= 500000)
		{
		Gui, %guiId%:Font, s10 cff0000
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else if (ttltkt < 500000  && ttltkt >= 200000 )
		{
		Gui, %guiId%:Font, s10 cFFC300
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else if (ttltkt < 200000  && ttltkt >= 100000 )
		{
		Gui, %guiId%:Font, s10 cA9F2A9
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else if (ttltkt < 100000  && ttltkt >= 1 )
		{
		Gui, %guiId%:Font, s10 csilver
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else
		{
		GuiControl, %guiId%:, %barrier_num%ttl_tkt,
      hse78_array.push(hse_num)
		} 
	}

if (selectionAuto = 1)
   {
   ; msgbox  selectionAuto = 0
   Control, Uncheck ,, Button22, BlackBoard_%showHorseCount%

   ; fill remaining horse number box without any bet ticket
   ; if (showOutsider = 1)
   ;    {
   ;    ; msgbox,,outsider value, % showOutsider 
   ;    Loop % hse78_array.Length()
   ;       {
   ;       combox_num +=1
   ;       combobox_fill := hse78_array[A_Index]
   ;       ; MsgBox % "combox_num : " combox_num  "`nhse78_array[A_Index] : " hse78_array[A_Index]
   ;       ControlSetText, Edit%combox_num%, %combobox_fill%, BlackBoard_%horse_show_tkt_box%
   ;       }
   ;    }
   }

goto, loop_server_data
return

;===================================================================================================================================
;===================================================================================================================================
;===================================================================================================================================

loop_server_data:

Gui, %guiId%:Submit, nohide

;===================================================================================================================================

; URLb := "http://@/bet"
; StringReplace, URLb, URLb, @, %tailUrl%


URLb :="https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"
      StringReplace, URLb, URLb, * , %getserver%
      ; StringReplace, URLb, URLb, @ , %site_date%
      ; StringReplace, URLb, URLb, ~ , %A_MM%
      ; StringReplace, URLb, URLb, ! , %A_YYYY%
      StringReplace, URLb, URLb, @, %site_dd_mm_yy%
      StringReplace, URLb, URLb, # , %site_venue%
      StringReplace, URLb, URLb, $ , %site_race%

; URLe := "http://@/eat"
; StringReplace, URLe, URLe, @, %tailUrl%


URLe :="https://datas.*/edata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"
      StringReplace, URLe, URLe, * , %getserver%
      ; StringReplace, URLe, URLe, @ , %site_date%
      ; StringReplace, URLe, URLe, ~ , %A_MM%
      ; StringReplace, URLe, URLe, ! , %A_YYYY%
      StringReplace, URLe, URLe, @, %site_dd_mm_yy%
      StringReplace, URLe, URLe, # , %site_venue%
      StringReplace, URLe, URLe, $ , %site_race%

;===================================================================================================================================

bethtml :=
WinHttpRequest(URLb, bethtml := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")

eathtml :=
WinHttpRequest(URLe, eathtml := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")

; msgbox,,bethtml, % URLb "`n`n" bethtml,.5
; msgbox,,eathtml, % URLe "`n`n" eathtml,.5

;===================================================================================================================================

IfNotInString, eathtml, 90
    {
    loopcount ++     
    if (loopcount > 150)            ;tukar pusing
      {
      ; ElapsedTime := A_TickCount - StartTime
      ; GuiControl, %guiId%:, timer_box, %ElapsedTime%
      ; MsgBox,  %ElapsedTime% milliseconds have elapsed.
      ; Gui, %guiId%:Color, 132279, 132279
      ; MsgBox, Racing!!! `n`nReload?
      ; Reload 

      GuiControl, %guiId%:, progressStatus, 100  
      }
    else
      {
      Goto, loop_server_data
      loopcount = 0
      }
    } 

;=================================================================================================================================== show tkt range
;===================================================================================================================================
;===================================================================================================================================

Gui, %guiId%:Submit, nohide

;=================================================================================================================================== get runner

combox_num := horse_combobox_set_start_box
selected_runner :=
Loop, %total_hs_number%
   {
   combox_num ++
   hseComboboxValue := 
   ControlGetText, hseComboboxValue, Edit%combox_num%,  BlackBoard_%total_hs_number%
   ; msgbox % hseComboboxValue
	if(hseComboboxValue > 0)
      {
      selected_runner += 1
      horse_array%selected_runner% := hseComboboxValue
      GuiControl, %guiId%:, %A_Index%oddbox, % hseOddArray[ hseComboboxValue ]
      if (hseOddArray[ hseComboboxValue ] <= 5)
         {
         Gui, %guiId%:Font, s%odd_font% cred
         GuiControl, %guiId%:Font, %A_Index%oddbox
         }
      Else
         {
         Gui, %guiId%:Font, s%odd_font% cwhite
         GuiControl, %guiId%:Font, %A_Index%oddbox
         }
      }
	; if(%A_Index%horse_number > 0)
   ;     {
   ;      selected_runner += 1
   ;      horse_array%selected_runner% := %A_Index%horse_number
   ;     }
   }

; show total number of combo_box with value 
; msgbox,,selected_runner, % selected_runner, 3 

;=================================================================================================================================== show tkt

Loop, %selected_runner%
   {
   hsenum := horse_array%A_Index%
   box_row := A_Index

;=================================================================================================================================== ww tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      ww_bet := 0
      Loop,
         {
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([0])\\t(" prc_lmt ")", s_tkt)
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
         
      ww_eat := 0
      Loop,
         {
         ; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([0])\\t(" prc_lmt ")", s_tkt)
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
         
         if(ww_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, %ww_bet% 
            if (ww_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%             
               }
            }
         else if(ww_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, %ww_eat%  
            if (ww_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%     
               ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               if (prc_lmt = 87)
                  {
                  Gui, %guiId%:Font, s%tkt_font% cwhite
                  GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%   
                  }                   
               }  
            }
         else
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%,
            }
         prc_lmt += 1
      } 

;=================================================================================================================================== wp tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      wp_bet := 0
      Loop,
         {
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {
            wp_bet += %s_tkt3%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      wp_eat := 0
      Loop,
         {
         ; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
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
         
         if(wp_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, %wp_bet%  
            if (wp_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%
               GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%             
               }
            }
         else if(wp_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, %wp_eat%  
            if (wp_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%  
               ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               if (prc_lmt = 87)
                  {
                  Gui, %guiId%:Font, s%tkt_font% cwhite
                  GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%   
                  }                     
               }
            } 
         else
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%,
            }
         prc_lmt += 1
      }    

;=================================================================================================================================== pp tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      pp_bet := 0
      Loop,
         {
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([0])\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt4 != "")
            {         
            pp_bet += %s_tkt4%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      pp_eat := 0
      Loop,
         {
         ; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([0])\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt4 != "")
            {         
            pp_eat += %s_tkt4%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(pp_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, %pp_bet% 
            if (pp_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%             
               }
            }
         else if(pp_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, %pp_eat% 
            if (pp_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%
               ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               if (prc_lmt = 87)
                  {
                  Gui, %guiId%:Font, s%tkt_font% cwhite
                  GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%   
                  }                  
               }
            } 
         else
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%,
            }
         prc_lmt += 1
      }

;===================================================================================================================================  end

   }
sleep, %sleepTime%
Goto, get_citi_data
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

`::     ;tilde key - start hypercam recording
send, {NumpadMult}
return

;===================================================================================================================================

1::     ;tab key - change color for barrier open
; NumpadSub::
if (color_ready = 0)
   {
   Gui, %guiId%:Color, 0A2B45, 0A2B45
   color_ready = 1
   }
else
   { 
   Gui, %guiId%:Color, Black, Black
   color_ready = 0
   }
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Pause::
Pause
return

rerun:
Reload
return

99GuiClose:
e_xit:
FileRemoveDir, Jersey, 1
ExitApp
return

PrintScreen::
Gui, %guiId%: Show, x0 y0 w1920, BlackBoard_%total_hs_number%
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

RButton::Send,{Click,Right}
RButton & LButton::
;!LButton::

CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; Only if the window isn't maximized 
    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
    SetTimer, EWD_WatchMouse, off
    return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is Destroyled.
{
    SetTimer, EWD_WatchMouse, off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
    return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

URLDownloadToVar(url){
	obj:=ComObjCreate("WinHttp.WinHttpRequest.5.1"),obj.Open("GET",url),obj.Send()
	return obj.status=200?obj.ResponseText:""
}

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
