//
//  GateSerambiKananController.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 04/11/22.
//

import SpriteKit
import GameplayKit

class GateSerambiKananController: GameUIController {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
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

extension GateSerambiKananController {
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyA = contact.bodyA.node?.name,
              let bodyB = contact.bodyB.node?.name
        else {
            return
        }
        
        print("Body A begin: \(bodyA)")
        print("Body B begin: \(bodyB)")
        
        switch (bodyA, bodyB) {
        case ("player", "bound_kiri"):
            npcIncontact = "bound_kiri"
            
        case ("bound_kiri", "player"):
            npcIncontact = "bound_kiri"
            
        case ("player", "bound_kanan"):
            npcIncontact = "bound_kanan"
            
        case ("bound_kanan", "player"):
            npcIncontact = "bound_kanan"
            
        case ("player", "gatekeeper01"):
            npcIncontact = "gatekeeper01"
            
        case ("gatekeeper01", "player"):
            npcIncontact = "gatekeeper01"
            
        default: break
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        npcIncontact = ""
    }
    
}

extension GateSerambiKananController {
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
}
