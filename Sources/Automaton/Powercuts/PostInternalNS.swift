import AutomatonC
import CoreFoundation
import Foundation
import Orion

@objc public class PostInternalNotification: PCAction {
    let actionKey = "notification"

    override public func perform(forIdentifier _: String, withParameters parameters: [AnyHashable: Any], success: @escaping (Any?) -> Void, fail: @escaping (String) -> Void) {
        guard parameters.count > 0, !((parameters[actionKey] as? String) ?? "").isEmpty
        else {
            fail("You must provide the correct parameters!")
            return
        }

        NSLog("[Automaton] posting...")
        let cfstr = "com.apple.springboard.hasBlankedScreen" as CFString
        
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName(cfstr), nil, nil, true)
        // CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName((parameters[actionKey] as! String) as CFString), nil, nil, true)
        success(nil)
    }

    override public func name(forIdentifier _: String) -> String {
        "Post notification"
    }

    override public func keywords(forIdentifier _: String) -> [String] {
        ["notifcation", "post", "centre"]
    }

    override public func descriptionSummary(forIdentifier _: String) -> String {
        "Action to post to the internal notification centre"
    }

    override public func parametersDefinition(forIdentifier _: String) -> [Any] {
        [["type": "text",
          "key": actionKey,
          "label": "Content to post",
          "placeholder": "com.example.function/post"]]
    }
}
