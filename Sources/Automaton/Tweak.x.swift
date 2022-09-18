import AutomatonC
import Orion

func getShared(application: String) -> Any? {
    guard let _class = __getSharedApplication(application)
    else {
        NSLog("[Automaton] Failed to get sharedApplication: \(application)")
        return nil
    }
    return _class
}

func getShared(instance: String) -> Any? {
    guard let _class = __getSharedInstance(instance)
    else {
        NSLog("[Automaton] Failed to get sharedInstance: \(instance)")
        return nil
    }
    return _class
}

class SpringBoardHook: ClassHook<SpringBoard> {
    func applicationDidFinishLaunching(_ application: AnyObject) {
        orig.applicationDidFinishLaunching(application)

        NSLog("[Automaton] Registering my powercuts actions")
        PowercutsManager.sharedInstance().registerAction(withIdentifier: "com.barfie.automaton.action.playerState", action: PlayerState())
        PowercutsManager.sharedInstance().registerAction(withIdentifier: "com.barfie.automaton.action.requestWakePrevention", action: RequestWakePrevention())
        PowercutsManager.sharedInstance().registerAction(withIdentifier: "com.barfie.automaton.action.postInternalNotification", action: PostInternalNotification())
        PowercutsManager.sharedInstance().registerAction(withIdentifier: "com.barfie.automaton.action.toggleState", action: ToggleStatus())

        NSLog("[Automaton] Registering activator listeners")
        _ = PlayDetectorDataSource.sharedInstance // lazy initialization? idk but this works
    }
}

class SBMediaControllerTing: ClassHook<SBMediaController> {
    func _mediaRemoteNowPlayingApplicationIsPlayingDidChange(_ arg1: AnyObject) {
        LASharedActivator.sendEvent(toListener: LAEvent(name: pauseKey, mode: LASharedActivator.currentEventMode))
        orig._mediaRemoteNowPlayingApplicationIsPlayingDidChange(arg1)
    }
}

class SBBacklightControllerTing: ClassHook<SBBacklightController> {
    func turnOnScreenFullyWithBacklightSource(_ arg0: CLongLong) {
        if preventCounter == 0 {
            PlayDetectorDataSource.load()
            orig.turnOnScreenFullyWithBacklightSource(arg0)

        } else {
            preventCounter -= 1
            return
        }
    }
}
