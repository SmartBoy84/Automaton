import AutomatonC
import Foundation
import Orion

public var preventCounter = 0

@objc public class RequestWakePrevention: PCAction {
    let wakeKey = "State"
    let maxWake = "Max preventions"

    let screenModes = [
        "Allow",
        "Prevent",
    ]

    override public func perform(forIdentifier _: String, withParameters parameters: [AnyHashable: Any], success: @escaping (Any?) -> Void, fail: @escaping (String) -> Void) {
        guard let wakeType = screenModes.firstIndex(of: (parameters[wakeKey] as? String) ?? ""),
              let wakeTokens = parameters[maxWake] as? Int
        else {
            fail("Malformed data!")
            return
        }

        preventCounter = wakeType * wakeTokens
        success(nil)
    }

    override public func name(forIdentifier _: String) -> String {
        "Disable/enable screen wakeup"
    }

    override public func descriptionSummary(forIdentifier _: String) -> String {
        "Disable/enable screen wake"
    }

    override public func parametersDefinition(forIdentifier _: String) -> [Any] {
        return [
            [
                "type": "enum",
                "key": wakeKey,
                "defaultValue": "Allow",
                "items": screenModes,
            ],
            [
                "type": "number",
                "key": maxWake,
                "label": maxWake,
                "allowsDecimalNumbers": false,
                "allowsNegativeNumbers": false,
                "defaultValue": 1,
                "condition": [
                    "key": wakeKey,
                    "value": "Prevent",
                ],
            ],
        ]
    }

    override public func parameterSummary(forIdentifier _: String) -> String {
        "${\(wakeKey)} screen wakeup"
    }
}