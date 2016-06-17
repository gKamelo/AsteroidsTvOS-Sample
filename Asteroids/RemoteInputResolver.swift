//
//  RemoteInputResolver.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

class RemoteInputResolver: GameInput {

    private var selectKey = false

    private var direction = CGPoint.zero
    private var position = CGPoint.zero

    var velocity: CGFloat {

        return -self.direction.y * 0.1
    }

    var rotation: CGFloat {

        let rotation = -self.direction.x * 0.1

        self.direction.x = 0.0

        return rotation
    }

    var fire: Bool {

        return self.selectKey
    }

    func processGesture(gesture: UIPanGestureRecognizer) {

        let point = gesture.velocityInView(gesture.view)
        let dist: CGFloat = sqrt(point.x * point.x + point.y * point.y)

        self.direction = CGPoint(x: point.x / dist, y: point.y / dist)
    }

    func beganPressesInput(presses: Set<UIPress>) {
        self.updatePresses(presses, withState: true)
    }

    func endPressesInput(presses: Set<UIPress>) {
        self.updatePresses(presses, withState: false)
    }

    // MARK: - Private -

    private func updatePresses(presses: Set<UIPress>, withState state:Bool) {
        for press in presses {
            if press.type == .Select || press.type == .PlayPause {
                self.selectKey = state
            }
        }
    }
}
