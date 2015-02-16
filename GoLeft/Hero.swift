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
    override var HERO_JUMP_FORCE : CGVector {
        return CGVector(dx: 0, dy: 10)
    }
    
    override var HERO_MASS : CGFloat {
        return CGFloat(0.02)
    }
    
    init() {
        super.init(imageName: "Hero")
        initPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func applyJumpEffects() {
        
    }
    
}
