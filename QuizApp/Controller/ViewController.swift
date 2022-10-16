//
//  ViewController.swift
//  QuizApp
//
//  Created by mert polat on 19.09.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var ChoiceButton4: UIButton!
    @IBOutlet weak var ChoiceButton3: UIButton!
    @IBOutlet weak var ChoiceButton2: UIButton!
    @IBOutlet weak var ChoiceButton1: UIButton!
    @IBOutlet weak var QuestionTextView: UITextView!
    
    var quizMangager = QuizManager()
    var score = 0
    var theQuiz: QuizModel?
    
   
    @IBAction func OptionsButtonPressed(_ sender: UIButton) {
        guard let thisQuiz = theQuiz
        else { return }

        let btns: [UIButton] = [ChoiceButton1, ChoiceButton2, ChoiceButton3, ChoiceButton4]
        btns.forEach { btn in
            btn.isUserInteractionEnabled = false
        }
        var cfg = sender.configuration
        
        if let btnTitle = cfg?.title {

            if btnTitle == thisQuiz.correctAnswer {
                score += 1
                cfg?.baseForegroundColor = .systemGreen
            } else {
                cfg?.baseForegroundColor = .systemRed
            }
        }
        sender.configuration = cfg
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
        if quizMangager.index == quizMangager.maxQuestion - 1 {
            performSegue(withIdentifier: "goToResult", sender: self)

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToResult"{
                let destinationVC = segue.destination as! ResultViewController
                destinationVC.score = score
                destinationVC.maxQuestion = quizMangager.maxQuestion
            }
     }
    
    
    
    @objc func updateUI() {
        
        progressBar.progress = quizMangager.returnProgress()
        quizMangager.nextQuestion()
       quizMangager.performRequest()
        
        if quizMangager.index   ==  0 {
            print("score: \(score)")
            score = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionTextView.layer.cornerRadius = 15
        quizMangager.delegate = self
        quizMangager.performRequest()
        
        
        
        
        
        
    }
    
    
}

extension ViewController : QuizManagerDelegate{
    func didUpdateQuiz(quiz: QuizModel) {
        DispatchQueue.main.async { [self] in
            
            self.theQuiz = quiz
            
            let quizText = quiz.question
            
            print("before: \(quizText)")

            
            var newQuizText = quizMangager.delateTrash1(quest: quizText)
            newQuizText = quizMangager.delateTrash2(quest: newQuizText)
            
            print("after: \(newQuizText)")

            self.QuestionTextView.text = newQuizText

            var allOptions: [String] = []
            allOptions.append(quiz.falseAnswer[0])
            allOptions.append(quiz.falseAnswer[1])
            allOptions.append(quiz.falseAnswer[2])
            allOptions.append(quiz.correctAnswer)
            
            let generatedValue = Array(allOptions.shuffled().prefix(4))
//            print(generatedValue)
//            print(quiz.correctAnswer)

            let btns: [UIButton] = [ChoiceButton1, ChoiceButton2, ChoiceButton3, ChoiceButton4]
            for (str, btn) in zip(generatedValue, btns) {
                
                var cfg = btn.configuration
                cfg?.baseForegroundColor = .white
                cfg?.title = str
                btn.configuration = cfg
                btn.isUserInteractionEnabled = true
            }
        }
    }
}
