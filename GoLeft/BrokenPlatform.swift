//
//  BrokenPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/17/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit
class BrokenPlatform: SuperPlatform {
    
    override init() {
        super.init(imageName: "BrokenPlatform")
        initPhysics()
    }
    
    // specify the location
    init(length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "BrokenPlatform", length: length, x: x, y: y)
    }
    
    // specify length, but randomly placed
    init(length: (CGFloat)) {
        super.init(imageName: "BrokenPlatform", length: length)
    }
    
    init(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) {
        super.init(imageName: "BrokenPlatform", lastPlatformRightAnchor: lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyContactEffects(scene: (GameScene), hero: (SuperCharacter)) {
        self.removeFromParent()
        
    }
    override func collisionConsumesSelf() -> Bool {
        return true
    }
    
    override func getNew(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) -> SuperPlatform {
        return BrokenPlatform(lastPlatformRightAnchor: lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
    
    override func initPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // make rectangle aprox
        self.physicsBody?.dynamic = false //not effected by the physcis engine
        //        self.physicsBody?.affectedByGravity = false
        //        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.BrickPlatform
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }

}
