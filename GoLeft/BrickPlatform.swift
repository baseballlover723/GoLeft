//
//  BrickPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class BrickPlatform: SuperPlatform, RequiredPlatform {
   
    override init() {
        super.init(imageName: "BrickPlatform")
        initPhysics()
    }
    
    // specify the location
    init(length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "BrickPlatform", length: length, x: x, y: y)
    }
    
    // specify length, but randomly placed
    init(length: (CGFloat)) {
        super.init(imageName: "BrickPlatform", length: length)
    }
    
    init(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) {
        super.init(imageName: "BrickPlatform", lastPlatformRightAnchor: lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
    
    // boundry platforms
    init(x: (CGFloat), y: (CGFloat), vertical_length: (CGFloat)) {
        super.init(imageName: "BrickPlatform", length: CGFloat(1), x: x, y: y)
        self.yScale = vertical_length / self.size.height
        self.xScale = 0.1
        self.position = CGPoint(x: x, y: y)
        self.physicsBody?.categoryBitMask = PhysicsCategory.None
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperCharacter
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperCharacter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func applyContactEffects(scene: (GameScene), hero: (SuperCharacter)) {
//        println("Applied brick effects")
    }
    override func collisionConsumesSelf() -> Bool {
        return false
    }
    
    override func getNew(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) -> SuperPlatform {
        return BrickPlatform(lastPlatformRightAnchor: lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
}
