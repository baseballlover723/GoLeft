//
//  SuperPowerup.swift
//  GoLeft
//
//  Created by Philip Ross on 2/9/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

protocol RequiredPowerup {
    func initPhysics()
    func applyPowerupTo(hero: SuperCharacter)
    func collisionConsumesSelf() -> Bool
    func isOnScreen() -> Bool
}

class SuperPowerup: SKSpriteNode, RequiredPowerup {
   
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        
        
        let x = random(min: -self.size.width, max: screenWidth)
        let y = random(min: -self.size.height, max: screenHeight)
        
        self.position = CGPoint(x: x, y: y)
        initPhysics()
    }
    
    // specify the location
    init(imageName: (String), x: (CGFloat), y: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.position = CGPoint(x: x, y: y)
        
        initPhysics()
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // defualt physics, able to override
    func initPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2) // make circle approx
        self.physicsBody?.dynamic = true // do want to move coin if it is in a platform
        self.physicsBody?.affectedByGravity = false // don't want gravity
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperCharacter
        // to avoid collisions with platforms
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperCharacter | PhysicsCategory.SuperPlatform
    }
    
    func applyPowerupTo(hero: SuperCharacter) {
        assert(false, "SuperPowerup applyPowerupTo must be overriden")
    }
    
    func collisionConsumesSelf() -> Bool {
        assert(false, "SuperPowerup consumesSelf must be overriden")
    }
    
    func isOnScreen() -> Bool {
        // may override
        var posX = self.position.x
        var width = self.size.width
        var edgeX = UIScreen.mainScreen().bounds.width
        return posX - width / 2 < edgeX
    }
}
