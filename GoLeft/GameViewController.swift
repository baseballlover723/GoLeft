import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var hero : SuperCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(hero!)
        let scene = GameScene(size: view.bounds.size, hero: hero!)
        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        scene.viewController = self
        navigationController?.navigationBarHidden = true
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}