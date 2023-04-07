#Include hanat_info_control.ahk

class Emotion {
    ; constant data
    static LOWSEST := 0, NORMAL := 10, MIDDLE := 50, HIGHEST := 100
    static INC_FACTOR := 0.25, DEC_FACTOR := 0.5
}

class EmotionControl {
    ; hanat emotion control center
    static emo := HanatInfo.GetEmo()

    static Increase(eventCode) {
        EmotionControl.emo += 1 * Emotion.INC_FACTOR
    }

    static Decrease(eventCode) {
        EmotionControl.emo -= 1 * Emotion.DEC_FACTOR
    }

}