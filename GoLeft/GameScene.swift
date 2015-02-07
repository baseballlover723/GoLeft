//
//  GameScene.swift
//  GoLeft
//
//  Created by Philip Ross on 2/1/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
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
