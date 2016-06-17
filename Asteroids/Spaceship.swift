//
//  Spaceship.swift
//  Asteroids
//
//  Copyright © 2015 Kamil Grzegorzewicz. All rights reserved.
//

import SpriteKit

class Spaceship: SKSpriteNode, GameElement {

    var velocity: CGFloat = 0 {
        didSet {
            self.velocity = min(max(self.velocity, GameConstant.Ship.minSpeed), GameConstant.Ship.maxSpeed)
        }
    }

    init() {

        let ship = SKTexture(imageNamed: "Spaceship")

        super.init(texture: ship, color: UIColor.clearColor(), size: ship.size())

        self.physicsBody = SKPhysicsBody(texture: ship, size: ship.size())
        self.physicsBody?.categoryBitMask = CollisionCategory.Ship.rawValue
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = CollisionCategory.Asteroid.rawValue
    }

    @available(*, message="Won't do")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {

        guard let scene = self.scene else { return }

        var xPos = self.position.x + cos(CGFloat(M_PI_2) + self.zRotation) * self.velocity
        var yPos = self.position.y + sin(CGFloat(M_PI_2) + self.zRotation) * self.velocity

        if xPos < 0 {
            xPos = scene.size.width
        } else if xPos > scene.size.width {
            xPos = 0
        }

        if yPos < 0 {
            yPos = scene.size.height
        } else if yPos > scene.size.height {
            yPos = 0
        }

        self.position = CGPoint(x: xPos, y: yPos)
    }
}