//
//  BrickPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class BrickPlatform: SuperPlatform, RequiredPlatform {
   
    init() {
        super.init(imageName: "BrickPlatform")
        initPhysics()
    }
    
    // specify the location
    init(length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "BrickPlatform", length: length, x: x, y: y)
    }
    
    init(length: (CGFloat)) {
        super.init(imageName: "BrickPlatform", length: length)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func applyContactEffects(hero: (SuperCharacter)) {
        println("Applyed brick effects")
    }
    override func collisionConsumesSelf() -> Bool {
        return false
    }
}
