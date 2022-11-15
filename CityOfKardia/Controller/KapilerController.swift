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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupEnv()
        setupWall()
        setupObs()
        
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
//    func didBegin(_ contact: SKPhysicsContact) {
//        guard
//            let bodyA = contact.bodyA.node?.name,
//            let bodyB = contact.bodyB.node?.name
//        else { return }
//
//        print("body A begin: \(bodyA )")
//        print("body B begin: \(bodyB )")
//        
//        switch (bodyA, bodyB) {
//            case ("player", "clot") : resetScene()
//            case ("clot", "player") : resetScene()
//            case ("player", "ground") : grounded = true
//            default : break
//        }
//    }
//    
//    func didEnd(_ contact: SKPhysicsContact) {
//        guard
//            let bodyA = contact.bodyA.node?.name,
//            let bodyB = contact.bodyB.node?.name
//        else { return }
//        
//        switch (bodyA, bodyB) {
//            case ("player", "ground") : grounded = false
//            default : break
//        }
//    }
}

extension KapilerController {
//    override func update(_ currentTime: TimeInterval) {
//    }
}