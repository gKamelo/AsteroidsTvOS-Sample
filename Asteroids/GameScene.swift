//
//  GameScene.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import SpriteKit

protocol GameListener: class {

    func endOfGame()
}

class GameScene: SKScene {

    private let input: GameInput

    private var spaceship: Spaceship?
    private var fireTimestamp: Double = 0
    private var currentTimestamp: Double = 0

    private let asteroidGeneator = AsteroidsGenerator(position: CGPoint(x: -50, y: -50))

    weak var gameListener: GameListener?

    init(size: CGSize, input: GameInput) {
        self.input = input

        super.init(size: size)
    }

    @available(*, message="Won't do")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView) {
        let player = Spaceship()

        player.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)

        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector.zero

        self.addChild(player)
        self.spaceship = player

        self.asteroidGeneator.generate(5).forEach { asteroid in

            self.addChild(asteroid)
        }
    }

    override func update(currentTime: CFTimeInterval) {

        self.spaceship?.zRotation += self.input.rotation
        self.spaceship?.velocity += self.input.velocity

        self.currentTimestamp = currentTime

        if self.input.fire {

            self.fireIfNeeded()
        }

        for node in self.children {

            if let gameNode = node as? GameElement {

                gameNode.update()
            }
        }
    }

    private func fireIfNeeded() {

        guard let spaceship = self.spaceship else { return }
        guard self.currentTimestamp - GameConstant.fireDelay > self.fireTimestamp else { return }

        self.fireTimestamp = self.currentTimestamp

        let bullet = Bullet()

        bullet.position = spaceship.position
        bullet.zRotation = spaceship.zRotation

        self.addChild(bullet)
    }
}

extension GameScene: SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {

        guard let firstNode = contact.bodyA.node else { return }
        guard let secondNode = contact.bodyB.node else { return }

        if let first = firstNode as? Asteroid {
            self.checkCollisionForAsteroid(first, withNode: secondNode)
        } else if let second = secondNode as? Asteroid {
            self.checkCollisionForAsteroid(second, withNode: firstNode)
        }
    }

    private func checkCollisionForAsteroid(asteroid: Asteroid, withNode node: SKNode) {

        if let ship = node as? Spaceship {

            ship.removeFromParent()
            self.gameListener?.endOfGame()

        } else if let bullet = node as? Bullet {

            bullet.removeFromParent()
            asteroid.split()
        }
    }
}
