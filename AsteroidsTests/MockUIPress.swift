//
//  MockUIPress.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

class MockUIPress: UIPress {

    let fakeType: UIPressType

    init(fakeType: UIPressType) {
        self.fakeType = fakeType;
    }

    override var type: UIPressType {
        get {
            return self.fakeType;
        }
    }
}
