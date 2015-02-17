//
//  LavaPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/16/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit

class LavaPlatform: SuperPlatform {
    
    override init() {
        super.init(imageName: "LavaPlatform")
        initPhysics()
    }
    
    // specify the location
    init(length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "LavaPlatform", length: length, x: x, y: y)
    }
    
    // specify length, but randomly placed
    init(length: (CGFloat)) {
        super.init(imageName: "LavaPlatform", length: length)
    }
    
    init(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) {
        super.init(imageName: "LavaPlatform", lastPlatformRightAnchor: lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyContactEffects(scene: (GameScene), hero: (SuperCharacter)) {
        hero.die(scene)
        
    }
    override func collisionConsumesSelf() -> Bool {
        return false
    }
    
    override func getNew(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) -> SuperPlatform {
        return LavaPlatform(lastPlatformRightAnchor: lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
 
}
