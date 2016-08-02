//
//  Question.swift
//  QuizApp
//
//  Created by Alex Stophel on 8/1/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

protocol Questionable {
    var displayText: String { get }
    var answers: [String] { get }
    var indexOfCorrectAnswer: Int { get }
    
    init(displayText: String, answers: [String], indexOfCorrectAnswer: Int)
    
    func isCorrectAnswer(atIndex index: Int) -> Bool
}

struct Question: Questionable {
    let displayText: String
    let answers: [String]
    let indexOfCorrectAnswer: Int
    
    init(displayText: String, answers: [String], indexOfCorrectAnswer: Int) {
        self.displayText = displayText
        self.answers = answers
        self.indexOfCorrectAnswer = indexOfCorrectAnswer
    }
    
    func isCorrectAnswer(atIndex index: Int) -> Bool {
        return indexOfCorrectAnswer == index
    }
}