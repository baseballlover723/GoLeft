//
//  SuperPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

protocol RequiredPlatform {
    func initPhysics()
    func applyContactEffects(scene: (GameScene), hero: (SuperCharacter))
    func collisionConsumesSelf() -> Bool
    func isOnScreen() -> Bool
    func getNew(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) -> SuperPlatform
}

class SuperPlatform: SKSpriteNode, RequiredPlatform {
    var maxLength = UInt32(UIScreen.mainScreen().bounds.width / 60)
    
    // nil object
    override init() {
        let texture = SKTexture(imageNamed: "Hero")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    // generate the platform with random length and random location at the left side of the game
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.xScale = CGFloat(arc4random_uniform(self.maxLength))
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        let y = random(min: 0, max: screenHeight)
        
        self.position = CGPoint(x: -self.size.width/2, y: y)
        initPhysics()
    }
    
    // generate platform that is possible to jump to, but favors farther away
    init(imageName: (String), lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.xScale = CGFloat(arc4random_uniform(self.maxLength))
        
//        println("last plat Right Anchor = \(lastPlatformRightAnchor)")
        var deltaX = lastPlatformRightAnchor.x
        var heroJumpHeight = heroJumpHeight * 0.95
        var calc = deltaX > heroJumpHeight ? 0 : sqrt(heroJumpHeight * heroJumpHeight - deltaX * deltaX)
        var maxY = max(heroJumpHeight/3, calc) + lastPlatformRightAnchor.y
//        println("deltaX = \(deltaX), maxY = \(maxY), calc = \(calc)")
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        var boo = random() > ((4/3)*lastPlatformRightAnchor.y / screenHeight)
        let y = boo ? randomUpper(11 * lastPlatformRightAnchor.y / 10, max: maxY): random(min: 0, max: (9/10) * lastPlatformRightAnchor.y)
        if boo {
//            println("Went UP")
        } else {
//            println("Went DOWN")
        }
//        println("Y = \(y)")

        self.position = CGPoint(x: -self.size.width/2, y: y)
        initPhysics()
    }

    // specify the location
    init(imageName: (String), length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        //        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.xScale = length
        self.position = CGPoint(x: x+self.size.width / 2, y: y)
        
        initPhysics()
    }
    
    // generate platform with a given length at a random Y at the left side of the game
    init(imageName: (String), length: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.xScale = length
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
//        let x = random(min: -self.size.width, max: screenWidth)
        let y = random(min: 0, max: screenHeight)
        
//        self.position = CGPoint(x: x+self.size.width/2, y: y-self.size.height/2)
        self.position = CGPoint(x: -self.size.width/2, y: y)
        initPhysics()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func randomUpper(min: (CGFloat), max: (CGFloat)) -> CGFloat {
        var rand = random() * random()
        return max - (max - min) * rand
    }
    
    func initPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // make rectangle aprox
        self.physicsBody?.dynamic = false //not effected by the physcis engine
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.BrickPlatform
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperCharacter
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperCharacter
    }
    
    func isOnScreen() -> Bool {
        // may override
        var posX = self.position.x
        var width = self.size.width
        var edgeX = UIScreen.mainScreen().bounds.width
        return posX - width / 2 < edgeX
    }

    func applyContactEffects(scene: (GameScene), hero: (SuperCharacter)) {
        assert(false, "SuperPlatform Contact Effects must be overidden")
    }
    
    func collisionConsumesSelf() -> Bool {
        assert(false, "SuperPlatform collisionConsumesSelf must be overridden")
    }
    
    func getNew(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) -> SuperPlatform {
        assert(false, "SuperPlatform getNew must be overridden")
    }

    

}
