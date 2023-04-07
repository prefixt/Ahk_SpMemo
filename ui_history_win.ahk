#Include ui_pop_win.ahk
#Include history_control.ahk

class HistoryFileUI extends PopUpWindow {
    ; list of selected file
    ; The default temp file is configured
    __New(Pwd) {
        super.__New('History', 470, ['Title       ', 'Path'], 'vFilePaths w500 -Multi')
        this.OnEvent('Close', 'Destroy')
        this['FilePaths'].SetFont('s13')
        this.filesNum := History.ReadHistory(this['FilePaths'])
        this['FilePaths'].OnEvent('DoubleClick', 'SendData')
        this['FilePaths'].OnEvent('Click', 'ChangeStatus')
        this.AddStatusBar('vStatus -Theme' ' Background' this.currTheme.statusBar_Bgc, 'Total:' this.filesNum)
        this.Show('xCenter y400')
        this.Pwd := Pwd

    }
    ChangeStatus(lv, row) {
        filename := lv.GetText(row, 1)
        if not filename ~= 'Title'
            this['Status'].SetText(filename)
        else
            this['Status'].SetText('Total:' this.filesNum)
    }

    SendData(lv, row) {
        filename := lv.GetText(row, 1)
        path := lv.GetText(row, 2)
        if not (filename ~= 'Title') {
            this.Destroy()
            try
                this.Pwd.Value := filename
            catch as e
                MsgBox 'Please Start running from SpMemoLauncher.ahk or ui_editor.ahk'
        }
    }
}
if A_ScriptFullPath = A_LineFile
    HistoryFileUI.Show('')