//
//  GameOverScene.swift
//  GoLeft
//
//  Created by Ashok Vardhan Raja on 2/9/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, score: Int) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()

        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "You Died! :("
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2 + label.frame.size.height/2)
        self.addChild(label)
        
        label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "You scored \(score) points"
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2 - label.frame.size.height/2)
        while (label.frame.width > self.size.width) {
            label.fontSize--
        }
        println("game OVER")
        addChild(label)
        runAction(SKAction.playSoundFileNamed("gameOver.mp3", waitForCompletion: false))
        println("playing sound")
                // change to ask for high score if in top 10 and insert into high score tabel
        runAction(SKAction.sequence([
            SKAction.waitForDuration(10.0),
            SKAction.runBlock() {
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size, hero: Mario())
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}