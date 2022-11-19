//
//  TestSceneController.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 17/11/22.
//

import SpriteKit

extension GameUIController {
    
    func setupDictionary() {
        var xPos : CGFloat = -290
        var yPos : CGFloat = 70
        
        let upperFrame = SKSpriteNode(imageNamed: "dictFrameTop")
        let centerFrame = SKSpriteNode(imageNamed: "dictFrameCenter")
        let lowerFrame = SKSpriteNode(imageNamed: "dictFrameBottom")
        let dictCloseButton = SKSpriteNode(imageNamed: "red_book_close")
        
        dictCloseButton.zPosition = 102
        dictCloseButton.position = CGPoint(x: 380, y: 160)
        dictCloseButton.name = "dictCloseButton"
        
        moveableArea.position = CGPointMake(0, 0)
        self.camera?.addChild(moveableArea)
        
        upperFrame.zPosition = 101
        lowerFrame.zPosition = 101
        centerFrame.zPosition = 99
        
        upperFrame.position = CGPoint(x: 0, y: 162.5)
        centerFrame.position = CGPoint(x: 0, y: -13)
        lowerFrame.position = CGPoint(x: 0, y: -173.5)
        
        dict.addChild(upperFrame)
        dict.addChild(centerFrame)
        dict.addChild(lowerFrame)
        dict.addChild(dictCloseButton)
        
        dict.position = CGPoint(x: 0, y: 0)
        dict.zPosition = 100
        self.camera?.addChild(dict)
        
        for i in 1...13 {
            
            print(i)
            
            if (i % 3 == 0) {
                
                setupDictionaryItem(posX: xPos, posY: yPos, imageNo: i)
                
                xPos = -290
                yPos -= 120
                
            } else {
                
                setupDictionaryItem(posX: xPos, posY: yPos, imageNo: i)
                
                xPos += 100
                
            }
        }
        
        moveableArea.zPosition = 100
        
        menu.removeAllChildren()
        hideControl(state: true)
    }
    
    func setupDictionaryItem(posX: CGFloat, posY: CGFloat, imageNo: Int) {
        
        let imageName = parseDictImage(dictNo: imageNo)
        
        let item = SKNode()
        item.position = CGPoint(x: posX, y: posY)
        
        let itemFrame = SKSpriteNode(color: .white, size: CGSize(width: 80, height: 100))
        itemFrame.position = CGPoint(x: 0, y: 0)
        
        let itemImage = SKSpriteNode(imageNamed: imageName)
        itemImage.size = CGSize(width: 70, height: 70)
        itemImage.position = CGPoint(x: 0, y: 10)
        
        item.addChild(itemFrame)
        item.addChild(itemImage)
        item.name = String(imageNo)
        itemFrame.name = String(imageNo)
        itemImage.name = String(imageNo)
        
        itemFrame.zPosition = 100
        itemImage.zPosition = 100
        
        moveableArea.addChild(item)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x < 80 && location.x > -300 {
                
                // set the new location of touch
                let currentY = location.y

                // Set Top and Bottom scroll distances, measured in screenlengths
                let topLimit:CGFloat = 0.0
                let bottomLimit:CGFloat = 0.8

                // Set scrolling speed - Higher number is faster speed
                let scrollSpeed:CGFloat = 1.0

                // calculate distance moved since last touch registered and add it to current position
                let newY = moveableArea.position.y + ((currentY - lastY)*scrollSpeed)

                // perform checks to see if new position will be over the limits, otherwise set as new position
                if newY < self.size.height*(-topLimit) {
                    moveableArea.position = CGPointMake(moveableArea.position.x, self.size.height*(-topLimit))
                }
                else if newY > self.size.height*bottomLimit {
                    moveableArea.position = CGPointMake(moveableArea.position.x, self.size.height*bottomLimit)
                }
                else {
                    moveableArea.position = CGPointMake(moveableArea.position.x, newY)
                }

                // Set new last location for next time
                lastY = currentY
            }

        }

    }
    
}

extension GameUIController {
    func parseDictImage(dictNo: Int) -> String {
        switch (dictNo) {
        case 1: return "sel_darah_merah"
        case 2: return "serambi_kanan"
        case 3: return "gate_serambi_kanan"
        case 4: return "bilik_kanan"
        case 5: return "sel_darah_putih"
        case 6: return "jantung"
        case 7: return "peredaran_darah_kecil"
        case 8: return "peredaran_darah_besar"
        case 9: return "arteri_pulmonalis"
        case 10: return "penggumpalan_darah"
        case 11: return "kapiler"
        case 12: return "paru_paru"
        case 13: return "alveolus"
        default: return ""
        }
    }
    
    func parseDictContent(dictNo: Int) {
        let title = SKSpriteNode(imageNamed: "d_title_\(dictNo)")
        let text = SKSpriteNode(imageNamed: "d_text_\(dictNo)")
        
        title.position = CGPoint(x: 190, y: 115)
        text.position = CGPoint(x: 190, y: -25)
        
        self.dict.addChild(title)
        self.dict.addChild(text)
        
        dictTitle = title
        dictText = text
        
        dictTitle?.zPosition = 101
        dictText?.zPosition = 101
    }
    
    func removeDictContent() {
        dictTitle?.removeFromParent()
        dictText?.removeFromParent()
    }
    
}