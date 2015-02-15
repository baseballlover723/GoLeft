//
//  GameScene.swift
//  GoLeft
//
//  Created by Philip Ross on 2/1/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import SpriteKit

//Physics
struct PhysicsCategory {
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let SuperCharacter: UInt32 = 0b1 // 1
    static let SuperPlatform : UInt32 = 0b10 // 2
    static let SuperPowerup : UInt32 = 0b100 // 3
    static let Hero : UInt32 = 0b1001 // 4
    static let BrickPlatform : UInt32 = 0b10010 // 5
    static let Coin : UInt32 = 0b100100 // 6
}

// GLOBAL CONSTANTS
var movingHero = false
var GRAVITY = CGVector(dx: 0, dy: -1)
var SPEED_SCALING = CGFloat(0.005)
var THRESHHOLD_INCREMENT = CGFloat(0.0000005)
var MOVE_SPEEDUP = CGFloat(0.0001)

class GameScene: SKScene, SKPhysicsContactDelegate{
    var moveConstant = CGFloat(0.5)
    let hero = Hero()
    var count = 1;
    var platforms = [SuperPlatform]()
    var powerups = [SuperPowerup]()
    var platformThreshhold = CGFloat(0);
    var powerupThreshhold = CGFloat(0);
    var lastPlatform = SuperPlatform()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.whiteColor()
        hero.position = CGPoint(x: size.width * 0.9, y: size.height * 0.9)
        
        self.addChild(hero)
//        platforms.append(BrickPlatform(length: 8, x: 0, y: 10))
        platforms.append(BrickPlatform(length: 6, x: 75, y: 50))
        platforms.append(BrickPlatform(length: 1, x: 75, y: 300))
        platforms.append(BrickPlatform(length: 3, x: 275, y: 300))
        platforms.append(BrickPlatform(length: 1, x: 35, y: 150))
        platforms.append(BrickPlatform(length: 1, x: 350, y: 150))
        platforms.append(BrickPlatform(length: 2, x: 200, y: 225))
        powerups.append(Coin(x: 350, y: 50))
        
        self.lastPlatform = platforms[0]
        for platform in platforms {
            self.addChild(platform)
        }
        for powerup in powerups {
            self.addChild(powerup)
        }
        
    
        physicsWorld.gravity = GRAVITY
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        var touch = touches.anyObject() as UITouch!
        var touchLocation = touch.locationInNode(self)
        var touchXLocation = touchLocation.x
        
        var heroXLocation = hero.position.x
        
        var delta = touchXLocation / heroXLocation
//        println("moving at \(delta)")
        // start moving hero
        movingHero = true;
        //jump
        println("jump = \(hero.canJump)")
        if hero.canJump {
            hero.jump()
        }
        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
        
//            var rand = arc4random_uniform(2)
//            var sprite = Hero()
//            var sprite : SKSpriteNode
//            switch (rand) {
//            case 0:
//                sprite = Hero()
//            case 1:
//                sprite = BrickPlatform()
//           default:
//                abort()
//            }
//            addPlatform(random(min: 1, max: 7))
//            count++
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
//            self.addChild(sprite)
            
            
//        }
//    }
    
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        if movingHero {
            // move hero
            var touch = touches.anyObject() as UITouch!
            var touchLocation =  touch.locationInNode(self)
            var previousLocation = touch.previousLocationInNode(self)
        
            var heroX = hero.position.x + (touchLocation.x - previousLocation.x)
            heroX = max(heroX, hero.size.width / 2)
            heroX = min(heroX, size.width - hero.size.width/2)
            
            hero.position = CGPointMake(heroX, hero.position.y)
            
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        movingHero = false
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        println("hero y = \(hero.position.y)")
        maybeMoveHero()
        movePlatformsAndPowerups()
        maybeAddPlatformsAndPowerups()
//        println("*   \(self.children.count) *  \(self.moveConstant)")
        // TODO figure out how to remove things outside of the screen
//        plat.position = CGPoint(x: plat.position.x - 0.5, y: plat.position.y)
//        plat.physicsBody?.applyForce(CGVector(dx: -0.1, dy: 0))
    }
    
    func maybeMoveHero() {
        if hero.canJump {
            // if the hero can jump, he's on a platform and should move with the platform
            hero.position = CGPoint(x: hero.position.x + self.moveConstant, y: hero.position.y)
        }
    }
    
    func movePlatformsAndPowerups() {
        self.moveConstant += MOVE_SPEEDUP
        for platform in self.platforms  {
            if platform.isOnScreen() {
                // if platform is on the screen move it to the left
                platform.position = CGPoint(x: platform.position.x + self.moveConstant, y: platform.position.y)
            } else {
                self.platforms.removeObject(platform)
                platform.removeFromParent()
            }
        }
        
        for powerup in self.powerups {
            if powerup.isOnScreen() {
                // if the powerup is on the screen move it to the right
                powerup.position = CGPoint(x: powerup.position.x + self.moveConstant, y: powerup.position.y)
            } else {
                self.powerups.removeObject(powerup)
                powerup.removeFromParent()
            }
        }
    }
    
    func maybeAddPlatformsAndPowerups() {
        var rand = random()
        //        var threshhold = self.moveConstant * 0.0001 / CGFloat(self.children.count) + self.platformThreshhold
        var threshhold = self.platformThreshhold / CGFloat(self.platforms.count * self.platforms.count)
        self.platformThreshhold += THRESHHOLD_INCREMENT + self.moveConstant * SPEED_SCALING
        //        var threshhold = self.moveConstant * 0.1
        //        println("rand = \(rand)")
        println("threshhold = \(threshhold)")
//        println(self.platforms.count)
        if (rand < threshhold) || (self.platforms.count < 4){
            self.platformThreshhold = CGFloat(0)
            addRandomPlatform()
        }

        rand = random()
        //        var threshhold = self.moveConstant * 0.0001 / CGFloat(self.children.count) + self.platformThreshhold
        threshhold = self.powerupThreshhold / CGFloat(self.powerups.count * self.powerups.count)
        self.powerupThreshhold += THRESHHOLD_INCREMENT + self.moveConstant * SPEED_SCALING
        //        var threshhold = self.moveConstant * 0.1
        //        println("rand = \(rand)")
//        println("threshhold = \(threshhold)")
        if rand < threshhold {
            self.powerupThreshhold = CGFloat(0)
            addRandomPowerup()
        }
    }
    
    func addRandomPlatform() {
        println("\nstart")
        println("last platform position (before) = \(self.lastPlatform.position)")
        var newPlatform = BrickPlatform(lastPlatformRightAnchor: getPlatformRightAnchor(self.lastPlatform), heroJumpHeight: getHeroJumpHeight())
        self.platforms.append(newPlatform)
        self.addChild(newPlatform)
        self.lastPlatform = newPlatform
        //        println("Add new platform")
    }
    
    func addRandomPowerup() {
        var newPowerup = Coin()
        self.powerups.append(newPowerup)
        self.addChild(newPowerup)
//        println("added new powerup")
    }
    
    func getHeroJumpHeight() -> CGFloat {
        return hero.HERO_JUMP_FORCE.dy * hero.HERO_JUMP_FORCE.dy
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random())/0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
//    func addPlatform(length: (CGFloat)) {
//        let platform = BrickPlatform(length: length)
//        self.addChild(platform)
//        println("window = (\(size.width), \(size.height))")
//        println("added platform \(platform.position.x), \(platform.position.y) length = \(platform.size.width)")
//    
////        platform.physicsBody = SKPhysicsBody(rectangleOfSize: platform.size) // make rectangle aprox
////        platform.physicsBody?.dynamic = false // no gravity
////        platform.physicsBody?.categoryBitMask = PhysicsCategory.Platform
////        platform.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
////        platform.physicsBody?.collisionBitMask = PhysicsCategory.Hero
//        
//    }
    
    func didBeginContact(contact: SKPhysicsContact) {
//        println("contact")
        // get the bodies a predictible order
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.SuperCharacter != 0) && (secondBody.categoryBitMask & PhysicsCategory.SuperPlatform != 0) {
            // character and generic platform
            characterDidCollideWithPlatform(firstBody.node as SuperCharacter, platform: secondBody.node as SuperPlatform)
        }
        if (firstBody.categoryBitMask & PhysicsCategory.SuperCharacter != 0) && (secondBody.categoryBitMask & PhysicsCategory.SuperPowerup != 0) {
            // character and generic powerup
            characterDidCollideWithPowerup(firstBody.node as SuperCharacter, powerup: secondBody.node as SuperPowerup)
        }
        
    }
    
    func characterDidCollideWithPlatform(hero: (SuperCharacter), platform: (SuperPlatform)) {
//        println("A Character hit a Platform")
        platform.applyContactEffects(hero)
        if platform.collisionConsumesSelf() {
            platform.removeFromParent()
        }
        
    }
    
    func characterDidCollideWithPowerup(hero: (SuperCharacter), powerup: (SuperPowerup)) {
//        println("Character hit a powerup")
        powerup.applyPowerupTo(hero)
        if powerup.collisionConsumesSelf() {
            powerup.removeFromParent()
        }
    }
    
    func getPlatformRightAnchor(platform: (SuperPlatform)) -> CGPoint {
        return platform.position + platform.size.width / 2
    }
    
    func getPlatformLeftAnchor(platform: (SuperPlatform)) -> CGPoint {
        return platform.position - platform.size.width / 2
    }
    
    
}
extension Array {
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
        }
    }
}

func +(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x + right , y: left.y)
}
func -(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x - right , y: left.y)
}
