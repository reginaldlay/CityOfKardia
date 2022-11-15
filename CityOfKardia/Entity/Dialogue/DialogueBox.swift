//
//  DialogueBox.swift
//  studySpriteKit
//
//  Created by Vincensa Regina on 27/10/22.
//

import SpriteKit
import AVFoundation

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
    var dialogueBefore = "" //Untuk keperluan change dialogue (count-1)
    
    //Typing Label Effect
    var arrLabel: [Character] = []
    var countType = 0
    var timer : Timer?
    var typing = false
    
    //Dialogue Visibility
    var dialogueVisibility = false
    var riddle: SKReferenceNode!
    var riddleVisibility = false
    
    let typingSFX = SKAudioNode(fileNamed: "typingSFX")
    
    
    public func createDialogueNode () {
        createSprite(texture: "dialogue-box", xPos: 23.7, yPos: -115.14, zPos: 3, width: 796, height: 98, name: "box")
        createSprite(texture: "dialogue-image-bg", xPos: -335.3, yPos: -115.14, zPos: 10, width: 98, height: 98, name: "image_background")
        createSprite(texture: "", xPos: -335.5, yPos: -106.3, zPos: 12, width: 90, height: 83, name: "image")
        createSprite(texture: "", xPos: -335.025, yPos: -149.5, zPos: 13, width: 90, height: 23, name: "name_box")
        createSprite(texture: "dialogue-arrow", xPos: 342, yPos: -149.144, zPos: 13, width: 28, height: 20, name: "arrow")
        
        createLabel(text: "Dialogue text", xPos: -264.9, yPos: -80, zPos: 14, maxLayout: 600, lineAmount: 3, horizontal: .left, vertical: .top, name: "label", fontSize: 17)
        hideDialogue(state: true)
        
        typingSFX.run(.changeVolume(to: 0, duration: 0))
        self.addChild(typingSFX)
        typingSFX.run(.stop())
    }
    
    public func refSprite(name: String) -> SKSpriteNode {
        if let node = self.childNode(withName: name) as? SKSpriteNode {
            return node
        };
        return SKSpriteNode(imageNamed: "logo.png")
    }
    public func refLabel(name: String) -> SKLabelNode {
        if let node = self.childNode(withName: name) as? SKLabelNode {
            return node
        }
        return SKLabelNode(text: "No label found")
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
        refSprite(name: "name_box").isHidden = state
        
        if !state {
            animateArrow(arrow: refSprite(name: "arrow"))
        } else {
            refSprite(name: "arrow").removeAllActions()
        }
    }
    
    private func changeDialogue(count: Int, dialogue_assets: [Dialogue]) {
        arrLabel = Array(dialogue_assets[count].label ?? "")
        
        dialogueBefore = dialogue_assets[count].label ?? "Empty String"
        
        refLabel(name: "label").text = "" // Empty Label
        refSprite(name: "image").texture = SKTexture(imageNamed: dialogue_assets[count].image ?? "")
        refSprite(name: "name_box").texture = SKTexture(imageNamed: dialogue_assets[count].name ?? "")
        
        typeLetter()
        
        if (dialogue_assets[count].riddle && !riddleVisibility) {
            riddle = SKReferenceNode(fileNamed: "Riddle")!
            self.addChild(riddle)
            riddleVisibility = true
        }
    }
    private func changeSpecificDialogueLabel(dialogue: String) {
        arrLabel = Array(dialogue)
        refLabel(name: "label").text = "" // Empty Label
        typeLetter()
    }
    
    @objc private func typeLetter(){
        if countType < arrLabel.count {
            
            typingSFX.run(.changeVolume(to: 0.3, duration: 0.5))
            typingSFX.run(.play())
            
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
        typingSFX.run(.stop())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !refSprite(name: "box").isHidden {
            var wrongChoice = false
            
            if typing {
                stopTyping()
                refLabel(name: "label").text = dialogueBefore
            } else if(!riddleVisibility && !typing) {
                if count < dialogue_assets.count {
                    changeDialogue(count: count, dialogue_assets: dialogue_assets)
                    count+=1
                }
                else {
                    hideDialogue(state: true)
                    dialogueVisibility = false
                    count = 1
                    dialogueBefore = dialogue_assets[count-1].label ?? "Empty string"
                }
            } else if (riddleVisibility && !wrongChoice) {
                for touch in touches {
                    let location = touch.location(in: self)
                    let node = self.atPoint(location)
                    
                    if (node.name == "optPD") {
                        let rightResponse = "Hebat sekali, anak muda sepertimu sungguh berbakat! Ambillah ini karena kamu telah menjawabnya dengan benar."
                        changeSpecificDialogueLabel(dialogue: rightResponse)
                        dialogueBefore = rightResponse
                        
                        riddleVisibility = false
                        wrongChoice = false
                        riddle.removeFromParent()
                    }
                    else if (node.name == "optSDM" || node.name == "optSDP" || node.name == "optTrombosit"){
                        refLabel(name: "label").text = "Jawabanmu kurang tepat, coba lagi."
                        wrongChoice = true
                    }
                }
            } else if (riddleVisibility && wrongChoice) {
                changeDialogue(count: count-1, dialogue_assets: dialogue_assets)
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