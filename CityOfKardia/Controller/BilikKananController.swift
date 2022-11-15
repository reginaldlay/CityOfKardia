//
//  SceneBilikKananController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 03/11/22.
//

import SpriteKit

class BilikKananController: GameUIController {
    var leona: SKSpriteNode?
    var senior: SKSpriteNode?
    var gatekeeper01: SKSpriteNode?
    var gateKiri: SKSpriteNode?
    
    var bound01: SKSpriteNode?
    var bound02: SKSpriteNode?
    var boundLeona: SKSpriteNode?
    var boundSenior: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //Give scene a name
        if let view = self.view as? SKView {
            if let currentScene = view.scene {
                currentScene.name = "BilikKananScene"
            } else {
                print("Current scene is nil")
            }
        }
        
        guard let unwrapLeona = childNode(withName: "leona") as? SKSpriteNode,
              let unwrapSenior = childNode(withName: "senior") as? SKSpriteNode,
              let unwrapGatekeeper = childNode(withName: "gatekeeper02") as? SKSpriteNode,
              let unwrapGateKiri = childNode(withName: "gate_kiri") as? SKSpriteNode,
              let unwrapBound01 = childNode(withName: "bound01") as? SKSpriteNode,
              let unwrapBound02 = childNode(withName: "bound02") as? SKSpriteNode,
              let unwrapBoundLeona = childNode(withName: "boundLeona") as? SKSpriteNode,
              let unwrapBoundSenior = childNode(withName: "boundSenior") as? SKSpriteNode
        else { return }
        
        leona = unwrapLeona
        senior = unwrapSenior
        gatekeeper01 = unwrapGatekeeper
        gateKiri = unwrapGateKiri
        bound01 = unwrapBound01
        bound02 = unwrapBound02
        boundLeona = unwrapBoundLeona
        boundSenior = unwrapBoundSenior
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
                        boundLeona?.removeFromParent()
                    case "senior":
                        //IF BELUM PERNAH MASUK KE DIALOGNYA
                        showDialogue(assets: int_guild)
                        boundSenior?.removeFromParent()
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
        
        inContact = false
        npcIncontact = ""
        hideBubble(state: true)

        print("body A begin: \(bodyA )")
        print("body B begin: \(bodyB )")
    
    }
}

//Update
extension BilikKananController {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
                if let player = player {
                    if(player.position.x > 0 && player.position.x < bound02!.position.x - 420 ) {
                        self.camera?.position = player.position
                    }
                }

    }
}

