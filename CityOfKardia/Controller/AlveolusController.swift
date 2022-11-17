//
//  AlveolusController.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 17/11/22.
//

import SpriteKit

class AlveolusController : GameUIController {
    
    var boundKanan: SKNode?
    var puzzle = Puzzle()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        if let unwrapBoundKanan = childNode(withName: "bound02") {
            boundKanan = unwrapBoundKanan
        }
        
        player?.playerStartingJumpImpulse = CGFloat(200)
        
        CoreDataManager.shared.checkpoint(locationName: "Alveolus")
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
                    
                case ("machine")    :
                    self.camera?.addChild(puzzle)
                    puzzle.setupPuzzle()
                    hideControl(state: true)
                case ("teller")     : showDialogue(assets: int_alveolus)
                    
                default: break
                }
            }
            
            if node.name == "exitButton" {

            }
            
            if !puzzle.winFlag {
                switch node.name {
                case "cable0": puzzle.rotateByHalfPi(node: node)
                case "cable1": puzzle.rotateByHalfPi(node: node)
                case "cable2": puzzle.rotateByHalfPi(node: node)
                case "cable3": puzzle.rotateByHalfPi(node: node)
                case "cable4": puzzle.rotateByHalfPi(node: node)
                case "cable5": puzzle.rotateByHalfPi(node: node)
                case "cable6": puzzle.rotateByHalfPi(node: node)
                case "cable7": puzzle.rotateByHalfPi(node: node)
                case "cable8": puzzle.rotateByHalfPi(node: node)
                case "cable9": puzzle.rotateByHalfPi(node: node)
                case "cable10": puzzle.rotateByHalfPi(node: node)
                case "cable11": puzzle.rotateByHalfPi(node: node)
                case "cable12": puzzle.rotateByHalfPi(node: node)
                case "cable13": puzzle.rotateByHalfPi(node: node)
                    default: break
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node.name == "exitButton" {
                puzzle.removeFromParent()
                hideControl(state: false)
            }
        }
        
        for touch in touches {
            let location = touch.location(in: self.puzzle)
            let node = self.atPoint(location)
            
            puzzle.winFlag = puzzle.checkWinCondition()
        }

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
            
        case ("player", "machine"): npcIncontact = "machine"
        case ("machine", "player"): npcIncontact = "machine"
            
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
