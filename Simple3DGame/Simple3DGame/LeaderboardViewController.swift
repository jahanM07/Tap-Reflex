//
//  LeaderboardViewController.swift
//  Simple3DGame
//
//  Created by Juhel on 13/06/2020.
//  Copyright © 2020 Juhel Miah. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    
    
    @IBOutlet weak var topScoreLabel: UILabel!
    
    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        goBackButton.layer.borderColor = UIColor.systemTeal.cgColor
        goBackButton.layer.borderWidth = 2
        goBackButton.layer.cornerRadius = 5
        
        if isKeyPresentInUserDefaults(key: "TopScore") == true {
            topScoreLabel.text = "\(UserDefaults.standard.integer(forKey: "TopScore")) Tap Streak"
        } else {
            topScoreLabel.text = "0 Tap Streak"
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
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
