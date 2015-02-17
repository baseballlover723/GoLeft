//
//  Magnet.swift
//  GoLeft
//
//  Created by Philip Ross on 2/17/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit

class Magnet: SuperPowerup {
    var lengthOfEffect = NSTimeInterval(15)
  
    init() {
        super.init(imageName: "Magnet")
    }
    
    // specify the location
    init(x: (CGFloat), y: (CGFloat)) {
        super.init(imageName: "Magnet", x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func applyPowerupTo(scene: (GameScene), hero: SuperCharacter) {
        hero.applyMagnet(lengthOfEffect)
    }
    
    override func collisionConsumesSelf() -> Bool {
        return true
    }
    
    override func getNew() -> SuperPowerup {
        return Magnet()
    }

}
