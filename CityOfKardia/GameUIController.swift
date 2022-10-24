//
//  Kardia2
//
//  Created by Farrel Brian on 13/10/22.
//

import SpriteKit
import GameplayKit

class GameUIController: SKScene, SKPhysicsContactDelegate {
    
    // Nodes
    var player : SKNode?
    var leftCtrl : SKNode?
    var rightCtrl : SKNode?
    var jump : SKNode?
    var npc : SKNode?
    var logo : SKNode?
    
    // Movement & State
    var moveLeft = false
    var moveRight = false
    var facingRight = true
    let playerSpeed = 4.0
    var playerStateMachine : GKStateMachine!
    
    // Flag
    var inContact = false
    
    override func didMove(to view: SKView) {
        player = childNode(withName: "Player")
        leftCtrl = childNode(withName: "LeftButton")
        rightCtrl = childNode(withName: "RightButton")
        jump = childNode(withName: "ActionButton")
        npc = childNode(withName: "Gatekeeper_2")
        logo = childNode(withName: "Logo")
        
        physicsWorld.contactDelegate = self
        
        playerStateMachine = GKStateMachine(states: [
            JumpingState(player: player!),
            IdleState(player: player!),
            WalkingState(player: player!),
            LandingState(player: player!)
        ])
        
        logo?.isHidden = true
        
        playerStateMachine.enter(IdleState.self)
    }
}

// MARK: Logika saat ada input dari user
extension GameUIController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "LeftButton") {
                moveLeft = true
            } else if (node.name == "RightButton") {
                moveRight = true
            } else if (node.name == "ActionButton") {
                print("touched")
                
                if inContact {
                    logo?.isHidden = false
                } else {
                    playerStateMachine.enter(JumpingState.self)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Insert logic kalo butuh saat touchnya ngedrag
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            if moveLeft || moveRight {
                moveLeft = false
                moveRight = false
                player?.removeAllActions()
                playerStateMachine.enter(IdleState.self)
            }
        
    }
}

// MARK: Logika yang terjadi saat terjadi kontak antara dua node.
extension GameUIController {
    
    // Saat mulai kontak
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
        if (bodyA == "Player" && bodyB == "Gatekeeper_2") || (bodyA == "Player" && bodyB == "Gatekeeper_2"){
            inContact = true
        }
    }
    
    // Saat akhir kontak
    func didEnd(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
        if (bodyA == "Player" && bodyB == "Gatekeeper_2") || (bodyA == "Player" && bodyB == "Gatekeeper_2") {
            inContact = false
            logo?.isHidden = true
        }
    }
}

// MARK: Menjalankan animasi & logic menggunakan fungsi update.
extension GameUIController {
    override func update(_ currentTime: TimeInterval) {
        
        // X Velocity & states
        if moveRight {
            let displacement = CGVector(dx: playerSpeed, dy: 0)
            let moveAction = SKAction.move(by: displacement, duration: 0)
            player?.run(moveAction)
            playerStateMachine.enter(WalkingState.self)
        } else if moveLeft {
            let displacement = CGVector(dx: playerSpeed * -1, dy: 0)
            let moveAction = SKAction.move(by: displacement, duration: 0)
            player?.run(moveAction)
            playerStateMachine.enter(WalkingState.self)
        } else if !moveLeft && !moveRight {
            playerStateMachine.enter(IdleState.self)
        }
        
        // Flip texture when walking
        if moveRight && !facingRight {
            let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
            player?.run(flipTexturePositive)
            facingRight = true
        } else if moveLeft && facingRight {
            let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
            player?.run(flipTextureNegative)
            facingRight = false
        }
        
        // Y velocity cap
        let velocityY = player?.physicsBody?.velocity.dy ?? 0
        if velocityY > 400 {
            player?.physicsBody?.velocity.dy = 400
        }
    }
    
}
