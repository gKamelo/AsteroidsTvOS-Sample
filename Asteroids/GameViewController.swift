//
//  GameViewController.swift
//  Asteroids
//
//  Copyright © 2016 Kamil Grzegorzewicz. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var gameScene: GameScene?
    var keyboardInput: KeyboardInputResolver?
    var remoteInput: RemoteInputResolver?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let gameView = self.view as? SKView else { return }

        let keyBoardInput = KeyboardInputResolver()
        let remoteInput = RemoteInputResolver()

        self.keyboardInput = keyBoardInput
        self.remoteInput = remoteInput

        #if (arch(i386) || arch(x86_64))
            let scene = GameScene(size: gameView.bounds.size, input: keyBoardInput)
        #else
            let scene = GameScene(size: gameView.bounds.size, input: remoteInput)
        #endif

        gameView.showsFPS = true
        gameView.showsNodeCount = true
        gameView.showsPhysics = true
        gameView.ignoresSiblingOrder = true

        scene.scaleMode = .AspectFill
        scene.gameListener = self

        gameView.presentScene(scene)

        self.gameScene = scene

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        gameView.addGestureRecognizer(panGesture)
    }

    func panAction(gesture: UIPanGestureRecognizer) {
        self.remoteInput?.processGesture(gesture)
    }

    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.keyboardInput?.beganPressesInput(presses)
        self.remoteInput?.beganPressesInput(presses)
    }

    override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.keyboardInput?.endPressesInput(presses)
        self.remoteInput?.endPressesInput(presses)
    }

    override func pressesCancelled(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        self.keyboardInput?.endPressesInput(presses)
        self.remoteInput?.endPressesInput(presses)
    }
}

extension GameViewController: GameListener {

    func endOfGame() {

        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
