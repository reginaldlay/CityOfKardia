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
        
//        addNode(imageName: "kota_jantung_bg", name: "kota_jantung_bg", widthSize: 2391, heightSize: 391, xPos: -773.5, yPos: -0.5, zPos: -3)
//        addNode(imageName: "kota_jantung_ground", name: "kota_jantung_ground", widthSize: 2391, heightSize: 143, xPos: -773.5, yPos: -123.5, zPos: -1)
//        addNode(imageName: "gate_kiri", name: "gate_kiri", widthSize: 152, heightSize: 152, xPos: 236, yPos: 4, zPos: -2)
//        addNode(imageName: "Erry_Idle_2", name: "player", widthSize: 75, heightSize: 100, xPos: -350, yPos: 3.1, zPos: 1)
//        addNode(imageName: "gate_kanan", name: "gate_kanan", widthSize: 152, heightSize: 152, xPos: 346, yPos: 4, zPos: 2)
//        addNode(imageName: "gatekeeper01", name: "gatekeeper01", widthSize: 165, heightSize: 165, xPos: 157.5, yPos: 17.5, zPos: 0)
    }
    
}

extension GateSerambiKananController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

extension GateSerambiKananController {
//    func addNode(imageName: String, name: String, widthSize: CGFloat, heightSize: CGFloat, xPos: CGFloat, yPos: CGFloat, zPos: CGFloat) {
//        let gateSerambiKananAsset = SKSpriteNode(imageNamed: imageName)
//        gateSerambiKananAsset.name = name
//        gateSerambiKananAsset.size = CGSize(width: widthSize, height: heightSize)
//        gateSerambiKananAsset.position = CGPoint(x: xPos, y: yPos)
//        gateSerambiKananAsset.zPosition = zPos
//        addChild(gateSerambiKananAsset)
//    }
}

extension GateSerambiKananController {
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
}
