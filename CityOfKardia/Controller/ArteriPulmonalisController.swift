//
//  ArteriPulmonalisController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 15/11/22.
//

import SpriteKit

class ArteriPulmonalisController: GameUIController {
    var playerInitPos = CGPoint(x: 0, y: 0) //apabila player jatuh -> ulang ke posisi awal
    var xPosCamera: Double = 0
    var yPosCamera: Double = 0
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        playerInitPos = player?.position ?? CGPoint(x: 0, y: 0)
        print(playerInitPos)
        xPosCamera = 680
//        print(abs(playerInitPos.x))
        yPosCamera = 300
        camera?.run(SKAction.scale(to: 2.5, duration: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        if let player = player {
            // Kamera
            //Kalau jatuh (diminus 1 supaya aman ga masuk sini apabila di posisi normal)
//            if (player.position.y < playerInitPos.y - 1) {
//                self.camera?.position = CGPoint(x: xPosCamera , y: yPosCamera)
//                print("masuk 1")
//                print("\(player.position) ------ \(camera?.position)------ \(playerInitPos.y)")
//
//            }
            
            if (player.position.x > 0 && player.position.y > -(self.size.height/2)) {
                print("masuk 2")
                self.camera?.position = CGPoint(x: xPosCamera + player.position.x , y: yPosCamera)
            } else  {
                print("masuk 3")
                self.camera?.position = CGPoint(x: xPosCamera , y: yPosCamera)
            }
            
            //Kalau jatuh, posisi player ulang dari awal
            if (player.position.y < -(self.size.height/2)) {
                player.position = playerInitPos
            //Kalau player sudah ditengah layar
            }
           
        }
        
    }
}
