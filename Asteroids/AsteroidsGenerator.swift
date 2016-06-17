//
//  AsteroidsGenerator.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit

class AsteroidsGenerator {

    private let position: CGPoint

    init(position: CGPoint) {

        self.position = position
    }

    func generate(count: Int) -> [Asteroid] {

        var asteroids: [Asteroid] = []

        for _ in 0 ..< count {

            let asteroid = Asteroid(level: 3)

            asteroid.position = position

            asteroids.append(asteroid)
        }

        return asteroids
    }
}
