//Note: WARNING: If functionality to suspend/resume the timer is ever required,
//ensure these states are modeled and handled correctly (As enums for example). Failing to do so could result
//in crashes if you, for example, attempt to resume and already running timer

// Instead of the warning above, the strongTimer should be optional and before you start timer you should check if there's already a timer and invalidate the previous timer or use assertionFailure, this is highly unsafe to rely on other programmer to read a comment somewhere.
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
        
        strongTimer.schedule(deadline: .now(), repeating: .seconds(10))
        strongTimer.setEventHandler(handler: { [weak self] in
            self?.oneHeartBeat?()
        })
        
        timer.resume()
    }
    
    var oneHeartBeat: (() -> Void)?
}
