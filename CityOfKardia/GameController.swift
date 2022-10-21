//
//  GameScene.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 17/10/22.
//

import SpriteKit
import GameplayKit

class GameController: SKScene {
    
    override func didMove(to view: SKView) {
        addNode(imageName: "homeBackground", name: "homeBackground", widthSize: 844, heightSize: 390, xPos: 0, yPos: 0, zPos: -1)
        addNode(imageName: "logo", name: "logo", widthSize: 142, heightSize: 68, xPos: -319, yPos: 129, zPos: 0)
        addNode(imageName: "erryMascot", name: "erryMascot", widthSize: 201.97, heightSize: 320, xPos: 0, yPos: 0, zPos: 0)
        addNode(imageName: "newGameButton", name: "newGameButton", widthSize: 134, heightSize: 60, xPos: 323, yPos: -133, zPos: 0)
        addNode(imageName: "continueButton", name: "continueButton", widthSize: 134, heightSize: 60, xPos: 323, yPos: -49, zPos: 0)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            enumerateChildNodes(withName: "//*", using: { (node, stop) in
                if node.name == "newGameButton" {
                    if node.contains(touch.location(in: self)) {
                        let introScene = IntroController(size: self.size)
                        self.view?.presentScene(introScene) //nanti tambahin transisi
                    }
                }
            })
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //ganti button newGameButton jadi newGameButtonClicked
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
