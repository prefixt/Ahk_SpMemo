#Include hanat_emo_control.ahk
#Include history_control.ahk

class HanatTip {
    static retNum := 0
    static T_ClearCount() => this.retNum := 0
    static T_Restore() {
        return 'Glad to see you again, I will memo with you ~'
    }

    static T_Greeting() {
        return 'Glad to see you, I will memo with you ~'
    }

    static T_PressOpenBtn() {
        this.retNum ++
        if this.retNum < 3 and this.retNum > 0
            return 'No such file exsit, want to create a new file ? Type something and press `'Send`' .'
        if this.retNum < 4
            return 'Type something and press `'Send`' button .'
        if this.retNum < 5
            return 'It looks like it`'s better not to create one .'
        else {
            EmotionControl.emo -= 1 * Emotion.DEC_FACTOR
            EmotionControl.UpdateInfo()
            if (Random() <= 0.5)
                return 'It`'s not fun .'
            else
                return '...'
        }
    }

    static T_PressResetBtn() {
        return 'Back to the beginning .'
    }

    static T_PressBrowseBtn(){
        return 'Maybe there have some old files'
    }

    static T_PressNextFileBtn(path) {
        this.T_ClearCount()
        if EmotionControl.emo >= Emotion.LOWSEST {
            if History.CheckValidity(path)
                return 'This is an old file .'
            else
                return 'wow, that`'s a new file'
        }
    }

    static T_NoneFileAndCreated() {
        return 'none such file but i have created it !'
    }

    static T_SendEmptyLine() {
        return 'You should try typing something down .'
    }

    static T_PressSendBtn() {
        if (Random() <= 0.5)
            return 'Nice working ~'
        else
            return 'Well done .'
    }

}