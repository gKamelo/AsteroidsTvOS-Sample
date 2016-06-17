//
//  GameInput.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

protocol GameInput {

    var rotation:CGFloat { get }
    var velocity:CGFloat { get }

    var fire: Bool { get }
}