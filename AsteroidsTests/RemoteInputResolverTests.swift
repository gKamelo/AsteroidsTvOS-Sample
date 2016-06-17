//
//  RemoteInputResolverTests.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import XCTest

@testable import Asteroids

class RemoteInputResolverTests: XCTestCase {
    
    var sut: RemoteInputResolver!

    override func setUp() {
        super.setUp()
        self.sut = RemoteInputResolver();
    }

    override func tearDown() {
        self.sut = nil;
        super.tearDown()
    }

    func test_remoteHorizontalMovement_willRotate() {
        let gesture = MockUIPanGestureRecognizer(movement: CGPoint(x: 10.0, y: 0.0))

        self.sut.processGesture(gesture)

        XCTAssertNotEqual(self.sut.rotation, 0.0)
    }

    func test_remoteVerticalMovement_willAccelerate() {
        let gesture = MockUIPanGestureRecognizer(movement: CGPoint(x: 0.0, y: 10.0))

        self.sut.processGesture(gesture)

        XCTAssertNotEqual(self.sut.velocity, 0.0)
    }
    
    func test_playPauseKeyPress_willFire() {
        let press = MockUIPress(fakeType: .PlayPause)

        self.sut.beganPressesInput(Set([press]))

        XCTAssertTrue(self.sut.fire)
    }

    func test_selectKeyPress_willFire() {
        let press = MockUIPress(fakeType: .Select)

        self.sut.beganPressesInput(Set([press]))

        XCTAssertTrue(self.sut.fire)
    }
}
