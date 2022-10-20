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
        addHomeBackground()
        addLogo()
        addErryMascot()
        addNewGameButton()
        
        //tbc
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
    
    func addHomeBackground() {
        let homeBackground = SKSpriteNode(imageNamed: "homeBackground")
        homeBackground.name = "homeBackground"
        homeBackground.size = CGSize(width: 844, height: 390)
        homeBackground.position = CGPoint.zero
        homeBackground.zPosition = -1
        addChild(homeBackground)
    }
    
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.name = "logo"
        logo.size = CGSize(width: 142, height: 68)
        logo.position = CGPoint(x: -319, y: 129)
        addChild(logo)
    }
    
    func addErryMascot() {
        let erryMascot = SKSpriteNode(imageNamed: "erryMascot")
        erryMascot.name = "erryMascot"
        erryMascot.size = CGSize(width: 201.97, height: 320)
        erryMascot.position = CGPoint.zero
        addChild(erryMascot)
    }
    
    func addNewGameButton() {
        let newGameButton = SKSpriteNode(imageNamed: "newGameButton")
        newGameButton.name = "newGameButton"
        newGameButton.size = CGSize(width: 134, height: 60)
        newGameButton.position = CGPoint(x: 323, y: -133)
        addChild(newGameButton)
    }
    
    func addContinueButton() {
        let continueButton = SKSpriteNode(imageNamed: "continueButton")
        continueButton.name = "continueButton"
        continueButton.size = CGSize(width: 134, height: 60)
        continueButton.position = CGPoint(x: 323, y: -49)
        addChild(continueButton)
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
