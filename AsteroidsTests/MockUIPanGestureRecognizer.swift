//
//  MockUIPanGestureRecognizer.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

class MockUIPanGestureRecognizer: UIPanGestureRecognizer {

    private let movement: CGPoint

    init(movement: CGPoint) {

        self.movement = movement

        super.init(target: nil, action: nil)
    }

    override func velocityInView(view: UIView?) -> CGPoint {

        return self.movement
    }
}
