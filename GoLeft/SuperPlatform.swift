//
//  SuperPlatform.swift
//  GoLeft
//
//  Created by Philip Ross on 2/8/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit

class SuperPlatform: SKSpriteNode {

    init(imageName: (String)) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
