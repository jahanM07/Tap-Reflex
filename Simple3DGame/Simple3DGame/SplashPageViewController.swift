//
//  SplashPageViewController.swift
//  Simple3DGame
//
//  Created by Juhel on 13/06/2020.
//  Copyright © 2020 Juhel Miah. All rights reserved.
//

import UIKit
import Lottie

class SplashPageViewController: UIViewController {
    
    
    @IBOutlet weak var animationView1: AnimationView!
    
    @IBOutlet weak var animationView2: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView1.loopMode = .loop
        animationView1.animationSpeed = 1.0
        animationView1.play()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animationView2.loopMode = .loop
            self.animationView2.animationSpeed = 1.0
            self.animationView2.play()
        }

        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
