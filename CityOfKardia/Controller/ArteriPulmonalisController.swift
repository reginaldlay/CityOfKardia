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
    var lastGround: SKSpriteNode?
    
    enum Order: String {
        case right = "right", left = "left", up = "up", down = "down"
    }
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        playerInitPos = player?.position ?? CGPoint(x: 0, y: 0)
        print(playerInitPos)
        xPosCamera = 680
        //        print(abs(playerInitPos.x))
        yPosCamera = 300
        camera?.run(SKAction.scale(to: 2.5, duration: 0))
        
        if let platform01 = childNode(withName: "platform_1") as? SKSpriteNode,
           let platform02 = childNode(withName: "platform_2") as? SKSpriteNode,
           let platform03 = childNode(withName: "platform_3") as? SKSpriteNode,
           let platform04 = childNode(withName: "platform_4") as? SKSpriteNode,
           let platform05 = childNode(withName: "platform_5") as? SKSpriteNode,
           let platform06 = childNode(withName: "platform_6") as? SKSpriteNode,
           let unwrapLastGround = childNode(withName: "last_ground") as? SKSpriteNode
        {
            animateHorizontal(platform: platform01, order: Order.right.rawValue, xMove: 70, duration: 0.6)
            animateHorizontal(platform: platform02, order: Order.left.rawValue, xMove: 70, duration: 0.6)
            animateHorizontal(platform: platform03, order: Order.right.rawValue, xMove: 120, duration: 0.7)
            
            animateVertical(platform: platform04, order: Order.up.rawValue)
            animateVertical(platform: platform05, order: Order.down.rawValue)
            animateVertical(platform: platform06, order: Order.up.rawValue)
            lastGround = unwrapLastGround
        }
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
        let up = SKAction.moveBy(x: 0, y: 50, duration: 0.7)
        let down =  SKAction.moveBy(x: 0, y: -50, duration: 0.7)
        if order == "up" {
            sequence = SKAction.sequence([up, down])
        } else {
            sequence = SKAction.sequence([down, up])
        }
        let repeated = SKAction.repeatForever(sequence)
        platform.run(repeated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            if (node.name == "gameover_quit") {
                print("gameover quit")
            } else if (node.name == "gameover_tryagain") {
                if let child = self.camera?.childNode(withName: "gameOver") {
                    child.removeFromParent()
                }
                hideControl(state: false)
                hideMissionHUD(state: false)
            }
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let player = player {
            // Kamera
            //Kalau jatuh (diminus 1 supaya aman ga masuk sini apabila di posisi normal)
            //            if (player.position.y < playerInitPos.y - 1) {
            //                self.camera?.position = CGPoint(x: xPosCamera , y: yPosCamera)
            //                print("masuk 1")
            //                print("\(player.position) ------ \(camera?.position)------ \(playerInitPos.y)")
            //
            //            }
            
            //diambil dari else if kedua dulu utk 952 nya, baru dimasukin ke kondisi atas2nya
            if (player.position.x > 0 && player.position.y > -(self.size.height/2) && player.position.x < lastGround!.position.x - xPosCamera - 952 ) {
//                print("masuk 1 \(lastGround!.position.x) - \(player.position.x)")
                self.camera?.position = CGPoint(x: xPosCamera + player.position.x , y: yPosCamera)
            } else if (player.position.y > -(self.size.height/2) &&
                       player.position.x > lastGround!.position.x - xPosCamera - 952) {
//                print("masuk 2")
                self.camera?.position = CGPoint(x: lastGround!.position.x - 952, y: yPosCamera)
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
                    hideMissionHUD(state: true)
                }
                //Kalau player sudah ditengah layar
            }
            
        }
        
    }
}
