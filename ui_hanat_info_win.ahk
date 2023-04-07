#Include ui_pop_win.ahk
#Include hanat_info_control.ahk
class HanatInfoGui extends PopUpWindow {
    __New() {
        super.__New('Info', 470, ['Item         ', 'Detail'], 'vHanatInfo w500 h400 -Multi')
        HanatInfo.ReadInfo(this['HanatInfo'])
        this['CloseBtn'].OnEvent('Click', (*) => this.Destroy())
        this.AddButton('xm w70 -Theme', 'Open').OnEvent('Click','OpenInfo')
    }

    OpenInfo(*){
        Run('hanat_info.txt')
    }
}

if A_ScriptFullPath = A_LineFile {
    HanatInfoGui.Show()

}