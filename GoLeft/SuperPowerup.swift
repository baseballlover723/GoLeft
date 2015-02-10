//
//  SuperPowerup.swift
//  GoLeft
//
//  Created by Philip Ross on 2/9/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

protocol RequiredPowerup {
    func initPhysics()
    func applyPowerupTo(hero: SuperCharacter)
}

class SuperPowerup: SKSpriteNode, RequiredPowerup {
   
    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        
        
        let x = random(min: -self.size.width, max: screenWidth)
        let y = random(min: -self.size.height, max: screenHeight)
        
        self.position = CGPoint(x: x, y: y)
        initPhysics()
    }
    
    // specify the location
    init(imageName: (String), x: (CGFloat), y: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.position = CGPoint(x: x, y: y)
        
        initPhysics()
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhysics() {
        assert(false, "function must be overriden")
    }
    
    func applyPowerupTo(hero: SuperCharacter) {
        assert(false, "function must be overriden")
    }
}
