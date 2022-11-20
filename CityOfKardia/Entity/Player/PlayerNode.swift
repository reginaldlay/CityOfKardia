//
//  PlayerNode.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 31/10/22.
//

import Foundation
import SpriteKit
import AVFoundation

class PlayerNode : SKSpriteNode {
    
    // MARK: Player attribute
    var playerSpeed = CGFloat(350)
    var playerMaxJumpSpeed = CGFloat(350)
    var playerStartingJumpImpulse = CGFloat(240)
    
    // MARK: Player texture
    let WalkingTexture : Array<SKTexture> = (1...10).map({return "Erry_Run_\($0)"}).map(SKTexture.init)
    let idleTexture : Array<SKTexture> = (1...4).map({return "Erry_Idle_\($0)"}).map(SKTexture.init)
    var flipTexture : SKAction?
    
    // MARK: Player Sound FX
    let playerWalkSFX = SKAudioNode(fileNamed: "Erry_Walk_SFX")
    
    // MARK: Fungsi untuk menggerakkan player di Y axis
    func jump() {
                
        let velocityY = physicsBody?.velocity.dy ?? 0
        let velocityX = physicsBody?.velocity.dx ?? 0
        
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: playerStartingJumpImpulse))
        if velocityY > playerMaxJumpSpeed {
            self.physicsBody?.velocity.dy = playerMaxJumpSpeed
        }
        
        if velocityX > playerMaxJumpSpeed {
            self.physicsBody?.velocity.dx = playerMaxJumpSpeed
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
    
    // MARK: Fungsi untuk menjalankan sound fx lompat
    func runJumpSFX() {
        let jumpSFX = SKAction.playSoundFileNamed("Erry_Jump_SFX", waitForCompletion: false)
        run(jumpSFX)
    }
    
    // MARK: Fungsi untuk menggerakkan player di X axis
    func move(direction: String) {

        if direction == "left" {
            physicsBody?.velocity.dx = playerSpeed * -1
            flipTexture = SKAction.scaleX(to: -1, duration: 0)
        } else if direction == "right" {
            physicsBody?.velocity.dx = playerSpeed
            flipTexture = SKAction.scaleX(to: 1, duration: 0)
        }
        
        run(flipTexture ?? SKAction.scaleX(to: 0, duration: 0))
        
    }
    
    // MARK: Fungsi untuk menjalankan animasi saat berjalan
    func runMoveAnimation() {
        
        let WalkingAnimation = { SKAction.repeatForever(.animate(with: self.WalkingTexture, timePerFrame: 0.1)) }
        removeAllActions()
        run(WalkingAnimation())
        
    }
    
    // MARK: Fungsi untuk menjalankan animasi saat idle
    func runIdleAnimation() {
        let idleAnimation = { SKAction.repeatForever(.animate(with: self.idleTexture, timePerFrame: 0.2)) }
        removeAllActions()
        run(idleAnimation())
    }
}
