#Include ../hanat/hanat_tips.ahk

class MsgControl {
    static GREETING := 0
        , PRESS_NEXT_BTN := 1, PRESS_OPEN_BTN := 2, PRESS_BROWSE_BTN := 3
        , PRESS_SEND_BTN := 4, PRESS_RESET_BTN := 5, PRESS_RRSTORE := 6
        , NONEFILE_CREATED := 10, CREATE_FILE := 11, SELECT_FILE := 12
        , ERROR_SEND_EMPTY := 20

    static GetTipsMsg(msgCode, arg := '') {
        switch msgCode {
            case MsgControl.GREETING:
                return HanatTip.T_Greeting()
            case MsgControl.PRESS_NEXT_BTN:
                return HanatTip.T_PressNextFileBtn(arg)
            case MsgControl.PRESS_OPEN_BTN:
                return HanatTip.T_PressOpenBtn()
            case MsgControl.PRESS_BROWSE_BTN:
                return HanatTip.T_PressBrowseBtn()
            case MsgControl.PRESS_SEND_BTN:
                return HanatTip.T_PressSendBtn()
            case MsgControl.PRESS_RESET_BTN:
                return HanatTip.T_PressResetBtn()
            case MsgControl.PRESS_RRSTORE:
                return HanatTip.T_Restore()
            case MsgControl.NONEFILE_CREATED:
                return HanatTip.T_NoneFileAndCreated()
            case MsgControl.CREATE_FILE:
                return
            case MsgControl.SELECT_FILE:
                return HanatTip.T_SelectFile()
            case MsgControl.ERROR_SEND_EMPTY:
                return HanatTip.T_SendEmptyLine()
            default:
                return 'none message'
        }
    }

    static INIT := 0, RESET := 1, NEXT := 2, BROWSE := 3, SEND_SUCCESSFULL1 := 4, SEND_SUCCESSFULL2 := 5
        , ERROR_RESET := 20, ERROR_SEND := 21, ERROR_OPENFILE := 22, ERROR_NONEFILE := 23

    static GetStatusBarMsg(msgCode) {
        switch msgCode {
            case MsgControl.INIT:
                msg := 'init'
            case MsgControl.RESET:
                msg := 'reset index'
            case MsgControl.NEXT:
                msg := 'next file'
            case MsgControl.BROWSE:
                msg := 'Open history window .'
            case MsgControl.SEND_SUCCESSFULL1:
                msg := '[Done]none file & created'
            case MsgControl.SEND_SUCCESSFULL2:
                msg := '[Done]successfull append'
            case MsgControl.ERROR_RESET:
                msg := '[Error]the lowest index'
            case MsgControl.ERROR_SEND:
                msg := '[Error]empty line'
            case MsgControl.ERROR_OPENFILE:
                msg := '[Error]can not open file'
            case MsgControl.ERROR_NONEFILE:
                msg := '[Error]no such file'
            default:
                msg := 'none'
        }
        return msg
    }
}