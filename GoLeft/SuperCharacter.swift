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
    func setHeroJumpForce(newJumpForce: (CGVector))
//    var HERO_JUMP_FORCE : CGVector { get }
    var HERO_MASS : CGFloat { get }
//    func GET_HERO_JUMP_FORCE() -> CGVector
}

class SuperCharacter: SKSpriteNode, RequiredCharacter {
    var score : Int
    var coinMagnet = false
    var jumpForce = CGVector(dx: 0, dy: 0)
    var HERO_MASS : CGFloat {
        // not yet implemented
        assert(false, "Supercharacter HERO_MASS must be overriden")
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
//        println("isPlatform = \(isPlatform), isBelow = \(isBelow)")
//        return self.physicsBody?.velocity.dy <= CGFloat(abs(0.01)) && inContact!.count == 1 && isPlatform && isBelow
        return isPlatform && isBelow
    }

    
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        self.score = 0
        // default jump forces
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    //Defualt physics
    func initPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // make rectangle aprox
        self.physicsBody?.dynamic = true // want gravity
        self.physicsBody?.categoryBitMask = PhysicsCategory.Hero
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperPlatform
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperPlatform
        self.physicsBody?.allowsRotation = false
//        self.physicsBody?.mass = HERO_MASS
    }
    
    func applyJumpEffects() {
        assert(false, "Jump Effects must be overriden")
    }
    
    func setHeroJumpForce(newJumpForce: (CGVector)) {
        self.jumpForce = newJumpForce
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(self.jumpForce)
        self.applyJumpEffects()
    }
    
    func die(scene: GameScene) {
        println("YOU DIED")
        let dieAction = SKAction.runBlock() {
            let reveal = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 1.0)
            let gameOverScene = GameOverScene(size: scene.size, score: self.score)
            scene.view?.presentScene(gameOverScene, transition: reveal)
        }
//        self.runAction(dieAction)
//        scene.backgroundMusicPlayer.stop()
    }
    
    func applyMagnet(lengthOfEffect: (NSTimeInterval)) {
        coinMagnet = true
        var actions = [SKAction.waitForDuration(lengthOfEffect), SKAction.runBlock {
            self.coinMagnet = false
            return
            }
        ]
        self.runAction(SKAction.sequence(actions))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
