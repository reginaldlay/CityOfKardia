//
//  GateParuParuController.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 13/11/22.
//

import SpriteKit
import GameplayKit

class GateParuParuController: GameUIController {
    
    var boundKanan: SKSpriteNode?
    
    var validGatekeeper04 = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        CoreDataManager.shared.erryMission = 9
        
        dialogue.setupNewDictionary(newItem: ["paru_paru"])
        CoreDataManager.shared.erryDictionary = 12
        
        guard let unwrapBoundKanan = childNode(withName: "bound_kanan") as? SKSpriteNode
        else {
            return
        }
        boundKanan = unwrapBoundKanan
        
        player?.playerStartingJumpImpulse = CGFloat(200)
        
        changeOngoingMission(text: .gateP_1)
        
        // Add nama map
        addCameraChildNode(imageName: "lokasi_paru", name: "lokasi", widthSize: 200, heightSize: 92, xPos: 0, yPos: -(self.size.height/2) + (92/2))
        
        CoreDataManager.shared.checkpoint(locationName: "GateParuParu")
    }
    
}

extension GateParuParuController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "actionButton") {
                switch (npcIncontact) {
                case ("gatekeeper04"):
                    showDialogue(assets: ext_gate03)
                    changeOngoingMission(text: .gateP_2)
                    if (validGatekeeper04 == false) {
                        CoreDataManager.shared.erryMission = 10
                        
                        dialogue.showPopupNewDictionary(newWords: ["alveolus"])
                        CoreDataManager.shared.erryDictionary = 13
                        
                        validGatekeeper04 = true
                    }
                    
                case ("gedung_alveolus_4"):
                    if (CoreDataManager.shared.erryMission == 10) {
                        moveScene(sceneName: "AlveolusScene")
                    }
                    
                default:
                    print("EHHE")
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
}

extension GateParuParuController {
    
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        
        guard let bodyA = contact.bodyA.node?.name,
              let bodyB = contact.bodyB.node?.name
        else {
            return
        }
        
        print("Body A begin: \(bodyA)")
        print("Body B begin: \(bodyB)")
        
        switch (bodyA, bodyB) {
        case ("player", "gatekeeper04"):
            contactWith(state: true, npcName: "gatekeeper04")
            
        case ("gatekeeper04", "player"):
            contactWith(state: true, npcName: "gatekeeper04")
            
        case ("player", "gedung_alveolus_4"):
            npcIncontact = "gedung_alveolus_4"
            
        case ("gedung_alveolus_4", "player"):
            npcIncontact = "gedung_alveolus_4"
            
        default: break
        }
    }
    
    override func didEnd(_ contact: SKPhysicsContact) {
        super.didEnd(contact)
        
        npcIncontact = ""
    }
    
}

extension GateParuParuController {
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if let player = player {
            if (player.position.x > 0 && player.position.x < boundKanan!.position.x - 422 ) {
                self.camera?.position = CGPoint(x: player.position.x, y: 0)
            }
            else if (player.position.x > boundKanan!.position.x - 422){
                self.camera?.position = CGPoint(x: boundKanan!.position.x - 422, y: 0)
            }
        }
    }
    
}
