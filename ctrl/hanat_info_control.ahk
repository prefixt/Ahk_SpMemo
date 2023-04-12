#Include hanat_emo_control.ahk

class HanatInfo {
    ; hanat info
    static name := 'hanat', gender := 'F', favour := 'milk'
    static nickName := ''

    static GetInfo() => Map('name', HanatInfo.name, 'gender', HanaTInfo.gender, 'favour', HanaTInfo.favour)
    static GetEmo() => IniRead('hanat/hanat_info.ini', 'HanatInfo', 'emotion')
    static UpdateInfo() => IniWrite(EmotionControl.emo, 'hanat/hanat_info.ini', 'HanatInfo', 'emotion')

    static ReadInfo(lv) {
        f := FileOpen('hanat/hanat_info.ini', 'r', 'utf-8')
        while (data := f.ReadLine()) != '' {
            if data ~= '^;|\['
                continue
            else {
                item := SubStr(data, 1, InStr(data, '=') - 2)
                startPos := InStr(data, '=') + 1
                detail := SubStr(data, startPos,)
            }
            lv.Add(, item, detail)
        }
        f.Close()
    }
}