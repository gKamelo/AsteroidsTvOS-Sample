//
//  KeyboardInputResolver.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

private struct Constants {
    static let RotationStep:CGFloat = 0.1
}

class KeyboardInputResolver : GameInput {

    private var leftKey = false
    private var rightKey = false
    private var upKey = false
    private var downKey = false
    private var selectKey = false

    var rotation:CGFloat {
        get {
            if self.leftKey && self.rightKey {
                return 0.0
            }
            else if self.leftKey {
                return Constants.RotationStep
            }
            else if self.rightKey {
                return -Constants.RotationStep
            }

            return 0.0
        }
    }

    var velocity:CGFloat {
        get {
            if self.upKey && self.downKey {
                return 0.0
            }
            else if self.upKey {
                return 1.0
            }
            else if self.downKey {
                return -1.0;
            }

            return 0.0;
        }
    }

    var fire: Bool {

        return self.selectKey
    }

    // MARK: - Public -

    func beganPressesInput(presses: Set<UIPress>) {
        self.updatePresses(presses, withState: true)
    }

    func endPressesInput(presses: Set<UIPress>) {
        self.updatePresses(presses, withState: false)
    }

    // MARK: - Private -

    private func updatePresses(presses: Set<UIPress>, withState state:Bool) {
        for press in presses {
            if press.type == .LeftArrow {
                self.leftKey = state
            }
            else if press.type == .RightArrow {
                self.rightKey = state
            }
            else if press.type == .UpArrow {
                self.upKey = state
            }
            else if press.type == .DownArrow {
                self.downKey = state
            }
            else if press.type == .Select || press.type == .PlayPause {
                self.selectKey = state
            }
        }
    }
}
