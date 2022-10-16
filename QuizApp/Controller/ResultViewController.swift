//
//  ResultViewController.swift
//  QuizApp
//
//  Created by mert polat on 9.10.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    var VC = ViewController()
    var quizManager = QuizManager()
    
    @IBOutlet weak var ScoreLabel: UILabel!
    var score : Int = 0
    var maxQuestion : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScoreLabel.text = "Your Score: \(score)/\(maxQuestion) "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated )
    }
    
    @IBAction func TryAgainPressed(_ sender: UIButton) {
        
        quizManager.index = 0
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
}
