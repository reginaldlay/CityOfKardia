//
//  KapilerController.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 14/11/22.
//

import SpriteKit
import AVFoundation
import GameplayKit

class KapilerController : GameUIController {
    
    var playerInitPos = CGPoint(x: -350, y: -58) //apabila player jatuh -> ulang ke posisi awal
    var terjebak = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        dialogue.setupNewDictionary(newItem: ["kapiler"])
        CoreDataManager.shared.erryDictionary = 11
        
        setupEnv()
        setupWall()
        setupObs()
        
        player?.playerStartingJumpImpulse = CGFloat(240)
        
        changeOngoingMission(text: .kapiler)
        
        CoreDataManager.shared.checkpoint(locationName: "Kapiler")
    }
    
}

extension KapilerController {
    func setupEnv() {
        enumerateChildNodes(withName: "ground") {
            node, _ in
            node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
            node.physicsBody?.restitution = 0
            node.physicsBody?.friction = 1
            node.physicsBody?.isDynamic = false
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            
            node.physicsBody?.categoryBitMask = UInt32(4)
            node.physicsBody?.collisionBitMask = UInt32(7)
            node.physicsBody?.contactTestBitMask = UInt32(7)
            node.physicsBody?.fieldBitMask = UInt32(0)
            
            let cleared = SKAction.colorize(with: .clear, colorBlendFactor: 1, duration: 0)
            node.run(cleared)
        }
    }
    
    func setupWall() {
        enumerateChildNodes(withName: "wall") {
            node, _ in
            node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
            node.physicsBody?.restitution = 0
            node.physicsBody?.isDynamic = false
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            
            node.physicsBody?.categoryBitMask = UInt32(4)
            node.physicsBody?.collisionBitMask = UInt32(7)
            node.physicsBody?.contactTestBitMask = UInt32(0)
            node.physicsBody?.fieldBitMask = UInt32(0)
            
            let cleared = SKAction.colorize(with: .clear, colorBlendFactor: 1, duration: 0)
            node.run(cleared)
        }
    }
    
    func setupObs() {
        enumerateChildNodes(withName: "clot") {
            node, _ in
            node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
            node.physicsBody?.isDynamic = false
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            
            node.physicsBody?.categoryBitMask = UInt32(4)
            node.physicsBody?.collisionBitMask = UInt32(7)
            node.physicsBody?.contactTestBitMask = UInt32(7)
            node.physicsBody?.fieldBitMask = UInt32(0)
        }
    }
}

extension KapilerController {
    func resetScene() {
        if let resetScene = SKScene(fileNamed: "KapilerScene") {
            scene?.scaleMode = .aspectFill
            scene?.view?.presentScene(resetScene)
        }
    }
}

extension KapilerController {
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }

        print("body A begin: \(bodyA )")
        print("body B begin: \(bodyB )")
        
        switch (bodyA, bodyB) {
            case ("player", "clot"): terjebak = 1
            case ("clot", "player"): terjebak = 1
            
            case ("player", "bound02"): moveScene(sceneName: "GateParuParuScene")
            case ("bound02", "player"): moveScene(sceneName: "GateParuParuScene")
            default : break
        }
    }
    
    override func didEnd(_ contact: SKPhysicsContact) {
        super.didEnd(contact)
        
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        switch (bodyA, bodyB) {
            default : break
        }
    }
}

extension KapilerController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            if (node.name == "gameover_quit") {
                terjebak = 0
                moveScene(sceneName: "GameScene")
            } else if (node.name == "gameover_tryagain") {
                if let child = self.camera?.childNode(withName: "gameOver") {
                    child.removeFromParent()
                    terjebak = 0
                }
                
                if let cam = self.camera {
                    cam.position = CGPoint(x: 0, y: 0)
                }
                
                hideControl(state: false)
            }
        }

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

extension KapilerController {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        playerYPos = player?.position.y ?? 0
        
        guard let bound02 = childNode(withName: "bound02") else { return }
        
        if let player = player {
            if(player.position.x > 0 && player.position.x < bound02.position.x - 475 ) {
                self.camera?.position = CGPoint(x: player.position.x, y: playerYPos)
            } else {
                self.camera?.position.y = playerYPos
            }
        }
        
        if (terjebak == 1) {
            
            guard let unwrapPlayer = player else { return }
            
            unwrapPlayer.position = playerInitPos
            if let gameOverScene = SKReferenceNode(fileNamed: "GameOver") {
                terjebak = 2
                gameOverScene.name = "gameOver"
                let children = gameOverScene.children.first
                if let background = children?.childNode(withName: "gameover_bg") as? SKSpriteNode {
                    background.texture = SKTexture(imageNamed: "terjebak_bg")
                    self.camera?.addChild(gameOverScene)
                    hideControl(state: true)
                } else {
                    print("gagal masuk clot")
                }
            }
        }
    }
}
