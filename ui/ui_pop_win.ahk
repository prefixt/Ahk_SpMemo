#Include ui_base.ahk
class PopUpWindow extends SpMemoGui {
    __New(title := '', winWidth := '', columns := unset, lvOpt := '') {
        super.__New(title, winWidth, , false)
        if IsSet(columns)
            this.AddListView('xm ' lvOpt ' Background' this.currTheme.lv_Bgc ' c' this.currTheme.lv_Fc, columns)
        this.Opt('Owner')
        this['CloseBtn'].OnEvent('Click', 'WinClose')
    }

    static Show(p*) {
        ; make sure that only one gui instance exsists
        for w in WinGetList('ahk_pid ' ProcessExist())
            if (g := GuiFromHwnd(w)) && g.base = this.Prototype
                return g.Show()
        inst := this(p*)
        inst.Show()
    }

    WinClose(*) {
        this['CloseBtn'].GetPos(&wx, &wy, &ww, &wh)
        while GetKeyState("LButton", "P") {
            Sleep(10)
            if !GetKeyState('lButton', 'p') {
                CoordMode 'Mouse', 'Window'
                MouseGetPos(&nx, &ny)
                if nx > (wx - 10) and nx < (wx + ww + 10) and ny > (wy - 10) and ny < (wy + wh + 10) {
                    this.Destroy()
                }
            }
        }
    }
}