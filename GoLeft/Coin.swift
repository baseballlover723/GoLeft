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
    var POINT_VALUE = 20
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
  
    override func applyPowerupTo(scene: (GameScene), hero: SuperCharacter) {
        hero.score += POINT_VALUE
        println(COIN_SOUND_FILE)
        scene.runAction(SKAction.playSoundFileNamed(COIN_SOUND_FILE, waitForCompletion: false))

//        println("score = \(hero.score)")
        scene.updateScore()
    }
    
    override func collisionConsumesSelf() -> Bool {
        return true
    }
    
    override func getNew() -> SuperPowerup {
        return Coin()
    }
    

}
