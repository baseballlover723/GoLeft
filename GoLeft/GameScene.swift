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
    static let Platform : UInt32 = 0b1 // 1
    static let Hero: UInt32 = 0b10 // 2
}

// GLOBAL CONSTANTS



class GameScene: SKScene, SKPhysicsContactDelegate{

    let hero = Hero()
    var count = 1;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        hero.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        
        
        self.addChild(hero)
        
        physicsWorld.gravity = (CGVectorMake(0, -1))
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            var rand = arc4random_uniform(2)
            var sprite : SKSpriteNode
            switch (rand) {
            case 0:
                sprite = Hero()
            case 1:
                sprite = BrickPlatform()
           default:
                abort()
            }
            addPlatform(CGFloat(count))
            count++
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
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
        let platform = SKSpriteNode(imageNamed: "BrickPlatform")
        platform.size = CGSize(width: platform.size.width * length, height: platform.size.height)
        let platformY = random(min: platform.size.height / 2, max: size.height - platform.size.height / 2)
        
        platform.position = CGPoint(x: size.width - platform.size.width/2, y: platformY)
        
        self.addChild(platform)
        println("window = (\(size.width), \(size.height))")
        println("added platform \(platform.position.x), \(platform.position.y) length = \(platform.size.width)")
    
        platform.physicsBody = SKPhysicsBody(rectangleOfSize: platform.size) // make rectangle aprox
        platform.physicsBody?.dynamic = false // no gravity
        platform.physicsBody?.categoryBitMask = PhysicsCategory.Platform
        platform.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
        platform.physicsBody?.collisionBitMask = PhysicsCategory.Hero
        
    }
    
    func getSize() -> CGSize{
        return size;
    }
}
