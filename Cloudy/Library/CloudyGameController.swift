// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import GameController

/// Convenience extension
extension GCControllerButtonInput {

    /// Convenience creator
    var controller: CloudyController.Button {
        CloudyController.Button(pressed: isPressed, touched: isTouched, value: value)
    }
}

/// Convenience extension
extension GCExtendedGamepad {

    public enum id: Int {
        case playstation, xbox, stadia, nintendo
        func chromeFormat() -> String {
            switch self {
            case .playstation: // DualShock 4 v2 (Circle, Cross, Triangle, Square, L1, R1, L2, R2)
                return "Cloudy emulated controller (STANDARD GAMEPAD Vendor: 054c Product: 09cc)"
            case .xbox: // Xbox One S Bluetooth (Dreamcast ABXY, LB, RB, LT, RT)
                return "Cloudy emulated controller (STANDARD GAMEPAD Vendor: 045e Product: 02fd)"
            case .stadia: // Stadia controller (Dreamcast ABXY, L1, R1, L2, R2 — same as Apple's layout)
                return "Cloudy emulated controller (STANDARD GAMEPAD Vendor: 18d1 Product: 9400)"
            case .nintendo: // Switch Pro controller (Classic ABXY, L, R, ZL, ZR)
                return "Cloudy emulated controller (STANDARD GAMEPAD Vendor: 057e Product: 2009)"
            }
        }
    }

    /// Convert to json
    func toCloudyController() -> CloudyController? {
        guard let buttonOptions = buttonOptions,
              let buttonHome = buttonHome,
              let leftThumbstickButton = leftThumbstickButton,
              let rightThumbstickButton = rightThumbstickButton else {
            return nil
        }
        return CloudyController(
                axes: [
                    leftThumbstick.xAxis.value,
                    -1.0 * leftThumbstick.yAxis.value,
                    rightThumbstick.xAxis.value,
                    -1.0 * rightThumbstick.yAxis.value
                ],
                buttons: [
                    /*  0 */ buttonA.controller,
                    /*  1 */ buttonB.controller,
                    /*  2 */ buttonX.controller,
                    /*  3 */ buttonY.controller,
                    /*  4 */ leftShoulder.controller,
                    /*  5 */ rightShoulder.controller,
                    /*  6 */ leftTrigger.controller,
                    /*  7 */ rightTrigger.controller,
                    /*  8 */ buttonOptions.controller,
                    /*  9 */ buttonMenu.controller,
                    /* 10 */ leftThumbstickButton.controller,
                    /* 11 */ rightThumbstickButton.controller,
                    /* 12 */ dpad.up.controller,
                    /* 13 */ dpad.down.controller,
                    /* 14 */ dpad.left.controller,
                    /* 15 */ dpad.right.controller,
                    /* 16 */ buttonHome.controller,
                ])
    }
}
