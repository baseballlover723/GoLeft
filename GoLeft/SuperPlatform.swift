//
//  SuperPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

protocol RequiredPlatform {
    func initPhysics()
    func applyContactEffects(hero: (SuperCharacter))
    func collisionConsumesSelf() -> Bool
}
class SuperPlatform: SKSpriteNode, RequiredPlatform {

    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
    }
    
    // specify the location
    init(imageName: (String), length: (CGFloat), x: (CGFloat), y: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        //        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.xScale = length
        self.position = CGPoint(x: x+self.size.width / 2, y: y-self.size.height/2)
        
        initPhysics()
    }
    
    init(imageName: (String), length: (CGFloat)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //        self.size = CGSize(width: self.size.width * length, height: self.size.height)
        self.xScale = length
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.width
        let screenHeight = bounds.height
        
        
        let x = random(min: -self.size.width, max: screenWidth)
        let y = random(min: -self.size.height, max: screenHeight)
        
        self.position = CGPoint(x: x+self.size.width/2, y: y-self.size.height/2)
        initPhysics()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func initPhysics() {
        assert(false, "This method must be overridden")
    }
    
    func applyContactEffects(hero: (SuperCharacter)) {
        assert(false, "SuperPlatform Contact Effects must be overidden")
    }
    
    func collisionConsumesSelf() -> Bool {
        assert(false, "SuperPlatform collisionConsumesSelf must be overridden")
    }

    

}
