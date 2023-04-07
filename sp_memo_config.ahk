#Requires AutoHotkey v2.0
#SingleInstance Force

TraySetIcon('resource\sp_memo.ico')

ReadCfg() {
    theme := IniRead('config.ini', 'Theme', 'theme')
    font_size := IniRead('config.ini', 'Font', 'font_size')
    font_name := IniRead('config.ini', 'Font', 'font_name')
    clientX := IniRead('config.ini', 'Coordinate', 'clientX')
    clientY := IniRead('Config.ini', 'Coordinate', 'clientY')
    return [theme, font_size, font_name, clientX, clientY]
}

WriteCfg(data, section, key) => IniWrite(data, 'Config.ini', section, key)

; f := FileOpen('config.txt', 'r', 'utf-8')
; theme := font_size := font_name := ''
; while (data := f.ReadLine()) != '' {
;     if data ~= '^#|-' ; skip blank line and comment
;         continue
;     if data ~= 'theme'
;         theme := SubStr(data, InStr(data, ':') + 2,)
;     if data ~= 'font_size'
;         font_size := SubStr(data, InStr(data, ':') + 2,)
;     if data ~= 'font_name'
;         font_name := SubStr(data, InStr(data, ':') + 2,)
; }
; f.Close()
