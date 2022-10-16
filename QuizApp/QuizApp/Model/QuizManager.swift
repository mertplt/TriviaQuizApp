//
//  QuizManager.swift
//  QuizApp
//
//  Created by mert polat on 19.09.2022.
//

import Foundation

protocol quizManagerDelegate {
    func didUpdateQuiz(_ Quizmanager: QuizManager ,quiz: QuizModel)
}

struct QuizManager {
    
    var index : Int  = 0
    var maxQuestion = 14

    
    mutating func nextQuestion(result: Bool) -> Int{
        if result == true{
          return  index + 1
        } else {
            return index
        }
        
    }
    

    
    var delegate: quizManagerDelegate?
    
    func performRequest(){
        
         let urlString = "https://opentdb.com/api.php?amount=15&type=multiple"        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in

                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                                        
                    if let quiz = self.parseJSON(quizdata: safeData){
                        delegate?.didUpdateQuiz(self, quiz: quiz)
                        

                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        
        
    }
    
    func parseJSON(quizdata: Data) -> QuizModel? {
        
        let decoder = JSONDecoder()
        
        do{
            
            let decodedData = try decoder.decode(Welcome.self, from: quizdata)
            
            let correct = decodedData.results?[index].correct_answer ?? "error"
            let quest = decodedData.results?[index].question ?? "error"
            let incorrect = decodedData.results?[index].incorrect_answers ?? ["error"]
            let question = QuizModel(correctAnswer: correct, question: quest, falseAnswer: incorrect)
     
            return question
        } catch {
            print(error)
            return nil
        }
    }
    
    mutating func nextQuestion(){
        
        if index + 1 < maxQuestion {
            index += 1
        }else {
            index = 0
            
        }
    }

}
