//
//  SceneBilikKananController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 03/11/22.
//

import SpriteKit

class BilikKananController: GameUIController {
    var leona: SKNode?
    var senior: SKNode?
    var gatekeeper01: SKNode?
    var gateKiri: SKNode?
    
    var bound01: SKNode?
    var bound02: SKNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let unwrapLeona = childNode(withName: "leona"),
              let unwrapSenior = childNode(withName: "senior"),
              let unwrapGatekeeper = childNode(withName: "gatekeeper01"),
              let unwrapGateKiri = childNode(withName: "gate_kiri"),
              let unwrapBound01 = childNode(withName: "bound01"),
              let unwrapBound02 = childNode(withName: "bound02")
        else { return }
        
        leona = unwrapLeona
        senior = unwrapSenior
        gatekeeper01 = unwrapGatekeeper
        gateKiri = unwrapGateKiri
        bound01 = unwrapBound01
        bound02 = unwrapBound02
    }
}

//Touch
extension BilikKananController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "actionButton") {
                if inContact {
                    switch(npcIncontact) {
                    case "leona":
                        //IF BELUM PERNAH MASUK KE DIALOGNYA
                       showDialogue(assets: int_gate01)
                    case "senior":
                        //IF BELUM PERNAH MASUK KE DIALOGNYA
                       showDialogue(assets: int_gate01)
                    case "gatekeeper02":
                        let riddle = SKReferenceNode(fileNamed: "Riddle")!
                        dialogue.addChild(riddle)
                        
                       showDialogue(assets: int_gate01)
                        
                    default:
                        print("nope gaada ehhe")
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

//Contact dengan NPC
extension BilikKananController {
    func didBegin(_ contact: SKPhysicsContact) {
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        print("body A begin: \(bodyA )")
        print("body B begin: \(bodyB )")
        
        switch (bodyA, bodyB) {
            
        case ("player", "leona"):
            contactWith(state: true, npcName: "leona")
        case ("leona", "player"):
            contactWith(state: true, npcName: "leona")
            
        case ("player", "senior"):
            contactWith(state: true, npcName: "senior")
        case ("senior", "player"):
            contactWith(state: true, npcName: "senior")
            
        case ("player", "gatekeeper02"):
            contactWith(state: true, npcName: "gatekeeper02")
        case ("gatekeeper02", "player"):
            contactWith(state: true, npcName: "gatekeeper02")

        default: break
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
        print("body A end: \(bodyA )")
        print("body B end: \(bodyB )")
        
        inContact = false
        npcIncontact = ""
    }
}

//Update
extension BilikKananController {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
//        if let player = player {
//            if(player.position.x > 0 && player.position.x < bound02!.position.x - 420 ) {
//                self.camera?.position = player.position
//            }
//        }
        
    }
}

