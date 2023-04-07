 class EventHandle {

     ; some trigger event
     ;  static DAILY_CURRENT_TIME := 1, DAILY_TELL_FAVOUR := 2
     ;      , GAME_GUSS_NUMBER := 10

     ;  static GetCurrentTime() {
     ;      currentDateTime := FormatTime(, "YYYY/MM/dd_HH:mm:ss_tt")
     ;      return currentDateTime
     ;  }

     static received := false
     Receive(msg) {
         if not EventHandle.received {
             EventHandle.received := !EventHandle.received
             this.Log('Q: ' msg)
             return 'what`'s meaning about that ?'
         } else {
             this.Log(A_tab 'Desc: ' msg)
             EventHandle.received := !EventHandle.received
             return 'i have remember that ~'
         }
     }

     Log(data) {
         f := FileOpen('log.txt', 'a', 'utf-8')
         f.WriteLine(data)
         f.Close()
     }
 }