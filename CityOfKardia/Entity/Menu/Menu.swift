//
//  Menu.swift
//  CityOfKardia
//
//  Created by Farrel Brian on 15/11/22.
//

import SpriteKit

class Menu : SKNode {
    
    // MARK: Inisialisai Element Menu
    let menuExitButton = SKSpriteNode(imageNamed: "book_close")
    let menuKeluarButton = SKSpriteNode(imageNamed: "red_menuKeluarButton")
    let menuKamusButton = SKSpriteNode(imageNamed: "red_menuKamusButton")
    let menuMusicButton = SKSpriteNode(imageNamed: "red_menuMusicOnButton")
    let menuFrame = SKSpriteNode(imageNamed: "red_menuFrame")
    
    // MARK: Inisialisasi menu sebagai empty node
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Fungsi untuk munculin elemen menu
    func setupMenu() {
        self.name = "menu"
        
        addMenuItem(node: menuFrame, nodeName: "menuFrame", pos: CGPoint(x: 0, y: 0), zPos: 200)
        addMenuItem(node: menuExitButton, nodeName: "menuExitButton", pos: CGPoint(x: 230, y: 130), zPos: 201)
        addMenuItem(node: menuKamusButton, nodeName: "menuKamusButton", pos: CGPoint(x: 0, y: 0), zPos: 201)
        addMenuItem(node: menuKeluarButton, nodeName: "menuKeluarButton", pos: CGPoint(x: 0, y: -64), zPos: 201)
        addMenuItem(node: menuMusicButton, nodeName: "menuMusicButton", pos: CGPoint(x: 0, y: 64), zPos: 201)
    }
    
    // MARK: Fungsi untuk membuat node
    func addMenuItem(node: SKSpriteNode, nodeName: String, pos: CGPoint, zPos: CGFloat) {
        node.name = nodeName
        node.position = pos
        node.zPosition = zPos
        if node == menuExitButton {node.size = CGSize(width: 40, height: 42)}
        self.addChild(node)
    }
    
    // MARK: Fungsi untuk animasi pressed
    func didPressAnimation(nodeName: String) {
        if let node = self.childNode(withName: nodeName) {
            let pressTexture = SKTexture(imageNamed: "\(nodeName)Clicked")
            let changeAction = SKAction.setTexture(pressTexture)
            node.run(changeAction)
        }
    }
    
    // MARK: Fungsi untuk animasi setelah press selesai
    func didEndPressAnimation(nodeName: String) {
        if let node = self.childNode(withName: nodeName) {
            let imageName = nodeName.replacingOccurrences(of: "Clicked", with: "")
            let endPressTexture = SKTexture(imageNamed: imageName)
            let changeAction = SKAction.setTexture(endPressTexture)
            node.run(changeAction)
        }
    }
    
    // MARK: Fungsi untuk mengganti texture music button saat akhir button press
    func didToggleMusicButton(musicIsOn: Bool) {
        let musicOnTexture = SKTexture(imageNamed: "menuMusicOnButton")
        let musicOffTexture = SKTexture(imageNamed: "menuMusicOffButton")
        var changeTexture: SKAction?
        
        if musicIsOn {
            changeTexture = SKAction.setTexture(musicOffTexture)
        } else {
            changeTexture = SKAction.setTexture(musicOnTexture)
        }
        
        menuMusicButton.run(changeTexture ?? SKAction.setTexture(musicOnTexture))
    }
    
    // MARK: Fungsi untuk mengganti texture music button saat awal button press
    func didPressMusicButton(musicIsOn: Bool) {
        let musicOnTexture = SKTexture(imageNamed: "menuMusicOnButtonClicked")
        let musicOffTexture = SKTexture(imageNamed: "menuMusicOffButtonClicked")
        var changeTexture: SKAction?
        
        if musicIsOn {
            changeTexture = SKAction.setTexture(musicOnTexture)
        } else {
            changeTexture = SKAction.setTexture(musicOffTexture)
        }
        
        menuMusicButton.run(changeTexture ?? SKAction.setTexture(musicOnTexture))
    }
    
}
