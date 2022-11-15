//
//  MissionJournalController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 14/11/22.
//

import SpriteKit

class MissionJournalController: SKScene {
        
    override func sceneDidLoad() {
        if let mission1Desc = childNode(withName: "mission1_desc") as? SKLabelNode{
            mission1Desc.preferredMaxLayoutWidth = 280
        }
    }
    
}
