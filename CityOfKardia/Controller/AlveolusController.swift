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
    var winState = false
    
    var validTeller = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        CoreDataManager.shared.erryMission = 11
        
        if let unwrapBoundKanan = childNode(withName: "bound02") {
            boundKanan = unwrapBoundKanan
        }
        
        if let unwrapLeftWall = childNode(withName: "leftWall") {
            unwrapLeftWall.zPosition = -1
        }
        
        player?.playerStartingJumpImpulse = CGFloat(200)
        
        changeOngoingMission(text: .alveolus_1)
        
        // Add nama map
        addCameraChildNode(imageName: "lokasi_alveolus", name: "lokasi", widthSize: 200, heightSize: 92, xPos: 0, yPos: -(self.size.height/2) + (92/2))
        
        CoreDataManager.shared.checkpoint(locationName: "Alveolus")
        
        self.camera?.addChild(puzzle)
        puzzle.setupPuzzle()
        
        puzzle.isHidden = true
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
                    
                case ("machine"):
                    if (CoreDataManager.shared.erryMission == 12) {
                        puzzle.isHidden = false
                        hideControl(state: true)
                    }

                case ("teller"):
                    
                    if (CoreDataManager.shared.erryMission == 13) {
                        showDialogue(assets: int_alveolus_puzzle_solved)
                        CoreDataManager.shared.erryMission = 14
                        changeOngoingMission(text: .alveolus_3)

                    } else {
                        showDialogue(assets: int_alveolus)
                        changeOngoingMission(text: .alveolus_2)
                    }
                    
                    if (validTeller == false) {
                        CoreDataManager.shared.erryMission = 12
                        validTeller = true
                    }
                    
                  
                    
                default: break
                }
            }
            
            if node.name == "exitButton" {

            }
            
            if !winState {
                
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
                
                winState = puzzle.checkWinCondition()
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if node.name == "exitButton" {
                
                if winState {
                    changeOngoingMission(text: .alveolus_4)
                    CoreDataManager.shared.erryMission = 13
                }
                
                puzzle.isHidden = true
                hideControl(state: false)
            }
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
            
        case ("player", "machine"):
            npcIncontact = "machine"
        case ("machine", "player"):
            npcIncontact = "machine"
            
        case ("player", "bound02"):
            if (CoreDataManager.shared.erryMission == 14) {
                moveScene(sceneName: "EndingScene")
            }
            
        case ("bound02", "player"):
            if (CoreDataManager.shared.erryMission == 14) {
                moveScene(sceneName: "EndingScene")
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
