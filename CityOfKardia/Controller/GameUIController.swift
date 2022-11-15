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
    var bubble: SKSpriteNode?
    var tandaSeru: SKSpriteNode?
    var initTandaSeruRotation: CGFloat = 0.0
    
    // MARK: Mission
    var missionJournal: SKReferenceNode?
    var missionJournalController = MissionJournalController()

    
    let musicAudioNode = SKAudioNode(fileNamed: "typingSFX")
    
    // MARK: BGM init
    let bgm = SKAudioNode(fileNamed: "COK_BGM_01")
    
    override func didMove(to view: SKView) {
        self.camera = cam
        
        guard let unwrapCamera = self.camera else { return }
        self.addChild(unwrapCamera)
        unwrapCamera.zPosition = 100
        
        setupHUD()
        setupDialogue()
        setupMissionJournal()
        
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
        
        addChild(bgm)
        bgm.isPositional = false
        bgm.run(.play())
        bgm.run(.changeVolume(to: 0.1, duration: 0))
    
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
            
            if (node.name == "actionButton") {
                if inContact { logo?.isHidden = false }
                    else { actionBtnIsPressed = true }
            }
            
            //Touch mission HUD
            if (node.name == "missionBg" || node.name == "missionLabel") {
                hideMissionJournal(state: false)
            }
            if (node.name == "book_close") {
                hideMissionJournal(state: true)
            }
            
            // Touch Dialogue
            if (dialogue.dialogueVisibility) {
                dialogue.touchesBegan(touches, with: event);
                if (!dialogue.dialogueVisibility) {
                    hideControl(state: false)
                }
            }
        
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            leftBtnIsPressed = false
            rightBtnIsPressed = false
            actionBtnIsPressed = false
    }
}

// MARK: Fungsi untuk menjalankan BGM
extension GameUIController {
    func runBGM() {
        
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
        addCameraChildNode(imageName: "ongoing_mission", name: "missionBg", widthSize: 325, heightSize: 96, xPos: -252, yPos: 135)
        addCameraLabelNode(xPos: -342, yPos: 133, zPos: 101, maxLayout: 100, lineAmount: 1, horizontal: .left, vertical: .baseline, name: "missionLabel", fontSize: 16)
    }
    
    func addCameraChildNode(imageName: String, name: String, widthSize: CGFloat, heightSize: CGFloat, xPos: CGFloat, yPos: CGFloat) {
        let HUD = SKSpriteNode(imageNamed: imageName)
        HUD.name = name
        HUD.size = CGSize(width: widthSize, height: heightSize)
        HUD.position = CGPoint(x: xPos, y: yPos)
        HUD.zPosition = 100
        camera?.addChild(HUD)
    }

    
    public func addCameraLabelNode (xPos: Double, yPos: Double, zPos: CGFloat, maxLayout: CGFloat, lineAmount: Int, horizontal: SKLabelHorizontalAlignmentMode, vertical: SKLabelVerticalAlignmentMode, name: String, fontSize: Int) {
        let node = SKLabelNode(text: "Initializing Label Mission");
        node.name = name
        node.position = CGPoint(x: xPos, y: yPos)
        node.zPosition = CGFloat(zPos);
        node.horizontalAlignmentMode = horizontal
        node.verticalAlignmentMode = vertical
        node.preferredMaxLayoutWidth = maxLayout
        node.lineBreakMode = .byTruncatingTail
        node.numberOfLines = lineAmount;
        node.fontSize = CGFloat(fontSize)
        node.fontColor = .darkGray
        node.fontName = "SF-Pro"
        camera?.addChild(node)
    }
    
    func hideControl(state: Bool) {
        self.camera?.childNode(withName: "leftButton")?.isHidden = state
        self.camera?.childNode(withName: "rightButton")?.isHidden = state
        self.camera?.childNode(withName: "actionButton")?.isHidden = state
    }
    
    func hideMissionHUD(state: Bool) {
        self.camera?.childNode(withName: "missionBg")?.isHidden = state
        self.camera?.childNode(withName: "missionLabel")?.isHidden = state
    }
}

// MARK: Setup Dialogue dan Kontak dengan NPC
extension GameUIController {
    public func createSprite(texture: String, xPos: Double, yPos: Double, zPos: CGFloat, width: CGFloat, height: CGFloat, name: String) {
        let node = SKSpriteNode(imageNamed: texture);
        node.name = name
        node.position = CGPoint(x: xPos, y: yPos)
        node.zPosition = CGFloat(zPos)
        node.size = CGSize(width: width, height: height)
        self.addChild(node)
    }
    
    func setupDialogue() {
        dialogue.createDialogueNode()
        dialogue.name = "dialogue"
        self.camera?.addChild(dialogue)
        setupBubbleDialogue()
    }
    
    func setupBubbleDialogue() {//Create Sprite
        createSprite(texture: "bubble", xPos: 10, yPos: 10, zPos: 4, width: 68, height: 48, name: "bubble")
        createSprite(texture: "seru", xPos: 10, yPos: 10, zPos: 5, width: 16, height: 24, name: "tandaSeru")
        bubble = self.childNode(withName: "bubble") as? SKSpriteNode
        tandaSeru = self.childNode(withName: "tandaSeru") as? SKSpriteNode
        
        hideBubble(state: true)
    }
    
    func showDialogue(assets: [Dialogue]) {
        hideControl(state: true)
        dialogue.startDialogue(dialogue_assets: assets)
        dialogue.dialogueVisibility = true
    }
    
    func contactWith(state: Bool, npcName: String) {
        inContact = state
        npcIncontact = npcName
        positioningBubble(hideState: !state, npc: npcName)
    }
    
    func hideBubble(state: Bool) {
        //Visibility
        bubble?.isHidden = state
        tandaSeru?.isHidden = state
        tandaSeru?.removeAllActions()
        // Add initial rotation pos
        tandaSeru?.zRotation = 0
    }
    
    func positioningBubble(hideState: Bool, npc: String) {
        bubble?.position = CGPoint(x: (self.childNode(withName: npc) as! SKSpriteNode).position.x + 60, y:  (self.childNode(withName: npc) as! SKSpriteNode).position.y + 50)
        tandaSeru?.position = CGPoint(x:  (self.childNode(withName: npc) as! SKSpriteNode).position.x + 58, y:(self.childNode(withName: npc) as! SKSpriteNode).position.y + 55)
        
        hideBubble(state: hideState)
        
        //Animate tanda seru
        if !hideState {
            animateTandaSeru(tandaSeru: tandaSeru ?? SKSpriteNode(imageNamed: ""))
        }
    }
    
    func animateTandaSeru(tandaSeru: SKNode) {
        let left = SKAction.rotate(byAngle: CGFloat.pi/3, duration: 0.5) //30 degrees
        let right = SKAction.rotate(byAngle: -(CGFloat.pi/3), duration: 0.5)
        let sequence = SKAction.sequence([right, left])
        let repeated = SKAction.repeatForever(sequence)
        tandaSeru.run(repeated)
    }
}

// MARK: Fungsi update
extension GameUIController {
    override func update(_ currentTime: TimeInterval) {
        
//        if let player = player {
//            if(player.position.x > 0 ) {
//                self.camera?.position = CGPoint(x: player.position.x , y: playerYPos)
//            }
//        }
        
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

//Mission HUD and Mission Journal
extension GameUIController {
    func setupMissionJournal() {
        if let unwrapMissionJournal = SKReferenceNode(fileNamed: "MissionJournal") {
            self.camera?.addChild(unwrapMissionJournal)
            missionJournal = unwrapMissionJournal
            hideMissionJournal(state: true)
        } else {
            print("Error init mission journal!")
        }
    }
    
    func hideMissionJournal(state: Bool) {
        missionJournal?.isHidden = state
        hideControl(state: !state)
        hideMissionHUD(state: !state)
    }
    
}
