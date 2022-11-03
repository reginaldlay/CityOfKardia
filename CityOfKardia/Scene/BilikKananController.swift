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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let unwrapLeona = childNode(withName: "leona"),
              let unwrapSenior = childNode(withName: "senior"),
              let unwrapGatekeeper = childNode(withName: "gatekeeper01"),
              let unwrapGateKiri = childNode(withName: "gate_kiri"),
              let unwrapBound01 = childNode(withName: "bound01")
        else { return }
        
        leona = unwrapLeona
        senior = unwrapSenior
        gatekeeper01 = unwrapGatekeeper
        gateKiri = unwrapGateKiri
        bound01 = unwrapBound01
    }
}

//Touch
extension BilikKananController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

//Contact antara objek
extension BilikKananController {
    override func didBegin(_ contact: SKPhysicsContact) {
        super.didBegin(contact)
    }

    override func didEnd(_ contact: SKPhysicsContact) {
        super.didEnd(contact)
    }
}

//Update
extension BilikKananController {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}

