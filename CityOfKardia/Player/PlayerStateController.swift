//
//  PlayerStateController.swift
//  Kardia2
//
//  Created by Farrel Brian on 18/10/22.
//
// Finite State Machine untuk mengatur aktivitas player node


import Foundation
import SpriteKit
import GameplayKit

class PlayerStateController : GKState {
    unowned var player : SKNode
    
    init(player: SKNode) {
        self.player = player
        
        super.init()
    }
}

// FIXME: State saat sudah di tanah. Transisi dari state jumping msh ada bug / gamasuk kesini abis jumping.
class LandingState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type, is JumpingState.Type : return false
            default : return true
        }
    }

    override func didEnter(from previousState: GKState?) {
        stateMachine?.enter(IdleState.self)
        print("land")
    }
}

// FIXME: State lompat masih ngebug. Animasi ga jalan.
class JumpingState : PlayerStateController {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {

        if stateClass is IdleState.Type { return true }
        return false
        
    }
    
    let jumpTexture : Array<SKTexture> = (1...4).map({return "Erry_Jump_\($0)"}).map(SKTexture.init)
    lazy var jumpAction = { SKAction.animate(with: self.jumpTexture, timePerFrame: 0.1) }

    override func didEnter(from previousState: GKState?) {
        
        player.removeAllActions()
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300)) // lompat
        player.run(jumpAction()) // animasi

    }
    
}

// MARK: State pas player idling
class IdleState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is LandingState.Type, is IdleState.Type : return false
            default : return true
        }
    }
    
    let idleTexture : Array<SKTexture> = (1...4).map({return "Erry_Idle_\($0)"}).map(SKTexture.init)
    lazy var IdleAction = { SKAction.repeatForever(.animate(with: self.idleTexture, timePerFrame: 0.2)) }
    
    override func didEnter(from previousState: GKState?) {
        player.removeAllActions()
        player.run(IdleAction())
    }
}

// MARK: State saat player berjalan
class WalkingState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is LandingState.Type, is WalkingState.Type : return false
            default : return true
        }
    }
    
    let WalkingTexture : Array<SKTexture> = (1...12).map({return "Erry_Run_\($0)"}).map(SKTexture.init)
    lazy var WalkingAction = { SKAction.repeatForever(.animate(with: self.WalkingTexture, timePerFrame: 0.1)) }
    
    override func didEnter(from previousState: GKState?) {
        player.removeAllActions()
        player.run(WalkingAction())
    }
}
