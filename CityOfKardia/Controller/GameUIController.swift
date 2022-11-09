//
//  Kardia2
//
//  Created by Farrel Brian on 13/10/22.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameUIController: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Inisialisasi variabel
    var player : PlayerNode?
    var NPC : SKNode?
    var logo : SKNode?
    var playerState : GKStateMachine?
    let cam = SKCameraNode()
    var playerYPos: CGFloat = 0 //Untuk camera supaya tidak ngikutin saat loncat
    
    // MARK: Flag untuk player
    var inContact = false // True saat playerNode melakukan contact dengan node lain
    var grounded = true // True saat playerNode bersentuhan dengan tanah
    var npcIncontact = "" //Nama NPC yang melakukan contact dengan player
    
    // MARK: Flag untuk button press
    var leftBtnIsPressed = false
    var rightBtnIsPressed = false
    var actionBtnIsPressed = false
    
    // MARK: Dialogue Init
    let dialogue = DialogueBox()
    
    let musicAudioNode = SKAudioNode(fileNamed: "typingSFX")
//    private let playCollectSound = SKAction.playSoundFileNamed("typingSFX.mp3", waitForCompletion: false)
//
//    func collected() {
//        let removeFromParent = SKAction.removeFromParent()
//        let actionGroup = SKAction.group([playCollectSound, removeFromParent]);
//        self.run(actionGroup)
//    }
    
    override func didMove(to view: SKView) {
//        collected()
//        // Set up the background music audio node
//        musicAudioNode.autoplayLooped = true
//        musicAudioNode.isPositional = false
//        // Add the audio node to the scene
        if let audio = SKAudioNode(fileNamed: "typingSFX.mp3") {
            addChild(audio)
            audio.run(.play())
        } else {
            print("gagalll")
        }
       
//        // Use an action to adjust the audio node's volume to 0
//        musicAudioNode.run(SKAction.changeVolume(to: 1.0, duration: 10.0))
//        // Run a delayed action on the scene that fades in the music
//        run(SKAction.wait(forDuration: 1.0), completion: { [unowned self] in self.audioEngine.mainMixerNode.outputVolume = 1.0; self.musicAudioNode.run(SKAction.changeVolume(to: 0.75, duration: 2.0))
//        })
        self.camera = cam
        
        guard let unwrapCamera = self.camera else { return }
        self.addChild(unwrapCamera)
        unwrapCamera.zPosition = 100
        
        setupHUD()
        setupDialogue()
        
        guard let unwrapPlayer = childNode(withName: "player") as? PlayerNode
        else { return }
        
        player = unwrapPlayer
        
        physicsWorld.contactDelegate = self
        
        playerState = GKStateMachine(states:
                                    [
                                        IsJumpingState(player: unwrapPlayer),
                                        IsWalkingLeftState(player: unwrapPlayer),
                                        IsWalkingRightState(player: unwrapPlayer),
                                        IsIdleState(player: unwrapPlayer)
                                    ])
        
        logo?.isHidden = true
        playerYPos = player?.position.y ?? 0
    }
    
    public func distance(first: CGPoint, second: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(first.x - second.x), Float(first.y - second.y))))
    }
}

// MARK: Fungsi saat ada input dari user / touch
extension GameUIController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
                    
            if (node.name == "leftButton") { leftBtnIsPressed = true }
            else if (node.name == "rightButton") { rightBtnIsPressed = true}
            
//            if (node.name == "actionButton") {
//                if inContact { logo?.isHidden = false }
//                    else { actionBtnIsPressed = true }
//            }
            // Touch Dialogue
            if (dialogue.dialogueVisibility) {
                dialogue.touchesBegan(touches, with: event);
            } else if (!dialogue.dialogueVisibility) {
                hideControl(state: false)
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
//    func didBegin(_ contact: SKPhysicsContact) {
//        let bodyA = contact.bodyA.node?.name
//        let bodyB = contact.bodyB.node?.name
//
//        if bodyA == player?.name && bodyB == NPC?.name {
//            inContact = true
//        } else if bodyB == player?.name && bodyA == NPC?.name {
//            inContact = true
//        }
//
//        if bodyA == player?.name && bodyB == "ground" {
//            grounded = true
//        } else if bodyB == player?.name && bodyA == "ground" {
//            grounded = true
//        }
//
//    }
//
//    func didEnd(_ contact: SKPhysicsContact) {
//        let bodyA = contact.bodyA.node?.name
//        let bodyB = contact.bodyB.node?.name
//
//        if  bodyA == player?.name && bodyB == NPC?.name {
//            inContact = false
//            logo?.isHidden = true
//        } else if bodyB == player?.name && bodyA == NPC?.name {
//            inContact = false
//            logo?.isHidden = true
//        }
//        
//        if bodyA == player?.name && bodyB == "ground" {
//            grounded = false
//        } else if bodyB == player?.name && bodyA == "ground" {
//            grounded = false
//        }
//
//    }
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
    
    func hideControl(state: Bool) {
        self.camera?.childNode(withName: "leftButton")?.isHidden = state
        self.camera?.childNode(withName: "rightButton")?.isHidden = state
        self.camera?.childNode(withName: "actionButton")?.isHidden = state
    }
}

// MARK: Setup Dialogue dan Kontak dengan NPC
extension GameUIController {
    func contactWith(state: Bool, npcName: String) {
        inContact = state
        npcIncontact = npcName
    }
    
    func setupDialogue() {
        dialogue.createDialogueNode()
        dialogue.name = "dialogue"
        self.camera?.addChild(dialogue)
    }
    
    func showDialogue(assets: [Dialogue]) {
        hideControl(state: true)
        dialogue.startDialogue(dialogue_assets: assets)
        dialogue.dialogueVisibility = true
    }
}

// MARK: Fungsi update
extension GameUIController {
    override func update(_ currentTime: TimeInterval) {
        
        if let player = player {
            if(player.position.x > 0 ) {
                self.camera?.position = CGPoint(x: player.position.x , y: playerYPos)
            }
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
