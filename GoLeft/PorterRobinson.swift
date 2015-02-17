//
//  PorterRobinson.swift
//  GoLeft
//
//  Created by Philip Ross on 2/14/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class PorterRobinson: SuperPowerup, RequiredPowerup {
    var pointMultiplier = 3/2
    
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
        if scene.powerupFactory.probability[1] == 0 {
            // porter robinson is already playing
            return
        }
        let url = NSBundle.mainBundle().URLForResource(PORTER_ROBINSON_SONG_FILE, withExtension: nil)
        if url == nil {
            println("could not file file: \(PORTER_ROBINSON_SONG_FILE)")
            return
        }
        
        var error: NSError? = nil
        scene.porterPlayer = AVPlayer(URL: url)
        if scene.porterPlayer == nil {
            println("could not create audio player: \(error)")
            return
        }
        // video will play
        hero.score += 100
        scene.powerupFactory.probability[1] = 0.0
        POINT_CYCLE /= pointMultiplier
        scene.scoreLabel.fontColor = UIColor.whiteColor()
        
        var video = SKVideoNode(AVPlayer: scene.porterPlayer)
        video.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        video.size = CGSize(width: scene.size.width, height: scene.size.height)
        video.zPosition = -1
        scene.addChild(video)
        video.play()
        scene.backgroundMusicPlayer.pause()
        scene.oldPorterProb = scene.powerupFactory.probability[1]
        scene.powerupFactory.probability[1] = 0
        var actions = [SKAction.waitForDuration(214), SKAction.runBlock {
            scene.scoreLabel.fontColor = UIColor.blackColor()
            scene.backgroundMusicPlayer.play()
            scene.powerupFactory.probability[1] = scene.oldPorterProb
            POINT_CYCLE *= self.pointMultiplier
            return
            }, SKAction.removeFromParent()
        ]
        video.runAction(SKAction.sequence(actions))
        //        var videoLength = SKAction.waitForDuration(214)
        //        var restartBackgroundMusic = SKAction.runBlock {
        //            scene.backgroundMusicPlayer.play()
        //        }
        println("video -> \(scene.porterPlayer.status)")

    }
    
    override func collisionConsumesSelf() -> Bool {
        return true
    }

    override func getNew() -> SuperPowerup {
        return PorterRobinson()
    }
}
