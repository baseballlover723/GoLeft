//
//  SuperPlatformFactory.swift
//  GoLeft
//
//  Created by Philip Ross on 2/15/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit

class SuperPlatformFactory: NSObject {
   
    class func getRandomPlatform(lastPlatformRightAnchor: (CGPoint), heroJumpHeight: (CGFloat)) -> SuperPlatform {
        // init stuff, b/c class variables aren't supported :(
        var platforms = [BrickPlatform(), LavaPlatform()]
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
                println("platform = \(probability[k])")
                return platforms[k].getNew(lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
            }
        }
        return platforms[0].getNew(lastPlatformRightAnchor, heroJumpHeight: heroJumpHeight)
    }
    
    //    func random() -> CGFloat {
    //        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    //    }
    
    class func random() -> Double {
        return Double(arc4random())/0xFFFFFFFF
    }

}
