//
//  PorterRobinson.swift
//  GoLeft
//
//  Created by Philip Ross on 2/14/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class PorterRobinson: SuperPowerup, RequiredPowerup {

    init() {
        super.init(imageName: "Porter Robinson")
    }
    
    // specify the location
    init(x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "Porter Robinson", x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyPowerupTo(scene: (GameScene), hero: SuperCharacter) {
        println("PORTER ROBINSON!!!")
    }
    
    override func collisionConsumesSelf() -> Bool {
        return true
    }

    override func getNew() -> SuperPowerup {
        return PorterRobinson()
    }
}
