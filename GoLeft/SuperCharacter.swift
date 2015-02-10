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
    var canJump : Bool {
        var inContact = self.physicsBody?.allContactedBodies()
//        var bool = inContact![0]
//        bool = bool.node!!
//        bool = bool.physicsBody!!
//        bool = (bool.categoryBitMask & PhysicsCategory.SuperPlatform) != 0
        return self.physicsBody?.velocity.dy <= CGFloat(abs(0.01)) && inContact!.count == 1 && ((inContact![0].categoryBitMask & PhysicsCategory.SuperPlatform) != 0)
    }
    var score : Int32
    
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
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
