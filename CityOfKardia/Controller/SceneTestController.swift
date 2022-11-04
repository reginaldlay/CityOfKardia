//
//  SceneTestController.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 02/11/22.
//

import SpriteKit

class SceneTestController : GameUIController {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let unwrapNPC = childNode(withName: "gatekeeper_2"),
              let unwrapLogo = childNode(withName: "logo")
        else { return }
        
        NPC = unwrapNPC
        logo = unwrapLogo
    }
}
