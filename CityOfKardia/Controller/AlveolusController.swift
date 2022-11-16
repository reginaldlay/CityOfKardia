//
//  AlveolusController.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 17/11/22.
//

import SpriteKit

class AlveolusController : GameUIController {
    
    var boundKanan: SKNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if let unwrapBoundKanan = childNode(withName: "bound02") {
            boundKanan = unwrapBoundKanan
        }
        
        player?.playerStartingJumpImpulse = CGFloat(200)
        
//        CoreDataManager.shared.checkpoint(locationName: "Alveolus")

    }
    
}

extension AlveolusController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if (node.name == "actionButton") {
                switch (npcIncontact) {
                    
                case ("machine")    : print(node.name)
                    
                case ("teller")     : showDialogue(assets: int_alveolus)
                    
                default: break
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
}

extension AlveolusController {
    
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
        
        guard
            let bodyA = contact.bodyA.node?.name,
            let bodyB = contact.bodyB.node?.name
        else { return }
    
        switch (bodyA, bodyB) {
            
        case ("player", "teller"):
            contactWith(state: true, npcName: "teller")
        case ("teller", "player"):
            contactWith(state: true, npcName: "teller")
            
        case ("player", "machine"): break
        case ("machine", "player"): break
            
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

extension AlveolusController {
    
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
