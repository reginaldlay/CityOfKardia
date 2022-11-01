//
//  DialogueBox.swift
//  studySpriteKit
//
//  Created by Vincensa Regina on 27/10/22.
//

import SpriteKit

class DialogueBox: SKNode {
    
    var image: SKSpriteNode!
    var label: SKLabelNode!
    var box: SKSpriteNode!
    var name_box: SKSpriteNode!
    var arrow: SKSpriteNode!
    var image_background: SKSpriteNode!
    var name_label: SKLabelNode!
    
    var dialogueAtlas = SKTextureAtlas(named:"Dialogue");
    
    var count = 1
    var dialogue_assets: [Dialogue] = []
    
    //Typing Label Effect
    var arrLabel: [Character] = []
    var countType = 0
    var timer : Timer?
    var typing = false
    
    
    public func createDialogueNode () {
        createSprite(texture: "dialogue-box", xPos: 23.7, yPos: -115.14, zPos: 3, width: 718, height: 98, name: "box")
        createSprite(texture: "dialogue-image-bg", xPos: -335.3, yPos: -115.14, zPos: 10, width: 98, height: 98, name: "image_background")
        createSprite(texture: "", xPos: -335.5, yPos: -106.3, zPos: 12, width: 90, height: 83, name: "image")
        createSprite(texture: "", xPos: -335.025, yPos: -149.5, zPos: 13, width: 90, height: 23, name: "name_box")
        createSprite(texture: "dialogue-arrow", xPos: 342, yPos: -149.144, zPos: 13, width: 36, height: 30, name: "arrow")
        
        createLabel(text: "Dialogue text", xPos: -264.9, yPos: -80, zPos: 14, maxLayout: 600, lineAmount: 3, horizontal: .left, vertical: .top, name: "label", fontSize: 17)
        
        hideDialogue(state: true)
        startDialogue(dialogue_assets: ext_gate01)
    }
    
    public func refSprite(name: String) -> SKSpriteNode {
        return self.childNode(withName: name) as! SKSpriteNode
    }
    public func refLabel(name: String) -> SKLabelNode {
        return self.childNode(withName: name) as! SKLabelNode
    }
    
    public func createSprite(texture: String, xPos: Double, yPos: Double, zPos: CGFloat, width: CGFloat, height: CGFloat, name: String) {
        let node = SKSpriteNode(texture: dialogueAtlas.textureNamed(texture));
        node.name = name
        node.position = CGPoint(x: xPos, y: yPos)
        node.zPosition = CGFloat(zPos)
        node.size = CGSize(width: width, height: height)
        self.addChild(node)
    }
    
    public func createLabel(text: String, xPos: Double, yPos: Double, zPos: CGFloat, maxLayout: CGFloat, lineAmount: Int, horizontal: SKLabelHorizontalAlignmentMode, vertical: SKLabelVerticalAlignmentMode, name: String, fontSize: Int) {
        let node = SKLabelNode(text: text);
        node.name = name
        node.position = CGPoint(x: xPos, y: yPos)
        node.zPosition = CGFloat(zPos);
        node.horizontalAlignmentMode = horizontal
        node.verticalAlignmentMode = vertical
        node.preferredMaxLayoutWidth = maxLayout
        node.lineBreakMode = .byTruncatingTail
        node.numberOfLines = lineAmount;
        node.fontSize = CGFloat(fontSize)
        node.fontColor = .black
        node.fontName = "SF-Pro"
        self.addChild(node)
    }
    
    public func startDialogue (dialogue_assets: [Dialogue]) {
        self.dialogue_assets = dialogue_assets
        hideDialogue(state: false)
        changeDialogue(count: 0, dialogue_assets: dialogue_assets)
    }
    
    private func hideDialogue (state: Bool) {
        refSprite(name: "image").isHidden = state
        refLabel(name: "label").isHidden = state
        refSprite(name: "box").isHidden = state
        refSprite(name: "image_background").isHidden = state
        refSprite(name: "arrow").isHidden = state
//        refLabel(name: "name_label").isHidden = state
        refSprite(name: "name_box").isHidden = state
        
        if !state {
            animateArrow(arrow: refSprite(name: "arrow"))
        } else {
            refSprite(name: "arrow").removeAllActions()
        }
    }
    
    private func changeDialogue(count: Int, dialogue_assets: [Dialogue]) {
        arrLabel = Array(dialogue_assets[count].label ?? "")

        refLabel(name: "label").text = "" // Empty Label
        refSprite(name: "image").texture = SKTexture(imageNamed: dialogue_assets[count].image ?? "")
        refSprite(name: "name_box").texture = SKTexture(imageNamed: dialogue_assets[count].name ?? "")
        
        typeLetter()
        
    }
    
    @objc private func typeLetter(){
        if countType < arrLabel.count {
            typing = true
            refLabel(name: "label").text = (refLabel(name:"label").text!) + String(arrLabel[countType])
            
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(DialogueBox().typeLetter), userInfo: nil, repeats: false)
            countType += 1

        } else {
            stopTyping()
        }
    }
    
    private func stopTyping() {
        timer?.invalidate() // stop the timer
        typing = false
        countType = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !refSprite(name: "box").isHidden {
            if count < dialogue_assets.count {
                if typing {
                    stopTyping()
                    refLabel(name: "label").text = dialogue_assets[count-1].label
                } else {
                    changeDialogue(count: count, dialogue_assets: dialogue_assets)
                    count+=1
                }
            }
            else {
                if !typing {
                    hideDialogue(state: true)
                    count = 0
                } else {
                    stopTyping()
                    refLabel(name: "label").text = dialogue_assets[count-1].label
                }

            }
        }
    }
    public func touchDialogue () {
        if !box.isHidden {
            if count < dialogue_assets.count {
                if typing {
                    stopTyping()
                    refLabel(name: "label").text = dialogue_assets[count-1].label
                } else {
                    changeDialogue(count: count, dialogue_assets: dialogue_assets)
                    count+=1
                }
            }
            else {
                if !typing {
                    hideDialogue(state: true)
                    count = 0
                } else {
                    stopTyping()
                    refLabel(name: "label").text = dialogue_assets[count-1].label
                }
               
            }
        }
    }
    
    private func animateArrow (arrow: SKSpriteNode) {
        let up = SKAction.moveBy(x: 0, y: 10, duration: 0.2)
        let down =  SKAction.moveBy(x: 0, y: -10, duration: 0.2)
        let sequence = SKAction.sequence([up, down])
        let repeated = SKAction.repeatForever(sequence)
        arrow.run(repeated)
    }
}
