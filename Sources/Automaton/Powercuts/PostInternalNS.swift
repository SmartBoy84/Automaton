import AutomatonC
import CoreFoundation
import Foundation
import Orion

class PostInternalNotification: PCAction {
    let actionKey = "notification"

    override func perform(forIdentifier _: String, withParameters parameters: [AnyHashable: Any], success: @escaping (Any?) -> Void, fail: @escaping (String) -> Void) {
        guard parameters.count > 0, !((parameters[actionKey] as? String) ?? "").isEmpty
        else {
            fail("You must provide the correct parameters!")
            return
        }

        NSLog("[Automaton] posting \((parameters[actionKey] as! CFString))")
        
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName(parameters[actionKey] as! CFString), nil, nil, true)
        success(nil)
    }

    override func name(forIdentifier _: String) -> String {
        "Post to NSNotificationCentre"
    }

    override func keywords(forIdentifier _: String) -> [String] {
        ["notifcation", "post", "centre"]
    }

    override func descriptionSummary(forIdentifier _: String) -> String {
        "Action to post to the internal notification centre"
    }

    override func parametersDefinition(forIdentifier _: String) -> [Any] {
        [["type": "text",
          "key": actionKey,
          "label": "Content to post",
          "placeholder": "com.example.function/post"]]
    }
}
