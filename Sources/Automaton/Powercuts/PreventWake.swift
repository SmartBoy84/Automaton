import AutomatonC
import Foundation
import Orion

public var preventCounter = 0

class RequestWakePrevention: PCAction {
    let wakeKey = "State"
    let maxWake = "Max preventions"

    let screenModes = [
        "Allow",
        "Prevent",
    ]

    override func perform(forIdentifier _: String, withParameters parameters: [AnyHashable: Any], success: @escaping (Any?) -> Void, fail: @escaping (String) -> Void) {
        guard let wakeType = screenModes.firstIndex(of: (parameters[wakeKey] as? String) ?? ""),
              let wakeTokens = parameters[maxWake] as? Int
        else {
            fail("Malformed data!")
            return
        }

        preventCounter = wakeType * wakeTokens
        success(nil)
    }

    override func name(forIdentifier _: String) -> String {
        "Disable/enable screen wakeup"
    }

    override func keywords(forIdentifier _: String) -> [String] {
        ["screen", "wake", "prevent", "sleep", "allow"]
    }

    override func descriptionSummary(forIdentifier _: String) -> String {
        "Disable/enable screen wake"
    }

    override func parametersDefinition(forIdentifier _: String) -> [Any] {
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

    override func parameterSummary(forIdentifier _: String) -> String {
        "${\(wakeKey)} screen wakeup"
    }
}
