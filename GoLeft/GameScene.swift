//
//  GameScene.swift
//  GoLeft
//
//  Created by Philip Ross on 2/1/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import SpriteKit

//Physics
struct PhysicsCategory {
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let SuperCharacter: UInt32 = 0b1 // 1
    static let SuperPlatform : UInt32 = 0b10 // 2
    static let SuperPowerup : UInt32 = 0b100 // 3
    static let Hero : UInt32 = 0b1001 // 4
    static let BrickPlatform : UInt32 = 0b10010 // 5
    static let Coin : UInt32 = 0b100100 // 6
}

// GLOBAL CONSTANTS
var movingHero = false


class GameScene: SKScene, SKPhysicsContactDelegate{

    let hero = Hero()
    var count = 1;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        hero.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        
        self.addChild(hero)
        
        self.addChild(BrickPlatform(length: 8, x: 0, y: 10))
        self.addChild(BrickPlatform(length: 6, x: 75, y: 50))
        self.addChild(BrickPlatform(length: 1, x: 75, y: 300))
        self.addChild(BrickPlatform(length: 3, x: 335, y: 300))
        self.addChild(BrickPlatform(length: 1, x: 235, y: 150))
        self.addChild(BrickPlatform(length: 2, x: 175, y: 250))
        self.addChild(Coin(x: 50, y: 50))
        
        
        physicsWorld.gravity = (CGVectorMake(0, -1))
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        var touchXLocation = touchLocation.x
        
        var heroXLocation = hero.position.x
        
        var delta = touchXLocation / heroXLocation
        println("moving at \(delta)")
        // start moving hero
        movingHero = true;
        //jump
        println("jump = \(hero.canJump)")
        if hero.canJump {
            hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
            hero.canJump = false
        }
        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
        
//            var rand = arc4random_uniform(2)
//            var sprite = Hero()
//            var sprite : SKSpriteNode
//            switch (rand) {
//            case 0:
//                sprite = Hero()
//            case 1:
//                sprite = BrickPlatform()
//           default:
//                abort()
//            }
//            addPlatform(random(min: 1, max: 7))
//            count++
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
//            self.addChild(sprite)
            
            
//        }
//    }
    
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if movingHero {
            // move hero
            var touch = touches.anyObject() as UITouch!
            var touchLocation =  touch.locationInNode(self)
            var previousLocation = touch.previousLocationInNode(self)
        
            var heroX = hero.position.x + (touchLocation.x - previousLocation.x)
            heroX = max(heroX, hero.size.width / 2)
            heroX = min(heroX, size.width - hero.size.width/2)
            
            hero.position = CGPointMake(heroX, hero.position.y)
            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        movingHero = false
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addPlatform(length: (CGFloat)) {
        let platform = BrickPlatform(length: length)
        self.addChild(platform)
        println("window = (\(size.width), \(size.height))")
        println("added platform \(platform.position.x), \(platform.position.y) length = \(platform.size.width)")
    
//        platform.physicsBody = SKPhysicsBody(rectangleOfSize: platform.size) // make rectangle aprox
//        platform.physicsBody?.dynamic = false // no gravity
//        platform.physicsBody?.categoryBitMask = PhysicsCategory.Platform
//        platform.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
//        platform.physicsBody?.collisionBitMask = PhysicsCategory.Hero
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        println("contact")
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.SuperCharacter != 0) && (secondBody.categoryBitMask & PhysicsCategory.SuperPlatform != 0) {
            // character and generic platform
            characterDidCollideWithPlatform(firstBody.node as SuperCharacter, platform: secondBody.node as SuperPlatform)
        }
        if (firstBody.categoryBitMask & PhysicsCategory.SuperCharacter != 0) && (secondBody.categoryBitMask & PhysicsCategory.SuperPowerup != 0) {
            // character and generic powerup
            characterDidCollideWithPowerup(firstBody.node as SuperCharacter, powerup: secondBody.node as SuperPowerup)
        }
        
    }
    
    func characterDidCollideWithPlatform(character: (SuperCharacter), platform: (SuperPlatform)) {
        println("A Character hit a Platform")
        character.canJump = true
    }
    
    func characterDidCollideWithPowerup(character: (SuperCharacter), powerup: (SuperPowerup)) {
        println("Character hit a powerup")
    }
}
