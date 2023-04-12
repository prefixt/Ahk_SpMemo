#Include ui_pop_win.ahk
class ExitGui extends PopUpWindow {
    __New(W) {
        super.__New(, 150)
        this.superW := W
        this.AddPicture('xm w50 h70', 'resource/exit_.png') ; 'resource/exit_pic.png'
        this.AddText('yp+30 xp+60 c' this.currTheme.default_Fc, 'Exit SpMemo?')
        this.AddButton('xm -Theme', 'Yes').OnEvent('Click', 'Exit')
        this.AddButton('xp+140 -Theme', 'No').OnEvent('Click', (*) => this.Destroy())
    }

    Exit(*) {
        this.Destroy()
        this.superW.GetClientPos(, , , &ch)
        while ch > 0 {
            this.superW.Move(, , , ch--)
        }
        this.superW.GetClientPos(&cx, &cy, ,)
        WriteCfg(cx, 'Coordinate', 'clientX')
        WriteCfg(cy, 'Coordinate', 'clientY')
        ExitApp
    }
}

if A_ScriptFullPath = A_LineFile {
    ExitGui.Show()
}