//
//  GameScene.swift
//  GoLeft
//
//  Created by Philip Ross on 2/1/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import SpriteKit

// GLOBAL CONSTANTS
let PLATFORM_SCALING = CGFloat(1/1)



class GameScene: SKScene {
    let hero = SKSpriteNode(imageNamed: "Hero")
    var count = 1;
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        hero.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        self.addChild(hero)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            var rand = arc4random_uniform(3)
            var sprite : SKSpriteNode
            switch (rand) {
            case 0:
                sprite = SKSpriteNode(imageNamed:"Spaceship")
            case 1:
                sprite = SKSpriteNode(imageNamed: "Hero")
            case 2:
                sprite = SKSpriteNode(imageNamed: "BrickPlatform")
            default:
                abort()
            }
            addPlatform(CGFloat(count))
            count++
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
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
        platform.size = CGSize(width: platform.size.width * PLATFORM_SCALING * length, height: platform.size.height)
        let platformY = random(min: platform.size.height / 2, max: size.height - platform.size.height / 2)
        
        platform.position = CGPoint(x: size.width - platform.size.width, y: platformY)
        
        self.addChild(platform)
        println("window = (\(size.width), \(size.height))")
        println("added platform \(platform.position.x), \(platform.position.y) length = \(platform.size.width)")
        
    }
}
