//
//  IntroScene.swift
//  CityOfKardia
//
//  Created by Reginald Lay on 18/10/22.
//

import SpriteKit
import GameplayKit
import AVFoundation

class IntroController: SKScene {
    
    override func didMove(to view: SKView) {
        if let urlStr = Bundle.main.path(forResource: "IntroVideo", ofType: "mp4") {
            let url = NSURL(fileURLWithPath: urlStr)
            print(url)
            let videoPlayer = AVPlayer(url: url as URL)
            
            let introVideo = SKVideoNode(avPlayer: videoPlayer)
            introVideo.position = CGPoint(x: frame.midX, y: frame.midY)
            introVideo.size = CGSize(width: self.size.width, height: self.size.height)
            addChild(introVideo)
            
            introVideo.play()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let nextScene = SKScene(fileNamed: "GateSerambiKananScene") { //mau tanya mentor
            scene?.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene)
        }
    }
    
}
