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
  var gameStartSound: SystemSoundID = 0
  var correctAnswerSound: SystemSoundID = 1
  var incorrectAnswerSound: SystemSoundID = 2

  @IBOutlet weak var questionField: UILabel!
  @IBOutlet weak var playAgainButton: UIButton!

  enum AnswerButtons: Int {
    case buttonOne, buttonTwo, buttonThree, buttonFour
  }

  @IBOutlet weak var buttonOne: UIAnswerButton!
  @IBOutlet weak var buttonTwo: UIAnswerButton!
  @IBOutlet weak var buttonThree: UIAnswerButton!
  @IBOutlet weak var buttonFour: UIAnswerButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupInitialGameState()
  }

  @IBAction func checkAnswer(sender: UIAnswerButton) {
    updateQuestionLabelWithResultOfAnswer(atIndex: sender.index)
    disableAllAnswerButtons()
    highlightCorrectAnswerButton()
    loadNextRoundWithDelay(seconds: 2)
  }

  @IBAction func playAgain() {
    playGameSound(gameStartSound)
    questionModel.reset()
    playAgainButton.hidden = true
    nextRound()
  }

  // MARK: Private Methods

  private func setupInitialGameState() {
    if let pathToGameStartSoundFile = NSBundle.mainBundle().pathForResource("GameStartSound", ofType: "wav") {
      loadGameSound(pathToSoundFile: pathToGameStartSoundFile, systemSound: &gameStartSound)
      playGameSound(gameStartSound)
    }

    if let pathToCorrectAnswerSoundFile = NSBundle.mainBundle().pathForResource("CorrectAnswerSound", ofType: "wav") {
      loadGameSound(pathToSoundFile: pathToCorrectAnswerSoundFile, systemSound: &correctAnswerSound)
    }

    if let pathToIncorrectAnswerSoundFile = NSBundle.mainBundle().pathForResource("IncorrectAnswerSound", ofType: "wav") {
      loadGameSound(pathToSoundFile: pathToIncorrectAnswerSoundFile, systemSound: &incorrectAnswerSound)
    }

    playAgainButton.hidden = true
    displayQuestion(questionModel.getNewQuestion())
  }

  private func loadGameSound(pathToSoundFile file: String, inout systemSound: SystemSoundID) {
    let soundURL = NSURL(fileURLWithPath: file)
    AudioServicesCreateSystemSoundID(soundURL, &systemSound)
  }

  private func playGameSound(systemSound: SystemSoundID) {
    AudioServicesPlaySystemSound(systemSound)
  }

  private func displayQuestion(question: Question) {
    hideAllAnswerButtons()
    
    questionField.text = question.displayText
    
    for (index, answer) in question.answers.enumerate() {
      if let answerButtonType = AnswerButtons(rawValue: index) {
        let button = answerButton(byType: answerButtonType)
        
        button.setTitle(answer, forState: UIControlState.Normal)
        button.enabled = true
        button.hidden = false
      }
    }
  }

  private func updateQuestionLabelWithResultOfAnswer(atIndex index: Int) {
    if (questionModel.handleAnswer(atIndex: index)) {
      playGameSound(correctAnswerSound)
      questionField.text = "Correct!"
    } else {
      playGameSound(incorrectAnswerSound)
      questionField.text = "Sorry, wrong answer!"
    }
  }

  private func disableAllAnswerButtons() {
    for button in allAnswerButtons() {
      button.enabled = false
    }
  }

  private func hideAllAnswerButtons() {
    for button in allAnswerButtons() {
      button.hidden = true
    }
  }

  private func highlightCorrectAnswerButton() {
    let correctIndex = questionModel.indexOfCorrectAnswerForSelectedQuestion()
    
    if let answerButtonType = AnswerButtons(rawValue: correctIndex) {
      answerButton(byType: answerButtonType).enabled = true
    }
  }

  private func allAnswerButtons() -> [UIAnswerButton] {
    return [buttonOne, buttonTwo, buttonThree, buttonFour]
  }

  private func displayScore() {
    hideAllAnswerButtons()
    playAgainButton.hidden = false
    questionField.text = questionModel.displayableResults()
  }

  private func nextRound() {
    if questionModel.isGameOver() {
      playAgainButton.hidden = false
      displayScore()
    } else {
      displayQuestion(questionModel.getNewQuestion())
    }
  }

  private func loadNextRoundWithDelay(seconds seconds: Int) {
    let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
    
    dispatch_after(dispatchTime, dispatch_get_main_queue()) {
      self.nextRound()
    }
  }

  private func answerButton(byType type: AnswerButtons) -> UIButton {
    switch type {
      case .buttonOne: return buttonOne
      case .buttonTwo: return buttonTwo
      case .buttonThree: return buttonThree
      case .buttonFour: return buttonFour
    }
  }
}