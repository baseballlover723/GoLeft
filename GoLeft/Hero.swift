//
//  Hero.swift
//  GoLeft
//
//  Created by Philip Ross on 2/7/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class Hero: SuperCharacter, RequiredCharacter {
    
    init() {
        super.init(imageName: "Hero")
        initPhysics()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // make rectangle aprox
        self.physicsBody?.dynamic = true // want gravity
        self.physicsBody?.categoryBitMask = PhysicsCategory.Hero
        self.physicsBody?.contactTestBitMask = PhysicsCategory.SuperPlatform
        self.physicsBody?.collisionBitMask = PhysicsCategory.SuperPlatform
        self.physicsBody?.allowsRotation = false
    }
    
}
