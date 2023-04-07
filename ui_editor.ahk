#Include ui_base.ahk
#Include ui_hanat_info_win.ahk
#Include ui_history_win.ahk
#Include ui_exit_app.ahk

#Include msg_control.ahk
#Include history_control.ahk
#Include hanat_emo_control.ahk
#Include hanat_info_control.ahk
#Include hanat_pic_control.ahk
#Include hanat_event.ahk

class EditorAreaGui extends SpMemoGui {
    ; main interface
    static DefaultFileNamePrefix := 'Sp_Temp'
    static index := 0
    static currentFile := EditorAreaGui.DefaultFileNamePrefix EditorAreaGui.index '.txt'
    static DEFALUT_FILEPATH := A_Desktop
    static filePath := EditorAreaGui.DEFALUT_FILEPATH '\' EditorAreaGui.currentFile ; default path

    __New() {
        super.__New('SpMemo', 360, , true, true)
        this['CloseBtn'].OnEvent('Click', 'ShowExitGui')
        this.AddText('xm vPwd w200 Section c' this.currTheme.fileNameText_Fc, EditorAreaGui.currentFile).OnEvent('DoubleClick', 'Reset')
        this.AddText('yp w80 Right vHanatEmo c' this.currTheme.hanatEmoText_Fc, EmotionControl.emo)
        this.AddEdit('xm Multi w300 h85 WantTab t20 vTextArea c' this.currTheme.editA_Fc ' Background' this.currTheme.editA_Bgc)
        this.AddEdit('Multi w300 h60 ReadOnly vHanatTip c' this.currTheme.editB_Fc ' Background' this.currTheme.editB_Bgc, 'none')
        this.AddEdit('w300 h25 vSendBox c' this.currTheme.editC_Fc ' Background' this.currTheme.editC_Bgc, '')
        this['TextArea'].GetPos(&x, &y, &w, &h)
        x += w
        y += h
        this.AddButton('xm w60 h30 -Theme', "&Next").OnEvent('Click', 'Next')
        this.AddButton('yp w60 h30 -Theme x' x - 225, 'Open').OnEvent('Click', 'RunFile')
        this.AddButton('yp w70 h30 -Theme vBrowse x' x - 145, 'Browse').OnEvent('Click', 'Browse')
        this.AddButton('yp w60 h30 -Theme x' x - 60, '&Send').OnEvent('Click', 'Send')
        ; hanat
        this.AddPicture('ys w150 h220 vHanatPic', 'resource\hanat_pic\hanat_test.png').OnEvent('ContextMenu', 'React')
        this.AddButton('xp yp+233 w60 h30 -Theme', '&TELL').OnEvent('Click', 'TellHanat')
        this.AddButton('xp+90 w60 h30 -Theme', 'INFO').OnEvent('Click', 'ShowHanatInfoGui')
        this.AddStatusBar('vStatus -Theme Background' this.currTheme.statusBar_Bgc, 'init')
        this.MSG_CODE := 0 ; use for status bar
        this.repeatMsg := 0 ; usu for status bar same msg counting
        this.hanatPicCtrl := HanatPicControl(this['HanatPic']) ; use for change the value of picControl
        this.eventHandle := EventHandle()
        if !History.CheckCfgFile() ; to check whether the history file is empty
            History.WriteHistory(A_Desktop '\' EditorAreaGui.currentFile, 'a') ; add default path
    }

    static Show(p*) {
        ; nice show effect
        H_editor := EditorAreaGui()
        H_editor.Show('Minimize')
        WinSetTransparent(0, 'ahk_id' H_editor.Hwnd)
        H_editor.Restore()
        H_editor.GetClientPos(, , , &ch)
        cfg := ReadCfg()
        H_editor.Move(cfg[4], cfg[5], , 0)
        WinSetTransparent(255, 'ahk_id' H_editor.Hwnd)
        loop ch {
            H_editor.Move(, , , A_Index)
        }
        H_editor.TypeWriter(MsgControl.GetTipsMsg(0)) ; print gretting
    }

    ShowExitGui(*) {
        ; show exit gui when press close button
        this['CloseBtn'].GetPos(&wx, &wy, &ww, &wh)
        while GetKeyState("LButton", "P") {
            Sleep(10)
            if !GetKeyState('lButton', 'p') {
                CoordMode 'Mouse', 'Window'
                MouseGetPos(&nx, &ny)
                if nx > (wx - 10) and nx < (wx + ww + 10) and ny > (wy - 10) and ny < (wy + wh + 10) {
                    ExitGui.Show(this)
                }
            }
        }
    }

    TellHanat(*) {
        ; send the content of sendBox window to hanat_event.ahk
        backMsg := this.eventHandle.Receive(this['SendBox'].Value)
        this['SendBox'].Value := ''
        this.TypeWriter(backMsg)
    }

    Reset(*) {
        ; back to the default file
        if EditorAreaGui.index = 0 {
            ; it's already the bottom
            this.ChangeStatusBarText(MsgControl.ERROR_RESET)
            return
        }
        ; change status bar text and tips
        EditorAreaGui.index := 0
        EditorAreaGui.currentFile := EditorAreaGui.DefaultFileNamePrefix EditorAreaGui.index '.txt'
        EditorAreaGui.filePath := EditorAreaGui.DEFALUT_FILEPATH '\' EditorAreaGui.currentFile
        this['Pwd'].Value := EditorAreaGui.currentFile
        this.ChangeStatusBarText(MsgControl.RESET)
        this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.PRESS_RESET_BTN))
    }

    Next(*) {
        ; move to the next file
        EditorAreaGui.index += 1
        EditorAreaGui.currentFile := EditorAreaGui.DefaultFileNamePrefix EditorAreaGui.index '.txt'
        EditorAreaGui.filePath := EditorAreaGui.DEFALUT_FILEPATH '\' EditorAreaGui.currentFile
        this['Pwd'].Value := EditorAreaGui.currentFile
        this.ChangeStatusBarText(MsgControl.NEXT)
        this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.PRESS_NEXT_BTN), EditorAreaGui.filePath)
    }

    RunFile(*) {
        ; run current file
        if not FileExist(EditorAreaGui.filePath) {
            this.ChangeStatusBarText(MsgControl.ERROR_NONEFILE)
            this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.PRESS_OPEN_BTN))
            this.UpdateHanatEmoText()
            return
        }
        Run 'C:\Windows\Notepad.exe ' EditorAreaGui.filePath ; run via notepad
    }

    Browse(*) {
        ; Opens the window containing the history file
        HistoryFileUI.Show(this['Pwd'])
        this.ChangeStatusBarText(MsgControl.BROWSE)
        this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.PRESS_BROWSE_BTN))
    }

    Send(*) {
        ; send eitor text to current file
        if this['TextArea'].Value = '' {
            this.ChangeStatusBarText(MsgControl.ERROR_SEND)
            this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.ERROR_SEND_EMPTY))
            return
        }
        if not FileExist(EditorAreaGui.filePath) {
            try
                f := FileOpen(EditorAreaGui.filePath, 'a')
            catch OSError as e {
                ; can't create file
                this.ChangeStatusBarText(MsgControl.ERROR_OPENFILE)
                return
            }
            f.Write(this['TextArea'].Value '`n')
            f.Close()
            if EditorAreaGui.DEFALUT_FILEPATH = A_Desktop {
                History.WriteHistory('A_Desktop\' EditorAreaGui.currentFile, 'a')
            }
            else {
                History.WriteHistory(EditorAreaGui.DEFALUT_FILEPATH '\' EditorAreaGui.currentFile, 'a')
            }
            this.ChangeStatusBarText(MsgControl.SEND_SUCCESSFULL1)
            ; inform
            this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.NONEFILE_CREATED))
        } else {
            FileAppend this['TextArea'].Value '`n', EditorAreaGui.filePath
            this.ChangeStatusBarText(MsgControl.SEND_SUCCESSFULL2)
            this.TypeWriter(MsgControl.GetTipsMsg(MsgControl.PRESS_SEND_BTN))
        }
    }

    ShowHanatInfoGui(*) {
        ; update first
        HanatInfo.UpdateInfo()
        ; open hanat info window
        HanatInfoGui.Show()
    }

    React(GuiCtrlObj, Item, IsRightClick, X, Y) {
        ; Triggers the event when the image is clicked
        m := Menu()
        m.Add '&Touch', (*) => this.hanatPicCtrl.H_Smile()
        m.Show()
        this.UpdateHanatEmoText()
        this.hanatPicCtrl.H_Smile()
    }

    ChangeStatusBarText(msgCode) {
        ; change the text in the statusBar
        msg := MsgControl.GetStatusBarMsg(msgCode)
        if this.MSG_CODE = msgCode {
            this.repeatMsg += 1
        }
        else {
            this.repeatMsg := 0
            this.MSG_CODE := msgCode
        }
        suffix := this.repeatMsg = 0 ? '' : ' x' this.repeatMsg
        this['Status'].SetText(msg suffix)
    }

    UpdateHanatEmoText() {
        ; get, then set the contents of the emotion value display control
        this['HanatEmo'].Value := EmotionControl.emo
    }

    TypeWriter(str) {
        ; sumlate typewriter effect
        loop StrLen(str) {
            this['HanatTip'].Value := SubStr(str, 1, A_Index)
            Sleep(20)
        }
    }
}

if A_ScriptFullPath = A_LineFile
    EditorAreaGui.Show()