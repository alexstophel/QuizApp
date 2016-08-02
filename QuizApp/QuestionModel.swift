//
//  QuestionModel.swift
//  QuizApp
//
//  Created by Alex Stophel on 8/1/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import GameKit

class QuestionModel {
    let questionsPerRound: Int = 4

    let bank: [Question] = [
        Question(
            displayText: "Only female koalas can whistle",
            answers: ["True", "False"],
            indexOfCorrectAnswer: 1
        ),
        
        Question(
            displayText: "Blue whales are technically whales",
            answers: ["True", "False"],
            indexOfCorrectAnswer: 0
        ),
        
        Question(
            displayText: "Camels are cannibalistic",
            answers: ["True", "False"],
            indexOfCorrectAnswer: 1
        ),
        
        Question(
            displayText: "All ducks are birds",
            answers: ["True", "False"],
            indexOfCorrectAnswer: 0
        ),
        
        Question(
            displayText: "This was the only US President to serve more than two consecutive terms.",
            answers: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
            indexOfCorrectAnswer: 1
        ),
        
        Question(
            displayText: "Which of the following countries has the most residents?",
            answers: ["Nigeria", "Russia", "Iran", "Vietnam"],
            indexOfCorrectAnswer: 0
        ),
        
        Question(
            displayText: "In what year was the United Nations founded?",
            answers: ["1918", "1919", "1945", "1954"],
            indexOfCorrectAnswer: 2
        ),
        
        Question(
            displayText: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
            answers: ["Paris", "Washington D.C.", "New York City", "Boston"],
            indexOfCorrectAnswer: 2
        ),
        
        Question(
            displayText: "Which nation produces the most oil?",
            answers: ["Iran", "Iraq", "Brazil", "Canada"],
            indexOfCorrectAnswer: 3
        ),
        
        Question(
            displayText: "Which country has most recently won consecutive World Cups in Soccer?",
            answers: ["Italy", "Brazil", "Argetina", "Spain"],
            indexOfCorrectAnswer: 1
        ),
        
        Question(
            displayText: "Which of the following rivers is longest?",
            answers: ["Yangtze", "Mississippi", "Congo", "Mekong"],
            indexOfCorrectAnswer: 1
        ),
        
        Question(
            displayText: "Which city is the oldest?",
            answers: ["Mexico City", "Cape Town", "San Juan", "Sydney"],
            indexOfCorrectAnswer: 0
        ),
        
        Question(
            displayText: "Which country was the first to allow women to vote in national elections?",
            answers: ["Poland", "United States", "Sweden", "Senegal"],
            indexOfCorrectAnswer: 0
        ),
        
        Question(
            displayText: "Which of these countries won the most medals in the 2012 Summer Games?",
            answers: ["France", "Germany", "Japan", "Great Britian"],
            indexOfCorrectAnswer: 3
        ),
    ]
    
    
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    func getNewQuestion() -> Question {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(bank.count)
        return bank[indexOfSelectedQuestion]
    }
    
    func reset() {
        questionsAsked = 0
        correctQuestions = 0
    }
    
    func isGameOver() -> Bool {
        return questionsAsked == questionsPerRound
    }
    
    func getSelectedQuestion() -> Question {
        return bank[indexOfSelectedQuestion]
    }
    
    func incrementCorrectQuestions() {
        correctQuestions += 1
    }
    
    func incrementQuestionsAsked() {
        questionsAsked += 1
    }
    
    func displayableResults() -> String {
        return "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
}
