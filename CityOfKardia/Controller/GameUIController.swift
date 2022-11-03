//
//  Kardia2
//
//  Created by Farrel Brian on 13/10/22.
//

import SpriteKit
import GameplayKit

class GameUIController: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Inisialisasi variabel
    var player : PlayerNode?
    var NPC : SKNode?
    var logo : SKNode?
    var playerState : GKStateMachine?
    let cam = SKCameraNode()
    
    // MARK: Flag untuk player
    var inContact = false // True saat playerNode melakukan contact dengan node lain
    var grounded = true // True saat playerNode bersentuhan dengan tanah
    
    // MARK: Flag untuk button press
    var leftBtnIsPressed = false
    var rightBtnIsPressed = false
    var actionBtnIsPressed = false
    
    override func didMove(to view: SKView) {
        
        self.camera = cam
        
        guard let unwrapCamera = self.camera else { return }
        self.addChild(unwrapCamera)
        unwrapCamera.zPosition = 100
        
        setupHUD()
        
        guard let unwrapPlayer = childNode(withName: "player") as? PlayerNode,
              let unwrapNPC = childNode(withName: "gatekeeper_2"),
              let unwrapLogo = childNode(withName: "logo")
        else { return }
        
        player = unwrapPlayer
        NPC = unwrapNPC
        logo = unwrapLogo
        
        physicsWorld.contactDelegate = self
        
        playerState = GKStateMachine(states:
                                    [
                                        IsJumpingState(player: unwrapPlayer),
                                        IsWalkingLeftState(player: unwrapPlayer),
                                        IsWalkingRightState(player: unwrapPlayer),
                                        IsIdleState(player: unwrapPlayer)
                                    ])
        
        logo?.isHidden = true
    }
}

// MARK: Fungsi saat ada input dari user / touch
extension GameUIController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
                    
            if (node.name == "leftButton") { leftBtnIsPressed = true }
            else if (node.name == "rightButton") { rightBtnIsPressed = true }
            
            if (node.name == "actionButton") {
                if inContact { logo?.isHidden = false }
                    else { actionBtnIsPressed = true }
            }
        
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            leftBtnIsPressed = false
            rightBtnIsPressed = false
            actionBtnIsPressed = false

    }
}

// MARK: Fungsi saat terjadi kontak antara dua node
extension GameUIController {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
        if bodyA == player?.name && bodyB == NPC?.name {
            inContact = true
        } else if bodyB == player?.name && bodyA == NPC?.name {
            inContact = true
        }
        
        if bodyA == player?.name && bodyB == "ground" {
            grounded = true
        } else if bodyB == player?.name && bodyA == "ground" {
            grounded = true
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node?.name
        let bodyB = contact.bodyB.node?.name
        
        if  bodyA == player?.name && bodyB == NPC?.name {
            inContact = false
            logo?.isHidden = true
        } else if bodyB == player?.name && bodyA == NPC?.name {
            inContact = false
            logo?.isHidden = true
        }
        
        if bodyA == player?.name && bodyB == "ground" {
            grounded = false
        } else if bodyB == player?.name && bodyA == "ground" {
            grounded = false
        }
    
    }
}

// MARK: Setup HUD
extension GameUIController {
    func setupHUD() {
        addCameraChildNode(imageName: "leftButton", name: "leftButton", widthSize: 60, heightSize: 60, xPos: -352, yPos: -133)
        addCameraChildNode(imageName: "rightButton", name: "rightButton", widthSize: 60, heightSize: 60, xPos: -252, yPos: -133)
        addCameraChildNode(imageName: "actionButton", name: "actionButton", widthSize: 66, heightSize: 84, xPos: 349, yPos: -129)
    }
    
    func addCameraChildNode(imageName: String, name: String, widthSize: CGFloat, heightSize: CGFloat, xPos: CGFloat, yPos: CGFloat) {
        let HUD = SKSpriteNode(imageNamed: imageName)
        HUD.name = name
        HUD.size = CGSize(width: widthSize, height: heightSize)
        HUD.position = CGPoint(x: xPos, y: yPos)
        HUD.zPosition = 100
        camera?.addChild(HUD)
    }
}

// MARK: Fungsi update
extension GameUIController {
    override func update(_ currentTime: TimeInterval) {
        
        if let player = player {
            self.camera?.position = player.position
        }
        
        if grounded {
            if actionBtnIsPressed {
                playerState?.enter(IsJumpingState.self)
            }
            
            if leftBtnIsPressed {
                
                playerState?.enter(IsWalkingLeftState.self)
                player?.move(direction: "left")
                
            } else if rightBtnIsPressed {
                
                playerState?.enter(IsWalkingRightState.self)
                player?.move(direction: "right")
                
            }
            
            if !actionBtnIsPressed && !leftBtnIsPressed && !rightBtnIsPressed {
                playerState?.enter(IsIdleState.self)
            }
        } else {
            player?.runJumpAnimation()
        }
        
    }
}
