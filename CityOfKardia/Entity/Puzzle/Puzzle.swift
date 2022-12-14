//
//  Puzzle.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 17/11/22.
//

import SpriteKit

class Puzzle : SKNode {
    var arrOfCable: [Int] = []
    var winFlag = false
    let arrOfPossibleRotationCount = [1, 2, 3]
    
    func setupPuzzle() {
        addPuzzleItem(node: "puzzleFrame", nodeName: "puzzleFrame", pos: CGPoint(x: 0, y: 0), zPos: 10)
        addPuzzleItem(node: "purple_book_close", nodeName: "exitButton", pos: CGPoint(x: 390, y: 159), zPos: 13)
        addPuzzleItem(node: "cable01", nodeName: "startCable", pos: CGPoint(x: -30, y: 0), zPos: 11)
        addPuzzleItem(node: "cable02", nodeName: "endCable", pos: CGPoint(x: 270, y: 0), zPos: 11)
        addPuzzleItem(node: "cable07", nodeName: "cable0", pos: CGPoint(x: -30, y: 60), zPos: 11)
        addPuzzleItem(node: "cable02", nodeName: "cable1", pos: CGPoint(x: 30, y: 60), zPos: 11)
        addPuzzleItem(node: "cable06", nodeName: "cable2", pos: CGPoint(x: 90, y: 60), zPos: 11)
        addPuzzleItem(node: "cable07", nodeName: "cable3", pos: CGPoint(x: 150, y: 60), zPos: 11)
        addPuzzleItem(node: "cable06", nodeName: "cable4", pos: CGPoint(x: 210, y: 60), zPos: 11)
        addPuzzleItem(node: "cable03", nodeName: "cable5", pos: CGPoint(x: 30, y: 0), zPos: 11)
        addPuzzleItem(node: "cable04", nodeName: "cable6", pos: CGPoint(x: 90, y: 0), zPos: 11)
        addPuzzleItem(node: "cable01", nodeName: "cable7", pos: CGPoint(x: 150, y: 0), zPos: 11)
        addPuzzleItem(node: "cable03", nodeName: "cable8", pos: CGPoint(x: 210, y: 0), zPos: 11)
        addPuzzleItem(node: "cable08", nodeName: "cable9", pos: CGPoint(x: -30, y: -60), zPos: 11)
        addPuzzleItem(node: "cable05", nodeName: "cable10", pos: CGPoint(x: 30, y: -60), zPos: 11)
        addPuzzleItem(node: "cable08", nodeName: "cable11", pos: CGPoint(x: 150, y: -60), zPos: 11)
        addPuzzleItem(node: "cable04", nodeName: "cable12", pos: CGPoint(x: 210, y: -60), zPos: 11)
        addPuzzleItem(node: "cable05", nodeName: "cable13", pos: CGPoint(x: 270, y: -60), zPos: 11)
        addOverlay()
        
        countCable()
    }
    
    func addPuzzleItem(node: String, nodeName: String, pos: CGPoint, zPos: CGFloat) {
        let node = SKSpriteNode(imageNamed: node)
        node.name = nodeName
        node.position = pos
        node.zPosition = zPos
        self.addChild(node)
    }
    
    func countCable() {
        enumerateChildNodes(withName: "cable*") {
            node, _ in
            
            self.arrOfCable.append(0)
            
            self.randomRotation(node: node)
            
        }
    }
    
    func checkWinCondition() -> Bool{
        var sumOfAngle = 0
        
        for i in 0..<arrOfCable.count {
            sumOfAngle += arrOfCable[i]
        }
        
        if sumOfAngle == 0 {
            let node = SKSpriteNode(imageNamed: "puzzleWinOverlay")
            node.name = "pWinOverlay"
            node.position = CGPoint(x: 0, y: 0)
            node.zPosition = 12
            node.size = CGSize(width: 800, height: 340)
            self.addChild(node)
            
            let node2 = SKSpriteNode(imageNamed: "puzzleContinueButton")
            node2.name = "pContinueButton"
            node2.position = CGPoint(x: 0, y: -30)
            node2.zPosition = 13
            node2.size = CGSize(width: 134, height: 40)
            self.addChild(node2)
            
            return true
        }
        
        return false
        
    }
    
    func randomRotation(node: SKNode) {
        
        guard let numOfRotation = arrOfPossibleRotationCount.randomElement() else { return }
        
        for _ in 0...numOfRotation {
            rotateByHalfPi(node: node)
        }
        
    }
    
    func rotateByHalfPi(node: SKNode) {
        let angle = Double.pi / 2
        let rotateAction = SKAction.rotate(byAngle: angle, duration: 0.5)
        guard let nodeName = node.name else { return }
        guard let num = Int.parse(from: nodeName) else { return }
        
        if arrOfCable[num] >= 3 {
            arrOfCable[num] = 0
        } else {
            arrOfCable[num] += 1
        }

        node.run(rotateAction)
    }
    
    func addOverlay() {
        let node = SKSpriteNode(color: .black, size: CGSize(width: 950, height: 450))
        node.alpha = 0.5
        node.position = CGPoint(x: 0, y: 0)
        node.zPosition = 1
        self.addChild(node)
    }
}

extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
