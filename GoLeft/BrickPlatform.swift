//
//  BrickPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class BrickPlatform: SuperPlatform {
   
    init() {
        super.init(imageName: "BrickPlatform")
        initPhysics()
    }
    
    // specify the location
    init(length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "BrickPlatform")

//        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.xScale = length
        self.position = CGPoint(x: x, y: y)
        
        initPhysics()
    }
    
    init(length: (CGFloat)) {
        super.init(imageName: "BrickPlatform")
//        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.xScale = length
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        

        let x = random(min: -self.size.width, max: screenWidth)
        let y = random(min: -self.size.height, max: screenHeight)
        
        self.position = CGPoint(x: x, y: y)
        initPhysics()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // make rectangle aprox
        self.physicsBody?.dynamic = false // no gravity
        self.physicsBody?.categoryBitMask = PhysicsCategory.Platform
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
        self.physicsBody?.collisionBitMask = PhysicsCategory.Hero
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

}
