//
//  ArteriPulmonalisController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 15/11/22.
//

import SpriteKit

class ArteriPulmonalisController: GameUIController {
    var playerInitPos = CGPoint(x: 0, y: 0) //apabila player jatuh -> ulang ke posisi awal
    var xPosCamera: Double = 0
    var yPosCamera: Double = 0
    var gameOverScene: SKReferenceNode?
    var bound02: SKSpriteNode?
    var terjebak = 0
    
    enum Order: String {
        case right = "right", left = "left", up = "up", down = "down"
    }
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Setup Particle
        if let particle = SKReferenceNode(fileNamed: "StarParticles"){
            particle.position = CGPoint(x: self.size.width*1.5, y: self.size.height*1.5)
            self.addChild(particle)
        }
        
        // Setup player's initial position
        playerInitPos = player?.position ?? CGPoint(x: 0, y: 0)
        print(playerInitPos)
        xPosCamera = 680
        yPosCamera = 300
        camera?.run(SKAction.scale(to: 2.5, duration: 0))
        
        //Setup Nodes
        if let platform01 = childNode(withName: "platform_1") as? SKSpriteNode,
           let platform02 = childNode(withName: "platform_2") as? SKSpriteNode,
           let platform03 = childNode(withName: "platform_3") as? SKSpriteNode,
           let platform04 = childNode(withName: "platform_4") as? SKSpriteNode,
           let platform05 = childNode(withName: "platform_5") as? SKSpriteNode,
           let platform06 = childNode(withName: "platform_6") as? SKSpriteNode,
           let platform12 = childNode(withName: "platform_12") as? SKSpriteNode,
           let unwrapBound02 = childNode(withName: "bound02") as? SKSpriteNode
        {
            animateHorizontal(platform: platform01, order: Order.right.rawValue, xMove: 70, duration: 0.6)
            animateHorizontal(platform: platform12, order: Order.right.rawValue, xMove: 140, duration: 0.7)
            animateHorizontal(platform: platform02, order: Order.left.rawValue, xMove: 70, duration: 0.6)
            animateHorizontal(platform: platform03, order: Order.right.rawValue, xMove: 120, duration: 0.7)
            
            animateVertical(platform: platform04, order: Order.up.rawValue)
            animateVertical(platform: platform05, order: Order.down.rawValue)
            animateVertical(platform: platform06, order: Order.up.rawValue)
            bound02 = unwrapBound02
        }
        
        //Setup change ongoing mission
        changeOngoingMission(text: .ap)
        
        CoreDataManager.shared.checkpoint(locationName: "ArteriPulmonalis")
    }
    
    private func animateHorizontal (platform: SKSpriteNode, order: String, xMove: CGFloat, duration: TimeInterval) {
        var sequence: SKAction
        let right = SKAction.moveBy(x: xMove, y: 0, duration: duration)
        let left =  SKAction.moveBy(x: -xMove, y: 0, duration: duration)
        if order == "right" {
            sequence = SKAction.sequence([right, left])
        } else {
            sequence = SKAction.sequence([left, right])
        }
        let repeated = SKAction.repeatForever(sequence)
        platform.run(repeated)
    }
    
    private func animateVertical (platform: SKSpriteNode, order: String) {
        var sequence: SKAction
        let up = SKAction.moveBy(x: 0, y: 80, duration: 0.7)
        let down =  SKAction.moveBy(x: 0, y: -80, duration: 0.7)
        if order == "up" {
            sequence = SKAction.sequence([up, down])
        } else {
            sequence = SKAction.sequence([down, up])
        }
        let repeated = SKAction.repeatForever(sequence)
        platform.run(repeated)
    }
    
    //Touch
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
                hideControl(state: false)
            }
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    //Contact
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        enumerateChildNodes(withName: "platform*") { node, _ in
            if(bodyA == node.name || bodyB == node.name){
                self.grounded = true
            }
        }
        switch (bodyA, bodyB) {
        case ("player", "platform_1") : grounded = true
        case ("ground", "player") : grounded = true
            
        case ("player", "clot"): terjebak = 1
        case ("clot", "player"): terjebak = 1
            
        case ("player", "bound02"): moveScene(sceneName: "KapilerScene")
        case ("bound02", "player"): moveScene(sceneName: "KapilerScene")
        default : break
            
        }
        
    }
    override func didEnd(_ contact: SKPhysicsContact) {
        super.didEnd(contact)
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        enumerateChildNodes(withName: "platform*") { node, _ in
            if(bodyA == node.name || bodyB == node.name){
                self.grounded = false
            }
        }
        
        switch (bodyA, bodyB) {
        case ("player", "ground") : grounded = false
        case ("ground", "player") : grounded = false
        default : break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let player = player {
            //diambil dari else if kedua dulu utk 952 nya, baru dimasukin ke kondisi atas2nya
            if (player.position.x > 0 && player.position.y > -(self.size.height/2) && player.position.x < bound02!.position.x - xPosCamera - 1045.739 ) {
                //                print("masuk 1 \(lastGround!.position.x) - \(player.position.x)")
                self.camera?.position = CGPoint(x: xPosCamera + player.position.x , y: yPosCamera)
            } else if (player.position.y > -(self.size.height/2) && player.position.x > bound02!.position.x - xPosCamera - 1045.739) {
                //                print("masuk 2")
                self.camera?.position = CGPoint(x: bound02!.position.x - 1045.739, y: yPosCamera)
            } else {
                //                                print("masuk 3")
                self.camera?.position = CGPoint(x: xPosCamera , y: yPosCamera)
            }
            
            //Kalau jatuh, posisi player ulang dari awal
            if (player.position.y < -(self.size.height/2)) {
                player.position = playerInitPos
                if let gameOverScene = SKReferenceNode(fileNamed: "GameOver") {
                    gameOverScene.name = "gameOver"
                    self.camera?.addChild(gameOverScene)
                    hideControl(state: true)
                }
            }
            
            if (terjebak == 1) {
                player.position = playerInitPos
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
}

