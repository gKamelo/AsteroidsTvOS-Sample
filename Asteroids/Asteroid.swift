//
//  Asteroid.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import SpriteKit

class Asteroid: SKShapeNode, GameElement {

    private let level: Int
    private let velocity: CGFloat

    init(level: Int) {

        self.level = level
        self.velocity = GameConstant.Asteroid.minSpeed + (CGFloat(arc4random_uniform(100)) / 100.0) * (GameConstant.Asteroid.maxSpeed - GameConstant.Asteroid.minSpeed)

        super.init()

        let size: CGFloat = CGFloat(level) * GameConstant.Asteroid.size
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0.0, y: 0.0, width: size, height: size), cornerRadius: size / 2)
        let physicsBody = SKPhysicsBody(circleOfRadius: size / 2, center: CGPoint(x: size / 2, y: size / 2))

        physicsBody.categoryBitMask = CollisionCategory.Asteroid.rawValue
        physicsBody.collisionBitMask = 0
        physicsBody.contactTestBitMask = CollisionCategory.Ship.rawValue

        self.path = bezierPath.CGPath
        self.zRotation = 2 * CGFloat(M_PI) * (CGFloat(arc4random_uniform(100)) / 100.0)
        self.strokeColor = UIColor.whiteColor()
        self.physicsBody = physicsBody
    }

    @available(*, message="Won't do")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {

        guard let scene = self.scene else { return }

        var xPos = self.position.x + cos(self.zRotation) * self.velocity
        var yPos = self.position.y + sin(self.zRotation) * self.velocity

        let width = scene.size.width
        let height = scene.size.height
        let xOffset = 1.1 * width - width
        let yOffset = 1.1 * height - height
        let minX = -xOffset
        let maxX = width + xOffset
        let minY = -yOffset
        let maxY = height + yOffset

        if xPos < minX {
            xPos = maxX
        } else if xPos > maxX {
            xPos = minX
        }

        if yPos < minY {
            yPos = maxY
        } else if yPos > maxY {
            yPos = minY
        }

        self.position = CGPoint(x: xPos, y: yPos)
    }

    func split() {

        defer { self.removeFromParent() }
        guard self.level - 1 > 0 else { return }
        guard let scene = self.scene else { return }

        for _ in 0 ..< GameConstant.Asteroid.split {

            let asteroid = Asteroid(level: self.level - 1)
            asteroid.position = self.position
            scene.addChild(asteroid)
        }
    }
}
