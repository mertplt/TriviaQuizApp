//
//  QuizData.swift
//  QuizApp
//
//  Created by mert polat on 19.09.2022.
//

    import Foundation


     // MARK: - Welcome
     struct Welcome: Codable {
     let results: [Result]?
     }
     
     // MARK: - Result
     struct Result: Codable {
         
     let category: String?
     let question, correct_answer: String?
     let incorrect_answers: [String]?
     }

 
 
