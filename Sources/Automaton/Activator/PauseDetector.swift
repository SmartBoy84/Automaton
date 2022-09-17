import AutomatonC
import Orion

public let pauseKey = "com.barfie.automaton.activator.mediaStateChanged"

@objc public class PlayDetectorDataSource: NSObject, LAEventDataSource {
    static let sharedInstance = PlayDetectorDataSource()
    
    override init() {
        super.init()

        if LASharedActivator.isRunningInsideSpringBoard {
            LASharedActivator.register(self, forEventName: pauseKey)
        }
    }
    
    deinit {
        if LASharedActivator.isRunningInsideSpringBoard {
            LASharedActivator.unregisterEventDataSource(withEventName: pauseKey)
        }
    }

    public func localizedTitle(forEventName _: String!) -> String! {
        "Media playback toggled"
    }

    public func localizedGroup(forEventName _: String!) -> String! {
        "Media playback"
    }

    public func localizedDescription(forEventName _: String!) -> String! {
        "Fires when user pauses/unpauses media playback"
    }

    public func event(withName _: String!, isCompatibleWithMode _: String!) -> Bool {
        true
    }
}
