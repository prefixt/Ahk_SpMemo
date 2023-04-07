#Include sp_memo_config.ahk
#Include sp_memo_theme.ahk

class SpMemoGui extends Gui {
    ; basic settings
    __New(title := 'SpMemo', headWidth := 100, opt := '', hasThemeBtn := false, hasMinBtn := false, hasCloseBtn := true) {
        super.__New('-Caption +Border +AlwaysOnTop' opt, title, this)
        cfg := ReadCfg()
        this.SetFont(cfg[2], cfg[3]) ; set font
        if cfg[1] = 'light'
            this.currTheme := Light() ; theme instance of sp_memo_theme.ahk
        else
            this.currTheme := Dark()
        this.BackColor := this.currTheme.window_Bgc
        if this.currTheme is Dark
            this.AddPicture('xm w20 h-1', 'resource\sp_memo_dark.png')
        else
            this.AddPicture('xm w20 h-1', 'resource\sp_memo_light.png')

        this.AddText('yp h20 vHeadBar c' this.currTheme.title_Fc ' Background' this.currTheme.headerBar_Bgc ' w' headWidth - 30, title).OnEvent('Click', 'MoveWin')
        if hasThemeBtn
            if this.currTheme is Dark
                this.AddPicture('ym w20 h20 vSwitchTheme', 'resource/theme_dark.png').OnEvent('Click', 'ThemeToLight')
            else
                this.AddPicture('ym w20 h20 vSwitchTheme', 'resource/theme_light.png').OnEvent('Click', 'ThemeToDark')
        if hasMinBtn
            if this.currTheme is Dark
                this.AddPicture('ym w20 h20 Section vMiniBtn', 'resource/minimize_btn_dark.png').OnEvent('Click', 'AnimateHide')
            else
                this.AddPicture('ym w20 h20 Section vMiniBtn', 'resource/minimize_btn_light.png').OnEvent('Click', 'AnimateHide')

        if hasCloseBtn
            if this.currTheme is Dark
                this.AddPicture('yp w20 h20 vCloseBtn', 'resource/close_btn_dark.png')
            else
                this.AddPicture('yp w20 h20 vCloseBtn', 'resource/close_btn_light.png') ; Event will be provided by subclasses


    }

    AnimateHide(*) {
        ; add an animation to the hidden window, because the default style is missing when set the option '-Caption'
        ; and, simulate the mouse click up event
        this['MiniBtn'].GetPos(&wx, &wy, &ww, &wh)
        while GetKeyState("LButton", "P") {
            Sleep(10) ; necessary
            if !GetKeyState('lButton', 'p') {
                CoordMode 'Mouse', 'Window'
                MouseGetPos(&nx, &ny)
                ; whether the mouse cursor hover on the minimize button
                if nx > (wx - 10) and nx < (wx + ww + 10) and ny > (wy - 10) and ny < (wy + wh + 10) {
                    this.GetClientPos(&cx, &cy, &cw, &ch)
                    clientW := cw, clientH := ch
                    while cw > 0 {
                        ; change the hide style via modify the cw to ch, or both cw & ch
                        this.Move(, , cw--,)
                    }
                    WinSetTransparent(0, 'ahk_id' this.Hwnd)
                    this.Move(cx, cy, clientW, clientH)
                    this.Minimize()
                    WinSetTransparent(255, 'ahk_id' this.Hwnd)
                }
            }
        }
    }

    MoveWin(*) {
        ; move gui window via dragging the header bar
        MouseGetPos(&px, &py)
        WinGetPos(&wx, &wy, , , 'ahk_id' this.Hwnd)
        While GetKeyState("LButton", "P")
        {
            SetWinDelay -1
            MouseGetPos(&nx, &ny)
            wx += nx - px, wy += ny - py
            this.Move(wx, wy, ,) ; Use gui.Move() instead of WinMove()
        }
    }

    ThemeToLight(*) {
        this['SwitchTheme'].GetPos(&wx, &wy, &ww, &wh)
        while GetKeyState("LButton", "P") {
            ; sumulate the mouse click up event
            Sleep(10)
            if !GetKeyState('lButton', 'p') {
                CoordMode 'Mouse', 'Window'
                MouseGetPos(&nx, &ny)
                if nx > (wx - 10) and nx < (wx + ww + 10) and ny > (wy - 10) and ny < (wy + wh + 10) {
                    ; switch the theme
                    WriteCfg(' "light"', 'Theme', 'theme')
                    this.GetClientPos(&cx, &cy, ,)
                    WriteCfg(' "' cx '"', 'Coordinate', 'clientX')
                    WriteCfg(' "' cy '"', 'Coordinate', 'clientY')
                    Reload
                }
            }
        }
    }

    ThemeToDark(*) {
        this['SwitchTheme'].GetPos(&wx, &wy, &ww, &wh)
        while GetKeyState("LButton", "P") {
            Sleep(10)
            if !GetKeyState('lButton', 'p') {
                CoordMode 'Mouse', 'Window'
                MouseGetPos(&nx, &ny)
                if nx > (wx - 10) and nx < (wx + ww + 10) and ny > (wy - 10) and ny < (wy + wh + 10) {
                    WriteCfg(' "dark"', 'Theme', 'theme')
                    this.GetClientPos(&cx, &cy, ,)
                    WriteCfg(' "' cx '"', 'Coordinate', 'clientX')
                    WriteCfg(' "' cy '"', 'Coordinate', 'clientY')
                    Reload
                }
            }
        }
    }
}