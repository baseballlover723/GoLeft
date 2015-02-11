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
    func jump()
    func applyJumpEffects()
    var HERO_JUMP_FORCE : CGVector { get }
//    func GET_HERO_JUMP_FORCE() -> CGVector
}

class SuperCharacter: SKSpriteNode, RequiredCharacter {

    var HERO_JUMP_FORCE : CGVector{
        assert(false, "HERO JUMP FORCE must be overriden")
    }
    
    var canJump : Bool {
        var inContact = self.physicsBody?.allContactedBodies()
//        var bool = inContact![0]
//        bool = bool.node!!
//        bool = bool.physicsBody!!
//        bool = (bool.categoryBitMask & PhysicsCategory.SuperPlatform) != 0
        if inContact?.count == 0 {
            return false
        }
        
        var isPlatform = (inContact![0].categoryBitMask & PhysicsCategory.SuperPlatform) != 0
        var isBelow = inContact![0].position!.y < (self.position.y - self.size.height/2)
        println("isPlatform = \(isPlatform), isBelow = \(isBelow)")
        return self.physicsBody?.velocity.dy <= CGFloat(abs(0.01)) && inContact!.count == 1 && isPlatform && isBelow
    }
    var score : Int32
    
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        self.score = 0
        // default jump force
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    func initPhysics() {
        assert(false, "Supercharacter physics must be overriden")
    }
    
    func applyJumpEffects() {
        assert(false, "Jump Effects must be overriden")
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(HERO_JUMP_FORCE)
        self.applyJumpEffects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
