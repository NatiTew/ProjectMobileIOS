//
//  SpaceGameViewController.swift
//  MyPet
//
//  Created by Tanawadee Supraphakorn on 9/8/18.
//  Copyright © 2018 Natthaphon. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SpaceGameViewController: UIViewController {
    
    //@IBOutlet weak var spaceView: SKView!
    //var scene:spaceScene?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "spaceScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill



                // Present the scene
                view.presentScene(scene)

            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }

        //self.scene = spaceScene(size: CGSize(width: self.spaceView.frame.size.width, height: self.spaceView.frame.size.height))
        // Do any additional setup after loading the view.
        
        //scene?.scaleMode = .aspectFill
        //self.spaceView.presentScene(scene)
        //self.spaceView.ignoresSiblingOrder = true
        //self.spaceView.showsFPS = true
        //self.spaceView.showsNodeCount = true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
