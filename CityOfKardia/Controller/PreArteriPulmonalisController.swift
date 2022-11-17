//
//  PreArteriPulmonalisController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 16/11/22.
//

import SpriteKit

class PreArteriPulmonalisController: GameUIController {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        changeOngoingMission(text: .pre_ap)
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
                        dialogue.showPopupNewDictionary(newWord: "penggumpalan_darah")
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
            moveScene(sceneName: "ArteriPulmonalisScene")
        case ("bound02", "player"):
            moveScene(sceneName: "ArteriPulmonalisScene")
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
