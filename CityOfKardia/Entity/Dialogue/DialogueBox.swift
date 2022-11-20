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
    
    //Audio Typing
    let typingSFX = SKAudioNode(fileNamed: "typingSFX")
    
    //New Dictionary
    var newDictionary: SKReferenceNode?
    var newWords: [String] = []
    var countCurrentWord = 1
    
    
    public func createDialogueNode () {
        createSprite(texture: "dialogue-box", xPos: 0, yPos: -118.14, zPos: 3, width: 796, height: 135, name: "box")
        createSprite(texture: "", xPos: -335.5, yPos: -106.3, zPos: 12, width: 85, height: 85, name: "image")
        createSprite(texture: "", xPos: -336.025, yPos: -149.5, zPos: 13, width: 90, height: 23, name: "name_box")
        createSprite(texture: "dialogue-arrow", xPos: 342, yPos: -149.144, zPos: 13, width: 28, height: 20, name: "arrow")
        
        createLabel(text: "Dialogue text", xPos: -264.9, yPos: -80, zPos: 14, maxLayout: 600, lineAmount: 3, horizontal: .left, vertical: .top, name: "label", fontSize: 17)
        hideDialogue(state: true)
        
        typingSFX.name = "typingSFX"
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
        //        refSprite(name: "image_background").isHidden = state
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
        
        self.addChild(typingSFX)
        typingSFX.run(.changeVolume(to: 0.3, duration: 0))
        
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
        childNode(withName: "typingSFX")?.removeFromParent()
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
                } else {
                    hideDialogue(state: true)
                    count = 1
                    dialogueBefore = dialogue_assets[count-1].label ?? "Empty string"
                    
                    //Pop up new dictionary
                    if (newWords != []) {
                        print("new Word \(newWords)")
                        setupNewDictionary(newItem: newWords)
                    }
                    dialogueVisibility = false

                }
            } else if (riddleVisibility && !wrongChoice) {
                for touch in touches {
                    let location = touch.location(in: self)
                    let node = self.atPoint(location)
                    
                    if (node.name == "optPD" || node.name == "labelPD") {
                        let rightResponse = "Hebat sekali, anak muda sepertimu sungguh berbakat!"
                        changeSpecificDialogueLabel(dialogue: rightResponse)
                        dialogueBefore = rightResponse
                        
                        riddleVisibility = false
                        wrongChoice = false
                        riddle.removeFromParent()
                    }
                    else if (node.name == "optSDM" || node.name == "labelSDM" || node.name == "optSDP" || node.name == "labelSDP" || node.name == "optTrombosit" || node.name == "labelTrombosit"){
                        refLabel(name: "label").text = "Jawabanmu kurang tepat, coba lagi."
                        wrongChoice = true
                    }
                }
            } else if (riddleVisibility && wrongChoice) {
                changeDialogue(count: count-1, dialogue_assets: dialogue_assets)
            }
            //New Dictionary
        } else {
            for touch in touches {
                let location = touch.location(in: self)
                let node = self.atPoint(location)
                switch node.name {
                case "newdict_continue":
                    newDictionary?.removeFromParent()
                    newWords = []
                case "newdict_leftArrow":
                    if (countCurrentWord > 1) {
                        countCurrentWord-=1
                        changeNewDictionaryData(data: newWords[countCurrentWord-1])
                    }
                case "newdict_rightArrow":
                    if (countCurrentWord < newWords.count) {
                        countCurrentWord+=1
                        changeNewDictionaryData(data: newWords[countCurrentWord-1])
                    }
                default:
                    break
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

extension DialogueBox {
    // New Dictionary
    public func setupNewDictionary(newItem: [String]) {
        self.newWords = newItem
        if let unwrapNewDictionary = SKReferenceNode(fileNamed: "NewDictionary") {
            unwrapNewDictionary.name = "NewDictionary"
            self.addChild(unwrapNewDictionary)
         
            changeNewDictionaryData(data: newItem[0])
            newDictionary = unwrapNewDictionary
            
        } else {
            print("Error init new dictionary!")
        }
    }
    
    public func showPopupNewDictionary(newWords: [String]) {
        self.newWords = newWords
    }
    
    //Change image and label
    public func changeNewDictionaryData(data: String) {
        let refChildren = childNode(withName: "NewDictionary")?.children.first
        if let image = refChildren?.childNode(withName: "newdict_image") as? SKSpriteNode {
            image.texture = SKTexture(imageNamed: data)
        }
        if let label = refChildren?.childNode(withName: "newdict_label") as? SKLabelNode {
            label.text = getDictionaryItem(key: data)
            print("label text \(getDictionaryItem(key: data))")
        }
        if let leftArrow = refChildren?.childNode(withName: "newdict_leftArrow") as? SKSpriteNode {
            if countCurrentWord > 1 {
                leftArrow.texture = SKTexture(imageNamed: "red_newdict_leftArrow")
            } else {
                leftArrow.texture = SKTexture(imageNamed: "newdict_leftArrow_disabled")
            }
        }
        
        if let rightArrow = refChildren?.childNode(withName: "newdict_rightArrow") as? SKSpriteNode {
            if countCurrentWord < newWords.count {
                rightArrow.texture = SKTexture(imageNamed: "red_newdict_rightArrow")
            } else {
                rightArrow.texture = SKTexture(imageNamed: "newdict_rightArrow_disabled")
            }
        }
    }
}
