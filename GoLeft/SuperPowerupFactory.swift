//
//  SuperPowerupFactory.swift
//  GoLeft
//
//  Created by Philip Ross on 2/14/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit

class SuperPowerupFactory{
    
    class func getRandomPowerup() -> SuperPowerup {
        // init stuff, b/c class variables aren't supported :(
        var powerups = [Coin(), PorterRobinson()]
        var probability = [0.5, 0.1]
        
        
        var total = Double(0)
        for (var k=0; k<probability.count; k++) {
            total += probability[k]
        }
        var soFar = Double(0)
        var rand = random() * total
        println("rand = \(rand)")
        for (var k=0; k<probability.count; k++) {
            soFar += probability[k]
            if rand < soFar {
                println("powerup = \(probability[k])")
                return powerups[k].getNew()
            }
        }
        return powerups[0].getNew()
    }
    
//    func random() -> CGFloat {
//        return CGFloat(Float(arc4random())/0xFFFFFFFF)
//    }
    
    class func random() -> Double {
        return Double(arc4random())/0xFFFFFFFF
    }

}
