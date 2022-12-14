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
    
    var validLeona = false
    var validSenior = false
    var validGatekeeper02 = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        CoreDataManager.shared.erryMission = 3
        
        dialogue.setupNewDictionary(newItem: ["bilik_kanan"])
        CoreDataManager.shared.erryDictionary = 4
        
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
        
        player?.playerStartingJumpImpulse = CGFloat(200)
        
        changeOngoingMission(text: .bk_masuk)
        
        addCameraChildNode(imageName: "lokasi_bilik_kanan", name: "lokasi", widthSize: 200, heightSize: 92, xPos: 0, yPos: -(self.size.height/2) + (92/2))
        
        CoreDataManager.shared.checkpoint(locationName: "BilikKanan")
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
                        showDialogue(assets: int_gate01)
                        boundLeona?.removeFromParent()
                        if (validLeona == false) {
                            CoreDataManager.shared.erryMission = 4
                            
                            dialogue.showPopupNewDictionary(newWords: ["sel_darah_putih"])
                            CoreDataManager.shared.erryDictionary = 5
                            
                            validLeona = true
                        }
                        
                    case "senior":
                        showDialogue(assets: int_guild)
                        boundSenior?.removeFromParent()
                        changeOngoingMission(text: .bk_guild)
                        if (validSenior == false) {
                            CoreDataManager.shared.erryMission = 5
                            
                            dialogue.showPopupNewDictionary(newWords: ["jantung", "peredaran_darah_kecil", "peredaran_darah_besar"])
                            CoreDataManager.shared.erryDictionary = 8
                            
                            validSenior = true
                        }
                        
                    case "gatekeeper02":
                        showDialogue(assets: int_gate02)
                        if (validGatekeeper02 == false) {
                            CoreDataManager.shared.erryMission = 6
                            validGatekeeper02 = true
                        }
                        
                    default: break
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
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
        
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
            
        case ("player", "bound02"):
            if (CoreDataManager.shared.erryMission == 6) {
                moveScene(sceneName: "PreArteriPulmonalisScene")
            }
        case ("bound02", "player"):
            if (CoreDataManager.shared.erryMission == 6) {
                moveScene(sceneName: "PreArteriPulmonalisScene")
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

//Update
extension BilikKananController {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let player = player {
            if(player.position.x > 0 && player.position.x < bound02!.position.x - 420 ) {
                self.camera?.position = CGPoint(x: player.position.x, y: 0)
            }  else if (player.position.x > bound02!.position.x - 420){
                self.camera?.position = CGPoint(x: bound02!.position.x - 420, y: 0)
            }
        }
        
    }
}

