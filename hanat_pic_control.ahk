#Include hanat_emo_control.ahk
class HanatPicControl {
    ; control pic wheel seeding
    __New(picControl) {
        this.picPath := picControl
    }

    HanatPicWheel(eventCode) {
        Static DEFAULT := 1, SPEAK := 2
            , SMILE := 5, LAUGHT := 6, FROWN := 7, SAD := 8
        switch eventCode {
            case DEFAULT:
            case SPEAK:
            case SMILE:
            case LAUGHT:
            case FROWN:
            case SAD:
            default:
        }
    }

    H_Default() {

    }

    H_Speak() {

    }
    H_Smile() {
    }
    
    H_Laught() {

    }
    H_Frown() {

    }
    H_Sad() {

    }


}