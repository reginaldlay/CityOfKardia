//
//  IntroScene.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 18/10/22.
//

import SpriteKit
import GameplayKit

class IntroController: SKScene {
    //tbc
    
    //Dialogue
    let dialogue = DialogueBox();
    var dialogueVisibility = false;
    
    let cam = SKCameraNode();
    
    override func didMove(to view: SKView) {
        self.camera = cam
        self.addChild(self.camera!)
        self.camera!.zPosition = 50;
        self.camera!.addChild(dialogue)
        
        dialogue.createDialogueNode()
        dialogueVisibility = true;
        dialogue.startDialogue(dialogue_assets: ext_gate01)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (dialogueVisibility) {
            dialogue.touchesBegan(touches, with: event);
        }
    }
    
}
