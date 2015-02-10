//
//  SuperCharacter.swift
//  GoLeft
//
//  Created by Philip Ross on 2/7/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

protocol RequiredCharacter {
    func initPhysics()
}

class SuperCharacter: SKSpriteNode, RequiredCharacter {
    var canJump : Bool
    var score : Int32
    
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        self.canJump = false
        self.score = 0
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    func initPhysics() {
        assert(false, "Method must be overriden")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
