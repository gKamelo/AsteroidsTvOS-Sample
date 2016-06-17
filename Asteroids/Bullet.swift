//
//  Bullet.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import SpriteKit

class Bullet: SKShapeNode, GameElement {

    var velocity: CGFloat = GameConstant.Bullet.speed

    override init() {
        super.init()

        let bezierPath = UIBezierPath(rect: CGRect(x: 0.0, y: 0.0, width: GameConstant.Bullet.size.width, height: GameConstant.Bullet.size.height))
        let physicsBody = SKPhysicsBody(rectangleOfSize: GameConstant.Bullet.size, center: CGPoint(x: GameConstant.Bullet.size.width / 2, y: GameConstant.Bullet.size.height / 2))

        physicsBody.categoryBitMask = CollisionCategory.Bullet.rawValue
        physicsBody.contactTestBitMask = CollisionCategory.Asteroid.rawValue

        self.path = bezierPath.CGPath
        self.fillColor = GameConstant.Bullet.color
        self.strokeColor = GameConstant.Bullet.color
        self.physicsBody = physicsBody
    }

    @available(*, message="Won't do")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {

        guard let scene = self.scene else { return }

        let xPos = self.position.x + cos(CGFloat(M_PI_2) + self.zRotation) * self.velocity
        let yPos = self.position.y + sin(CGFloat(M_PI_2) + self.zRotation) * self.velocity

        self.position = CGPoint(x: xPos, y: yPos)

        if xPos < 0 || xPos > scene.size.width || yPos < 0 || yPos > scene.size.height {

            self.removeFromParent()
        }
    }
}
