//
//  JumpHigher.swift
//  GoLeft
//
//  Created by Philip Ross on 2/17/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class JumpHigher: SuperPowerup {
    var lengthOfEffect = NSTimeInterval(10)
    var jumpMultiplier = 1.75
    
    init() {
        super.init(imageName: "JumpHigher")
    }
    
    // specify the location
    init(x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "JumpHigher", x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyPowerupTo(scene: (GameScene), hero: SuperCharacter) {
        hero.setHeroJumpForce(CGVector(dx: hero.jumpForce.dx * CGFloat(self.jumpMultiplier), dy: hero.jumpForce.dy * CGFloat(self.jumpMultiplier)))
        
        var actions = [SKAction.waitForDuration(lengthOfEffect), SKAction.runBlock {
            hero.setHeroJumpForce(CGVector(dx: hero.jumpForce.dx / CGFloat(self.jumpMultiplier), dy: hero.jumpForce.dy / CGFloat(self.jumpMultiplier)))
            return
            }
        ]
        hero.runAction(SKAction.sequence(actions))

    }
    
    override func collisionConsumesSelf() -> Bool {
        return true
    }
    
    override func getNew() -> SuperPowerup {
        return JumpHigher()
    }
    
  
}
