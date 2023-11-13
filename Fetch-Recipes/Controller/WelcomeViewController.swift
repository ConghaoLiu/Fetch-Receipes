//
//  WelcomeViewController.swift
//  Fetch-Recipes
//
//  Created by Conghao Liu on 11/12/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    let welcomeText = "🍔Recipes"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var letterIdx = 0.0
        titleLabel.text = ""
        
        for letter in welcomeText{
            Timer.scheduledTimer(withTimeInterval: 0.1*letterIdx, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            letterIdx += 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.transitionToNextScene()
        }

    }
    
    func transitionToNextScene(){
        performSegue(withIdentifier: "GoToMain", sender: self)
    }
    
    


}
