//Note: WARNING: If functionality to suspend/resume the timer is ever required,
//ensure these states are modeled and handled correctly (As enums for example). Failing to do so could result
//in crashes if you, for example, attempt to resume and already running timer
import Foundation

class Timer {
    
    var strongTimer: DispatchSourceTimer!
    
    init() {
        startTimer()
    }
    
    //NOTE: See above warning
    func startTimer() {
        let timer = DispatchSource.makeTimerSource()
        strongTimer = timer
        
        strongTimer.schedule(deadline: .now(), repeating: .seconds(1))
        strongTimer.setEventHandler(handler: { [weak self] in
            self?.oneHeartBeat?()
        })
        
        timer.resume()
    }
    
    var oneHeartBeat: (() -> Void)?
}
