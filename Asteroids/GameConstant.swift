//
//  GameConstant.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

struct GameConstant {

    static let fireDelay: Double = 0.25

    struct Ship {

        static let minSpeed: CGFloat = 0.0
        static let maxSpeed: CGFloat = 15.0
    }

    struct Bullet {

        static let speed: CGFloat = 25.0
        static let color = UIColor.redColor()
        static let size = CGSize(width: 2.0, height: 10.0)
    }

    struct Asteroid {

        static let minSpeed: CGFloat = 2.0
        static let maxSpeed: CGFloat = 4.0
        static let color = UIColor.whiteColor()
        static let size: CGFloat = 20.0
        static let split = 2
    }
    
}

enum CollisionCategory: UInt32 {

    case Ship = 1
    case Bullet = 2
    case Asteroid = 4
}
