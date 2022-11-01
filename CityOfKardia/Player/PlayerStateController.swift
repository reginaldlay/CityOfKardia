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

