//
//  HowToPlayViewController.swift
//  Simple3DGame
//
//  Created by Juhel on 12/06/2020.
//  Copyright © 2020 Juhel Miah. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController {
    
    
    @IBOutlet weak var goBackButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        goBackButtonOutlet.layer.borderColor = UIColor.systemTeal.cgColor
        goBackButtonOutlet.layer.borderWidth = 2
        goBackButtonOutlet.layer.cornerRadius = 5
        
    }
    
    
    @IBAction func goBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
