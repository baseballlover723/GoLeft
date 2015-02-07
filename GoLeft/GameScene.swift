//
//  GameScene.swift
//  GoLeft
//
//  Created by Philip Ross on 2/1/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let hero = SKSpriteNode(imageNamed: "Hero")
    
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
}
