//
//  ArteriPulmonalisController.swift
//  CityOfKardia
//
//  Created by Vincensa Regina on 15/11/22.
//

import SpriteKit

class ArteriPulmonalisController: GameUIController {
    var playerInitPos = CGPoint(x: 0, y: 0) //apabila player jatuh -> ulang ke posisi awal
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        playerInitPos = player?.position ?? CGPoint(x: 0, y: 0)
        print(playerInitPos)
        
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
            if (player.position.y < playerInitPos.y - 1) {
                self.camera?.position = CGPoint(x: 0 , y: playerInitPos.y)
                print("\(player.position) ------ \(camera?.position)------ \(playerInitPos.y)")
                
            } else if (player.position.x > 0 && player.position.y > -(self.size.height/2)) {
                self.camera?.position = CGPoint(x: player.position.x , y: player.position.y)
            } else if (player.position.x < 0 && player.position.y > -(self.size.height/2)) {
                self.camera?.position = CGPoint(x: 0 , y: player.position.y)
            }
            
            //Kalau jatuh, posisi player ulang dari awal
            if (player.position.y < -(self.size.height/2)) {
                player.position = playerInitPos
            //Kalau player sudah ditengah layar
            }
           
        }
        
    }
}
