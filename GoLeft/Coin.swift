//
//  Coin.swift
//  GoLeft
//
//  Created by Philip Ross on 2/9/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit
class Coin: SuperPowerup, RequiredPowerup {

 
    init() {
        super.init(imageName: "Coin")
    }
    
    // specify the location
    init(x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "Coin", x: x, y: y)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func initPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2) // make circle approx
        self.physicsBody?.dynamic = false // don't want gravity
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperCharacter
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperCharacter
    }
    override func applyPowerupTo(hero: SuperCharacter) {
        hero.score++
    }
    

}
