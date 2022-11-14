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
    
    //Bubble Dialogue
    var bubble: SKNode?
    var tandaSeru: SKNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let unwrapLeona = childNode(withName: "leona"),
              let unwrapSenior = childNode(withName: "senior"),
              let unwrapGatekeeper = childNode(withName: "gatekeeper02"),
              let unwrapGateKiri = childNode(withName: "gate_kiri"),
              let unwrapBound01 = childNode(withName: "bound01"),
              let unwrapBound02 = childNode(withName: "bound02"),
              let unwrapBubble = childNode(withName: "bubble"),
              let unwrapTandaSeru = childNode(withName: "tandaSeru")
        else { return }
        
        leona = unwrapLeona
        senior = unwrapSenior
        gatekeeper01 = unwrapGatekeeper
        gateKiri = unwrapGateKiri
        bound01 = unwrapBound01
        bound02 = unwrapBound02
        bubble = unwrapBubble
        tandaSeru = unwrapTandaSeru
        
        hideBubble(state: true)
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
                        showDialogue(assets: int_guild)
                    case "gatekeeper02":
                        showDialogue(assets: int_gate02)
                        
                    default:
                        print("NPC not found")
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
            hideBubble(state: false)
            contactWith(state: true, npcName: "leona")
        case ("leona", "player"):
            hideBubble(state: false)
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
        
        inContact = false
        npcIncontact = ""
        
        print("body A begin: \(bodyA )")
        print("body B begin: \(bodyB )")
        
        switch (bodyA, bodyB) {
            
        case ("player", "leona"):
            hideBubble(state: true)
        case ("leona", "player"):
            hideBubble(state: true)
            
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

//Bubble Dialogue
extension BilikKananController {
    private func hideBubble(state: Bool) {
        bubble?.isHidden = state
        tandaSeru?.isHidden = state
        
        if !state {
            animateTandaSeru(tandaSeru: self.childNode(withName: "tandaSeru")!)
        } else {
            self.childNode(withName: "tandaSeru")!.removeAllActions()
        }
    }
    
    private func animateTandaSeru(tandaSeru: SKNode) {
        let left = SKAction.rotate(byAngle: CGFloat.pi/6, duration: 0.5) //30 degrees
        let right = SKAction.rotate(byAngle: -(CGFloat.pi/6), duration: 0.5)
        let sequence = SKAction.sequence([right, left])
        let repeated = SKAction.repeatForever(sequence)
        tandaSeru.run(repeated)
        
    }
}

