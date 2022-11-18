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
    var playerState : GKStateMachine?
    let cam = SKCameraNode()
    var playerYPos: CGFloat = 0 //Untuk camera supaya tidak ngikutin saat loncat
    var menu = Menu()
    var musicIsOn = true
    
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
    
    // MARK: Popup New Dictionary
    //    var newDictionary: SKReferenceNode?
    //    var missionJournalController = MissionJournalController()
    
    
    let musicAudioNode = SKAudioNode(fileNamed: "typingSFX")
    
    // MARK: BGM init
    let bgm = SKAudioNode(fileNamed: "COK_BGM_01")
    
    override func didMove(to view: SKView) {
        self.camera = cam
        
        guard let unwrapCamera = self.camera else { return }
        self.addChild(unwrapCamera)
        
        self.camera?.addChild(menu)
        
        setupHUD()
        setupDialogue()
        
        guard let unwrapPlayer = childNode(withName: "player") as? PlayerNode
        else { return }
        
        player = unwrapPlayer
        
        physicsWorld.contactDelegate = self
        
        playerState = GKStateMachine(states:
                                        [
                                            IsJumpingState(player: unwrapPlayer),
                                            IsWalkingState(player: unwrapPlayer),
                                            IsIdleState(player: unwrapPlayer),
                                            IsFallingState(player: unwrapPlayer)
                                        ])
        
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
                if inContact { }
                else { actionBtnIsPressed = true }
            }
            
            //Touch mission HUD
            if (node.name == "missionBg" || node.name == "missionLabel") {
                setupMissionJournal()
            }
            
            if (node.name == "book_close") {
                if let refChildren = missionJournal?.children.first {
                    changeAssetsColor(parent: refChildren, nodeName: "book_close", imageName: "book_close_pressed")
                } else {
                    print("Error close button texture")
                }
            }
            
            if node.name == "burgerButton" {
                if let burger = self.camera?.childNode(withName: "burgerButton") {
                    let pressedTexture = SKTexture(imageNamed: "burgerButtonClicked")
                    burger.run(SKAction.setTexture(pressedTexture))
                }
            }
            
            if node.name == "menuExitButton" {
                if let nodeName = node.name {
                    menu.didPressAnimation(nodeName: nodeName)
                }
            }
            
            if node.name == "menuKeluarButton" {
                if let nodeName = node.name {
                    menu.didPressAnimation(nodeName: nodeName)
                }
            }
            
            if node.name == "menuKamusButton" {
                if let nodeName = node.name {
                    menu.didPressAnimation(nodeName: nodeName)
                }
            }
            
            if node.name == "menuMusicButton" {
                menu.didPressMusicButton(musicIsOn: musicIsOn)
            }
            
            // Touch Dialogue
            if (dialogue.dialogueVisibility || dialogue.newWord != "") {
                dialogue.touchesBegan(touches, with: event);
                if (!dialogue.dialogueVisibility) {
                    hideControl(state: false)
                }
            }
            
            //
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self.camera!)
            let node = self.atPoint(location)
            
            if location.x <= 0 {
                leftBtnIsPressed = false
                rightBtnIsPressed = false
            } else {
                actionBtnIsPressed = false
            }
        }
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node.name == "leftButton" {
                leftBtnIsPressed = false
            }
            
            if node.name == "rightButton" {
                rightBtnIsPressed = false
            }
            
            if node.name == "actionButton" {
                actionBtnIsPressed = false
            }
            
            if node.name == "burgerButton" {
                if let burger = self.camera?.childNode(withName: "burgerButton") {
                    let pressedTexture = SKTexture(imageNamed: "burgerButton")
                    burger.run(SKAction.setTexture(pressedTexture))
                }
                menu.setupMenu()
                self.hideControl(state: true)
            }
            
            if node.name == "menuExitButton" {
                if let nodeName = node.name {
                    menu.didEndPressAnimation(nodeName: nodeName)
                }
                
                menu.removeAllChildren()
                self.hideControl(state: false)
            }
            
            if node.name == "menuKeluarButton" {
                if let nodeName = node.name {
                    menu.didEndPressAnimation(nodeName: nodeName)
                }
            }
            
            if node.name == "menuKamusButton" {
                if let nodeName = node.name {
                    menu.didEndPressAnimation(nodeName: nodeName)
                }
            }
            
            if node.name == "menuMusicButton" {
                if musicIsOn {
                    menu.didToggleMusicButton(musicIsOn: musicIsOn)
                    bgm.run(.stop())
                    musicIsOn = false
                } else {
                    menu.didToggleMusicButton(musicIsOn: musicIsOn)
                    bgm.run(.play())
                    musicIsOn = true
                }
            }
            
            if (node.name == "book_close") {
                missionJournal?.removeFromParent()
                hideControl(state: false)
            }
            
            
        }
    }
}

// MARK: Fungsi untuk menjalankan BGM
extension GameUIController {
    func runBGM() {
        
    }
}

// MARK: Fungsi saat terjadi kontak antara dua node
extension GameUIController {
    func didBegin(_ contact: SKPhysicsContact) {
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        switch (bodyA, bodyB) {
        case ("player", "ground") : grounded = true
        case ("ground", "player") : grounded = true
        default : break
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        switch (bodyA, bodyB) {
        case ("player", "ground") : grounded = false
        case ("ground", "player") : grounded = false
        default : break
        }
    }
}

// MARK: Setup HUD
extension GameUIController {
    func setupHUD() {
        addCameraChildNode(imageName: "leftButton", name: "leftButton", widthSize: 60, heightSize: 60, xPos: -352, yPos: -133)
        addCameraChildNode(imageName: "rightButton", name: "rightButton", widthSize: 60, heightSize: 60, xPos: -252, yPos: -133)
        addCameraChildNode(imageName: "actionButton", name: "actionButton", widthSize: 66, heightSize: 84, xPos: 349, yPos: -129)
        addCameraChildNode(imageName: "burgerButton", name: "burgerButton", widthSize: 38, heightSize: 40, xPos: 378, yPos: 150)
        addCameraChildNode(imageName: "ongoing_mission", name: "missionBg", widthSize: 325, heightSize: 96, xPos: -252, yPos: 135)
        addCameraLabelNode(xPos: -342, yPos: 133, zPos: 101, maxLayout: 100, lineAmount: 1, horizontal: .left, vertical: .baseline, name: "missionLabel", fontSize: 12)
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
        self.camera?.childNode(withName: "burgerButton")?.isHidden = state
        self.camera?.childNode(withName: "missionBg")?.isHidden = state
        self.camera?.childNode(withName: "missionLabel")?.isHidden = state
        self.camera?.childNode(withName: "lokasi")?.isHidden = state
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

extension GameUIController {
    func moveScene(sceneName: String) {
        if let nextScene = SKScene(fileNamed: sceneName) {
            scene?.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene)
        }
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
                
                if leftBtnIsPressed {
                    
                    player?.move(direction: "left")
                    
                } else if rightBtnIsPressed {
                    
                    player?.move(direction: "right")
                    
                }
                
            } else {
                if leftBtnIsPressed {
                    
                    playerState?.enter(IsWalkingState.self)
                    player?.move(direction: "left")
                    
                } else if rightBtnIsPressed {
                    
                    playerState?.enter(IsWalkingState.self)
                    player?.move(direction: "right")
                    
                }
            }
            
            if !actionBtnIsPressed && !leftBtnIsPressed && !rightBtnIsPressed {
                playerState?.enter(IsIdleState.self)
            }
        } else {
            player?.runJumpAnimation()
            
            if player?.physicsBody?.velocity.dy ?? 0 < 0 {
                playerState?.enter(IsFallingState.self)
            }
            
            if leftBtnIsPressed {
                
                player?.move(direction: "left")
                
            } else if rightBtnIsPressed {
                
                player?.move(direction: "right")
                
            }
        }
        
    }
}

//Mission HUD and Mission Journal
extension GameUIController {
    func setupMissionJournal() {
        if let unwrapMissionJournal = SKReferenceNode(fileNamed: "MissionJournal") {
            
            // Change asset berdasarkan lokasi
            if let children = unwrapMissionJournal.children.first {
                changeAssetsColor(parent: children, nodeName: "book")
                changeAssetsColor(parent: children, nodeName: "book_close")
                changeAssetsColor(parent: children, nodeName: "mission_selected")
                changeAssetsColor(parent: children, nodeName: "dictionary_deselected")
                changeAssetsColor(parent: children, nodeName: "mission2_locked")
                changeLabelColor(parent: children, nodeName: "mission1_title")
            }
            
            hideControl(state: true)
            self.camera?.addChild(unwrapMissionJournal)
            missionJournal = unwrapMissionJournal
        } else {
            print("Error init mission journal!")
        }
    }
    
    func changeOngoingMission(text: Mission) {
        if let mission = self.camera?.childNode(withName: "missionLabel") as? SKLabelNode {
            mission.text = text.rawValue
        }
    }
    
    func changeLabelColor(parent: SKNode, nodeName: String) {
        if let node = parent.childNode(withName: nodeName) as? SKLabelNode {
            let sceneName = getCurrentScene();
            if (sceneName == "BilikKananScene" || sceneName == "GateSerambiKananScene") {
                node.fontColor =  rgbColor(red: 157, green: 115, blue: 105)
            } else if (sceneName == "PreArteriPulmonalisScene" || sceneName == "ArteriPulmonalisScene" || sceneName == "KapilerScene") {
                node.fontColor =  rgbColor(red: 121, green: 135, blue: 171)
            } else if (sceneName == "GateParuParuScene" || sceneName == "AlveolusScene" ){
                node.fontColor =  rgbColor(red: 131, green: 118, blue: 161)
            }
        }
    }
    
    func changeAssetsColor(parent: SKNode, nodeName: String, imageName: String = "") {
        var textureName = ""
        
        if (imageName != "") {
            textureName = imageName
        } else {
            textureName = nodeName
        }
        
        if let node = parent.childNode(withName: nodeName) as? SKSpriteNode {
            let sceneName = getCurrentScene();
            if (sceneName == "BilikKananScene" || sceneName == "GateSerambiKananScene") {
                node.texture = SKTexture(imageNamed: "red_\(textureName)")
            } else if (sceneName == "PreArteriPulmonalisScene" || sceneName == "ArteriPulmonalisScene" || sceneName == "KapilerScene") {
                node.texture = SKTexture(imageNamed: "blue_\(textureName)")
            } else if (sceneName == "GateParuParuScene" || sceneName == "AlveolusScene" ){
                node.texture = SKTexture(imageNamed: "purple_\(textureName)")
            }
        }
    }
    
    func getCurrentScene() -> String {
        if let view = self.view {
            if let currentScene = view.scene {
                return currentScene.name ?? "No node name"
            }
        }
        return "Error get current scene"
    }
    
    func rgbColor(red: Double, green: Double, blue: Double) -> UIColor {
        return UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(1.0))
    }
}
