//
//  PreArteriPulmonalisController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 16/11/22.
//

import SpriteKit

class PreArteriPulmonalisController: GameUIController {
    
    var validGatekeeper03 = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        CoreDataManager.shared.erryMission = 7
        
        dialogue.setupNewDictionary(newItem: ["arteri_pulmonalis"])
        CoreDataManager.shared.erryDictionary = 9
        
        changeOngoingMission(text: .pre_ap)
        
        // Add nama map
        addCameraChildNode(imageName: "lokasi_arteri_pulmonalis", name: "lokasi", widthSize: 200, heightSize: 92, xPos: 0, yPos: -(self.size.height/2) + (92/2))
        
        CoreDataManager.shared.checkpoint(locationName: "PreArteriPulmonalis")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "actionButton") {
                if inContact {
                    switch(npcIncontact) {
                    case "gatekeeper03":
                        showDialogue(assets: ext_pre_pulmonalis)
                        if (validGatekeeper03 == false) {
                            CoreDataManager.shared.erryMission = 8
                            
                            dialogue.showPopupNewDictionary(newWords: ["penggumpalan_darah"])
                            CoreDataManager.shared.erryDictionary = 10
                            
                            validGatekeeper03 = true
                        }
                        
                    default:
                        print("NPC not found")
                    }
                }
            }
        }
    }
    
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
  
        switch (bodyA, bodyB) {
        case ("player", "gatekeeper03"):
            contactWith(state: true, npcName: "gatekeeper03")
        case ("gatekeeper03", "player"):
            contactWith(state: true, npcName: "gatekeeper03")
            
        case ("player", "bound02"):
            if (CoreDataManager.shared.erryMission == 8) {
                moveScene(sceneName: "ArteriPulmonalisScene")
            }
        case ("bound02", "player"):
            if (CoreDataManager.shared.erryMission == 8) {
                moveScene(sceneName: "ArteriPulmonalisScene")
            }
            
        default: break
        }
    }
    
    override func didEnd(_ contact: SKPhysicsContact) {
        super.didEnd(contact)
        inContact = false
        npcIncontact = ""
        hideBubble(state: true)
    }
}
