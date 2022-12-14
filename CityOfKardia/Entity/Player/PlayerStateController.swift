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

// MARK: Inisialisasi State Machine
class PlayerStateController : GKState {
    unowned var player : PlayerNode
    
    init(player: PlayerNode) {
        self.player = player
        
        super.init()
    }
}

// MARK: State saat berjalan
class IsWalkingState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IsWalkingState.Type : return false
            default : return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        player.runMoveAnimation()
        player.addChild(player.playerWalkSFX)
        player.playerWalkSFX.run(.changeVolume(to: 0.1, duration: 0.1))
        player.playerWalkSFX.run(.play())
    }
    
    override func willExit(to nextState: GKState) {
        player.run(.stop())
        player.playerWalkSFX.removeFromParent()
    }
}

class IsFallingState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is IsJumpingState.Type : return false
            default : return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
}

// MARK: State saat lompat
class IsJumpingState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is IsJumpingState.Type : return false
            default : return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        player.jump()
        player.runJumpSFX()
    }
}

// MARK: State saat idle
class IsIdleState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
            case is IsIdleState.Type : return false
            default : return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        player.runIdleAnimation()
    }
}

