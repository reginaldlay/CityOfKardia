//
//  EndingController.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 17/11/22.
//

import SpriteKit
import GameplayKit

class EndingController: SKScene {
    
    override func didMove(to view: SKView) {
        let endingPhoto = SKSpriteNode(imageNamed: "ending_bg")
        endingPhoto.name = "ending_bg"
        endingPhoto.size = CGSize(width: self.size.width, height: self.size.height)
        endingPhoto.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(endingPhoto)
        
        CoreDataManager.shared.checkpoint(locationName: "Ending")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let nextScene = SKScene(fileNamed: "GameScene") {
            scene?.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene)
        }
    }
    
}
