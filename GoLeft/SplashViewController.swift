//
//  SplashViewController.swift
//  GoLeft
//
//  Created by Philip Ross on 2/18/15.
//  Copyright (c) 2015 Philip Ross. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println("segue")
        if segue.identifier == "GameStartMario" {
            println("Mario")
            var gameView = segue.destinationViewController as GameViewController
            gameView.hero = Mario()
        } else if segue.identifier == "GameStartLeftMan" {
            println("Leftman")
            var gameView = segue.destinationViewController as GameViewController
            gameView.hero = Hero()
            
        } else {
            println("none")
        }
    }


}
