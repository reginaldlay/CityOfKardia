//
//  GateSerambiKananController.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 04/11/22.
//

import SpriteKit
import GameplayKit

class GateSerambiKananController: GameUIController {
    
    var boundKanan: SKSpriteNode?
    
    var validGatekeeper01 = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        userDefault.set(true, forKey: "music")
        
        CoreDataManager.shared.erryMission = 1
        
        dialogue.setupNewDictionary(newItem: ["sel_darah_merah"])
        CoreDataManager.shared.erryDictionary = 1
        
        guard let unwrapBoundKanan = childNode(withName: "bound_kanan") as? SKSpriteNode
        else {
            return
        }
        boundKanan = unwrapBoundKanan
        
        player?.playerStartingJumpImpulse = CGFloat(200)
        
        changeOngoingMission(text: .gateSK_1)
        
        // Add nama map
        addCameraChildNode(imageName: "lokasi_serambi_kanan", name: "lokasi", widthSize: 200, heightSize: 92, xPos: 0, yPos: -(self.size.height/2) + (92/2))
        
        CoreDataManager.shared.checkpoint(locationName: "GateSerambiKanan")
        
    }
    
}

extension GateSerambiKananController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "actionButton") {
                switch (npcIncontact) {
                case ("gatekeeper01"):
                    showDialogue(assets: ext_gate01)
                    changeOngoingMission(text: .gateSK_2)
                    if (validGatekeeper01 == false) {
                        CoreDataManager.shared.erryMission = 2
                        
                        dialogue.showPopupNewDictionary(newWords: ["serambi_kanan", "gate_serambi_kanan"])
                        CoreDataManager.shared.erryDictionary = 3
                        
                        validGatekeeper01 = true
                    }
                    
                default: break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
}

extension GateSerambiKananController {
    
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        
        guard let bodyA = contact.bodyA.node?.name,
              let bodyB = contact.bodyB.node?.name
        else {
            return
        }
        
        switch (bodyA, bodyB) {
        case ("player", "bound_kanan"):
            if (CoreDataManager.shared.erryMission == 2) {
                moveScene(sceneName: "BilikKananScene")
            }
            
        case ("bound_kanan", "player"):
            if (CoreDataManager.shared.erryMission == 2) {
                moveScene(sceneName: "BilikKananScene")
            }
            
        case ("player", "gatekeeper01"):
            contactWith(state: true, npcName: "gatekeeper01")
        case ("gatekeeper01", "player"):
            contactWith(state: true, npcName: "gatekeeper01")
            
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

extension GateSerambiKananController {
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if let player = player {
            if (player.position.x > 0 && player.position.x < boundKanan!.position.x - 410 ) {
                self.camera?.position = CGPoint(x: player.position.x, y: 0)
            }
            else if (player.position.x > boundKanan!.position.x - 410){
                self.camera?.position = CGPoint(x: boundKanan!.position.x - 410, y: 0)
            }
        }
    }
    
}
