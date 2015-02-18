//
//  Hero.swift
//  GoLeft
//
//  Created by Philip Ross on 2/7/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class Hero: SuperCharacter, RequiredCharacter {
    var heroJumpForce = CGVector(dx: 0, dy: 15.5)
    
    
    override var HERO_MASS : CGFloat {
        return CGFloat(0.55)
    }
    
    init() {
        super.init(imageName: "Hero")
        initPhysics()
        super.jumpForce = heroJumpForce
        println("mass = \(self.physicsBody?.mass)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func applyJumpEffects(scene: (GameScene)) {
        
    }
    
}
