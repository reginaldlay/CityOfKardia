//
//  GameScene.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 17/10/22.
//

import SpriteKit
import GameplayKit
import CoreData

class GameController: SKScene {
    
    var playerNode: SKSpriteNode?
    
    let runTexture: Array<SKTexture> = (1...10).map({return "Erry_Run_\($0)"}).map(SKTexture.init)
    
    override func didMove(to view: SKView) {
        addNode(imageName: "home_bg", name: "home_bg", widthSize: 844, heightSize: 390, xPos: 0, yPos: 0, zPos: -1)
        addNode(imageName: "logo", name: "logo", widthSize: 142, heightSize: 68, xPos: -319, yPos: 129, zPos: 0)
        addNode(imageName: "newGameButton", name: "newGameButton", widthSize: 134, heightSize: 60, xPos: 323, yPos: -133, zPos: 0)
        
        guard let unwrapPlayerNode = childNode(withName: "player") as? SKSpriteNode
        else {
            return
        }
        unwrapPlayerNode.size = CGSize(width: 220, height: 300)
        
        playerNode = unwrapPlayerNode
        
        let runAnimation = SKAction.animate(with: runTexture, timePerFrame: 0.1)
        let runForever = SKAction.repeatForever(runAnimation)
        playerNode?.run(runForever)
        
        if (CoreDataManager.shared.readDataErry().location != nil) {
            addNode(imageName: "continueButton", name: "continueButton", widthSize: 134, heightSize: 60, xPos: 323, yPos: -49, zPos: 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "newGameButton") {
                if let child = childNode(withName: "newGameButton") as? SKSpriteNode {
                    child.texture = SKTexture(imageNamed: "newGameButtonClicked")
                }
            }
            else if (node.name == "continueButton") {
                if let child = childNode(withName: "continueButton") as? SKSpriteNode {
                    child.texture = SKTexture(imageNamed: "continueButtonClicked")
                }
            }
        }
                
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "newGameButton") {
                if let nextScene = SKScene(fileNamed: "IntroScene") {
                    self.scene?.scaleMode = .aspectFill
                    self.scene?.view?.presentScene(nextScene)
                }
            }
            else if (node.name == "continueButton") {
                switch (CoreDataManager.shared.readDataErry().location) {
                case ("GateSerambiKanan"):
                    if let nextScene = SKScene(fileNamed: "GateSerambiKananScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("BilikKanan"):
                    if let nextScene = SKScene(fileNamed: "BilikKananScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("PreArteriPulmonalis"):
                    if let nextScene = SKScene(fileNamed: "PreArteriPulmonalisScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("ArteriPulmonalis"):
                    if let nextScene = SKScene(fileNamed: "ArteriPulmonalisScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("Kapiler"):
                    if let nextScene = SKScene(fileNamed: "KapilerScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("GateParuParu"):
                    if let nextScene = SKScene(fileNamed: "GateParuParuScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("Alveolus"):
                    if let nextScene = SKScene(fileNamed: "AlveolusScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                case ("Ending"):
                    if let nextScene = SKScene(fileNamed: "EndingScene") {
                        self.scene?.scaleMode = .aspectFill
                        self.scene?.view?.presentScene(nextScene)
                    }
                    
                default: break
                }
            }
        }
    }
 
    func addNode(imageName: String, name: String, widthSize: CGFloat, heightSize: CGFloat, xPos: CGFloat, yPos: CGFloat, zPos: CGFloat) {
        let homeAsset = SKSpriteNode(imageNamed: imageName)
        homeAsset.name = name
        homeAsset.size = CGSize(width: widthSize, height: heightSize)
        homeAsset.position = CGPoint(x: xPos, y: yPos)
        homeAsset.zPosition = zPos
        addChild(homeAsset)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
