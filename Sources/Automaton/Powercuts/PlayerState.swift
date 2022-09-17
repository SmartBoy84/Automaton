import AutomatonC
import Foundation
import Orion

@objc public class PlayerState : PCAction {
    override public func perform(forIdentifier _: String, withParameters _: [AnyHashable: Any], success: @escaping (Any?) -> Void, fail _: @escaping (String) -> Void) {
        success(SBMediaController.sharedInstance().isPaused() ? "1" : SBMediaController.sharedInstance().isPlaying() ? "2" : "3")
    }

    override public func name(forIdentifier _: String) -> String {
        "Get player state"
    }

    override public func descriptionSummary(forIdentifier _: String) -> String {
        "Returns media player state (paused/playing)"
    }

    override public func outputDefinition(forIdentifier _: String) -> [AnyHashable: Any] {
        [
            "type": "number",
            "name": "Playing state",
        ]
    }
}