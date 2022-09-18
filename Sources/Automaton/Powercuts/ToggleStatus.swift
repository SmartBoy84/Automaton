import AutomatonC
import CoreFoundation
import Foundation
import Orion

// (getShared(application: "SpringBoard") as? SpringBoard)?._simulateLockButtonPress()

class ToggleStatus: PCAction {
    let parameterLabel = "toggleType"

    let labels: [String] = [
        "Bluetooth", "WiFi", "Airplane Mode", "Battery saver", "Ringer", "AirDrop", "Do not disturb",
    ]
    let items: [() -> String?] = [
        { nil }, // Bluetooth
        { nil }, // WiFi
        {
            if let status = ((getShared(instance: "SBAirplaneModeController") as? SBAirplaneModeController)?.isInAirplaneMode()) {
                return status ? "1" : "0"
            } else {
                return nil
            }
        }, // Airplane Mode
        {
            // if let status = (getShared(instance: "_CDBatterySaver") as? _CDBatterySaver)?.getPowerMode() {
            //     return String(status)
            // } else {
            //     return nil
            // }
            nil
        }, // Battery saver
        { nil }, // Charging status
        { nil }, // DnD
        { nil }, // Ringer
        { nil }, // AirDrop
    ]

    override func perform(forIdentifier _: String, withParameters parameters: [AnyHashable: Any], success: @escaping (Any?) -> Void, fail: @escaping (String) -> Void) {
        guard parameters.count > 0, !((parameters[parameterLabel] as? String) ?? "").isEmpty, let labelKey = labels.firstIndex(of: parameters[parameterLabel] as! String)
        else {
            fail("You must provide the correct parameters!")
            return
        }

        NSLog("[Automaton] Getting state of \(labels[labelKey])")

        if let state = items[labelKey]() {
            success(state)
        } else {
            fail("Couldn't get \(labels[labelKey]) state - likely unimplemented")
        }
    }

    override func name(forIdentifier _: String) -> String {
        "Get toggle status"
    }

    override func descriptionSummary(forIdentifier _: String) -> String {
        "Get status of various toggles"
    }

    override func keywords(forIdentifier _: String) -> [String] {
        ["bluetooth", "airplane", "toggle", "ringer", "bluetooth", "wifi", "dnd", "airdrop"]
    }

    override func parametersDefinition(forIdentifier _: String) -> [Any] {
        [[
            "type": "enum",
            "key": parameterLabel,
            "label": "Toggle",
            "items": labels,
        ]]
    }

    override func parameterSummary(forIdentifier _: String) -> String {
        "Get  state of ${\(parameterLabel)}"
    }

    override func outputDefinition(forIdentifier _: String) -> [AnyHashable: Any] {
        [
            "type": "text",
            "name": "Toggle state",
        ]
    }
}
