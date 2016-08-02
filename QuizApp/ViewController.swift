//
//  ViewController.swift
//  QuizApp
//
//  Created by Alex Stophel on 7/17/16.
//  Copyright © 2016 Alex Stophel. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var questionModel = QuestionModel()
    var gameSound: SystemSoundID = 0

    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    func displayQuestion() {
        let question = questionModel.getNewQuestion()
        
        questionField.text = question.displayText
        playAgainButton.hidden = true
        hideAnswerButtons()
        
        var answerIndex = 0
        for answer in question.answers {
            setupAnswerButton(atIndex: answerIndex, withText: answer)
            answerIndex += 1
        }
    }
    
    func hideAnswerButtons() {
        buttonOne.hidden = true
        buttonTwo.hidden = true
        buttonThree.hidden = true
        buttonFour.hidden = true
    }

    func displayScore() {
        hideAnswerButtons()
        
        playAgainButton.hidden = false
        
        questionField.text = questionModel.displayableResults()
    }

    @IBAction func checkAnswer(sender: UIButton) {
        questionModel.incrementQuestionsAsked()
        
        let selectedQuestion = questionModel.getSelectedQuestion()
        let selectedIndex = indexForButton(sender)
            
        if (selectedQuestion.isCorrectAnswer(atIndex: selectedIndex)) {
            questionModel.incrementCorrectQuestions()
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func indexForButton(sender: UIButton) -> Int {
        switch sender {
            case buttonOne: return 0
            case buttonTwo: return 1
            case buttonThree: return 2
            default: return 3
        }
    }

    func nextRound() {
        if questionModel.isGameOver() {
            displayScore()
        } else {
            displayQuestion()
        }
    }

    @IBAction func playAgain() {
        questionModel.reset()
        nextRound()
    }

    // MARK: Helper Methods

    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }

    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }

    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func setupAnswerButton(atIndex index: Int, withText text: String) {
        var button: UIButton
        
        switch index {
            case 0: button = buttonOne
            case 1: button = buttonTwo
            case 2: button = buttonThree
            default: button = buttonFour
        }
        
        button.setTitle(text, forState: UIControlState.Normal)
        button.hidden = false
    }
    
}