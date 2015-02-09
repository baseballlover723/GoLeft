//
//  Coin.swift
//  GoLeft
//
//  Created by Philip Ross on 2/9/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit
class Coin: SuperPowerup {

 
    init() {
        super.init(imageName: "Coin")
        //        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        
        
        let x = random(min: -self.size.width, max: screenWidth)
        let y = random(min: -self.size.height, max: screenHeight)
        
        self.position = CGPoint(x: x, y: y)
        initPhysics()
    }
    
    // specify the location
    init(x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "Coin")
        
        //        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.position = CGPoint(x: x, y: y)
        
        initPhysics()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func initPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2) // make circle approx
        self.physicsBody?.dynamic = false // don't want gravity
        self.physicsBody?.categoryBitMask = PhysicsCategory.Coin
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperCharacter
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperCharacter
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    

}
