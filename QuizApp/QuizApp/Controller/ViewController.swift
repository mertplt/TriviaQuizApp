//
//  ViewController.swift
//  QuizApp
//
//  Created by mert polat on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {
 
    
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ChoiceButton4: UIButton!
    @IBOutlet weak var ChoiceButton3: UIButton!
    @IBOutlet weak var ChoiceButton2: UIButton!
    @IBOutlet weak var ChoiceButton1: UIButton!
    @IBOutlet weak var QuestionTextView: UITextView!
    
    var quizMangager = QuizManager()
    var score = 0
    
    var theQuiz: QuizModel?
   
    @IBAction func OptionsButtonPressed(_ sender: UIButton) {
        
        guard let thisQuiz = theQuiz,
                  let btnTitle = sender.currentTitle
            else { return }
            
            if btnTitle == thisQuiz.correctAnswer {
                score += 1
                ScoreLabel.text = "SCORE: \(score)"
                quizMangager.nextQuestion()
                
                sender.setTitleColor(.systemGreen, for: [])
                
            } else {
                sender.setTitleColor(.systemRed, for: [])
                quizMangager.nextQuestion()
            }
        
        Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
        QuestionTextView.text = thisQuiz.question	
        
    }
    
    @objc func updateUI() {
    
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionTextView.layer.cornerRadius = 15
        quizMangager.delegate = self
        quizMangager.performRequest()
    }

}

extension ViewController : quizManagerDelegate{
    func didUpdateQuiz(_ Quizmanager: QuizManager, quiz: QuizModel) {
        DispatchQueue.main.async { [self] in
            
            self.theQuiz = quiz

            self.QuestionTextView.text = quiz.question

            var allOptions = []
            allOptions.append(quiz.falseAnswer[0])
            allOptions.append(quiz.falseAnswer[1])
            allOptions.append(quiz.falseAnswer[2])
            allOptions.append(quiz.correctAnswer)
            
            let generatedValue = Array(allOptions.shuffled().prefix(4))
            print(generatedValue)
            print(quiz.correctAnswer)

            ChoiceButton1.setTitle(generatedValue[0] as? String, for: .normal)
            ChoiceButton2.setTitle(generatedValue[1] as? String, for: .normal)
            ChoiceButton3.setTitle(generatedValue[2] as? String, for: .normal)
            ChoiceButton4.setTitle(generatedValue[3] as? String, for: .normal)
        }
    }
}


