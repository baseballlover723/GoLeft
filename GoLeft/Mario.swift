//
//  Mario.swift
//  GoLeft
//
//  Created by Philip Ross on 2/17/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class Mario: SuperCharacter, RequiredCharacter {
    var heroJumpForce = CGVector(dx: 0, dy: 14)
    
    
    override var HERO_MASS : CGFloat {
        return CGFloat(0.55)
    }
    
    init() {
        super.init(imageName: "Mario")
        initPhysics()
        super.jumpForce = heroJumpForce
        self.physicsBody?.mass = 0.0540000051259995
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyJumpEffects(scene: (GameScene)) {
        scene.runAction(SKAction.playSoundFileNamed(JUMP_SOUND_FILE, waitForCompletion: false))
    }
    
   
}
