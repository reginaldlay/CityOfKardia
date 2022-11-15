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

// MARK: State saat berjalan ke kanan
class IsWalkingRightState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IsWalkingRightState.Type : return false
            default : return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        player.runMoveAnimation(direction: "right")
        player.addChild(player.playerWalkSFX)
        player.playerWalkSFX.run(.changeVolume(to: 0.1, duration: 0.1))
        player.playerWalkSFX.run(.play())
    }
    
    override func willExit(to nextState: GKState) {
        player.run(.stop())
        player.playerWalkSFX.removeFromParent()
    }
}

// MARK: State saat berjalan ke kiri
class IsWalkingLeftState : PlayerStateController {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IsWalkingLeftState.Type : return false
            default : return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        player.runMoveAnimation(direction: "left")
        player.playerWalkSFX.run(.changeVolume(to: 0.1, duration: 0.1))
        player.addChild(player.playerWalkSFX)
        player.playerWalkSFX.run(.play())
    }
    
    override func willExit(to nextState: GKState) {
        player.playerWalkSFX.run(.stop())
        player.playerWalkSFX.removeFromParent()
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

