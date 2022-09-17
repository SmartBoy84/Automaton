import AutomatonC
import Foundation
import Orion

public let pauseKey = "com.barfie.automaton.activator.mediaStateChanged"

class PlayDetectorDataSource: NSObject, LAEventDataSource {
    static let sharedInstance = PlayDetectorDataSource()

    override private init() {
        super.init()

        NSLog("Configuring activator action") // Why the hell is this not run?

        // let task = NSTask()!
        // task.setLaunchPath("/usr/bin/killall")
        // task.setArguments(["-9", "SpringBoard"] as NSMutableArray)
        // task.launch()

        if LASharedActivator.isRunningInsideSpringBoard {
            LASharedActivator.register(self, forEventName: pauseKey)
        }
    }

    deinit {
        if LASharedActivator.isRunningInsideSpringBoard {
            LASharedActivator.unregisterEventDataSource(withEventName: pauseKey)
        }
    }

    func localizedTitle(forEventName _: String!) -> String! {
        "Media playback toggled"
    }

    func localizedGroup(forEventName _: String!) -> String! {
        "Media playback"
    }

    func localizedDescription(forEventName _: String!) -> String! {
        "Fires when user pauses/unpauses media playback"
    }

    func event(withName _: String!, isCompatibleWithMode _: String!) -> Bool {
        true
    }
}
