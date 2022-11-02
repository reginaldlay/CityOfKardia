//
//  PlayerNode.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 31/10/22.
//

import Foundation
import SpriteKit

class PlayerNode : SKSpriteNode {
    
    // MARK: Player attribute
    let playerSpeed = CGFloat(250)
    
    // MARK: Player texture
    let WalkingTexture : Array<SKTexture> = (1...12).map({return "Erry_Run_\($0)"}).map(SKTexture.init)
    let idleTexture : Array<SKTexture> = (1...4).map({return "Erry_Idle_\($0)"}).map(SKTexture.init)
    var flipTexture : SKAction?
    
    // MARK: Fungsi untuk menggerakkan player di Y axis
    func jump() {
        
        let velocityY = physicsBody?.velocity.dy ?? 0
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        if velocityY > 400 {
            physicsBody?.velocity.dy = 400
        }
        
    }
    
    // MARK: Fungsi untuk menjalankan animasi saat lompat
    func runJumpAnimation() {
        let velocityY = physicsBody?.velocity.dy ?? 0
        var jumpAnimation : SKAction?
        
        if velocityY > 150 {
            jumpAnimation = SKAction.setTexture(SKTexture(imageNamed: "Erry_Jump_1"))
        } else if velocityY < -150 {
            jumpAnimation = SKAction.setTexture(SKTexture(imageNamed: "Erry_Jump_3"))
        } else {
            jumpAnimation = SKAction.setTexture(SKTexture(imageNamed: "Erry_Jump_2"))
        }
        
        run(jumpAnimation!)
    }
    
    // MARK: Fungsi untuk menggerakkan player di X axis
    func move(direction: String) {

        if direction == "left" {
            physicsBody?.velocity.dx = playerSpeed * -1
        } else if direction == "right" {
            physicsBody?.velocity.dx = playerSpeed
        }
        
    }
    
    // MARK: Fungsi untuk menjalankan animasi saat berjalan
    func runMoveAnimation(direction: String) {
        
        if direction == "left" {
            flipTexture = SKAction.scaleX(to: -1, duration: 0)
        } else if direction == "right" {
            flipTexture = SKAction.scaleX(to: 1, duration: 0)
        }
        
        let WalkingAnimation = { SKAction.repeatForever(.animate(with: self.WalkingTexture, timePerFrame: 0.1)) }
        removeAllActions()
        run(flipTexture ?? SKAction.scaleX(to: 0, duration: 0))
        run(WalkingAnimation())
        
    }
    
    // MARK: Fungsi untuk menjalankan animasi saat idle
    func runIdleAnimation() {
        let idleAnimation = { SKAction.repeatForever(.animate(with: self.idleTexture, timePerFrame: 0.2)) }
        removeAllActions()
        run(idleAnimation())
    }
}
