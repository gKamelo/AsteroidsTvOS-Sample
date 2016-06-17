//
//  KeyboardInputResolverTests.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import XCTest

@testable import Asteroids

class KeyBoardInputResolverTests: XCTestCase {

    var sut: KeyboardInputResolver!

    override func setUp() {
        super.setUp()
        self.sut = KeyboardInputResolver();
    }
    
    override func tearDown() {
        self.sut = nil;
        super.tearDown()
    }

    func test_leftKeyPress_willRotate() {
        let press = MockUIPress(fakeType: .LeftArrow)

        self.sut.beganPressesInput(Set([press]))

        XCTAssertGreaterThan(self.sut.rotation, 0.0)
    }

    func test_rightKeyPress_willRotate() {
        let press = MockUIPress(fakeType: .RightArrow)

        self.sut.beganPressesInput(Set([press]))

        XCTAssertLessThan(self.sut.rotation, 0.0)
    }

    func test_upKeyPress_willAccelerate() {
        let press = MockUIPress(fakeType: .UpArrow)

        self.sut.beganPressesInput(Set([press]))

        XCTAssertGreaterThan(self.sut.velocity, 0.0)
    }

    func test_downKeyPress_willAccelerate() {
        let press = MockUIPress(fakeType: .DownArrow)

        self.sut.beganPressesInput(Set([press]))

        XCTAssertLessThan(self.sut.velocity, 0.0)
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
