//
//  GameScene.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 17/10/22.
//

import SpriteKit
import GameplayKit

class GameController: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    private var newGameButton: SKSpriteNode?
    private var continueButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        //tbc
        
        newGameButton = self.childNode(withName: "newGameButton") as? SKSpriteNode
        continueButton = self.childNode(withName: "continueButton") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tbc
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tbc
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
