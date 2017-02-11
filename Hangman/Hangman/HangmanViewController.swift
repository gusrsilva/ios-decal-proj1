//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    let alphabetString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    @IBOutlet weak var hangManImage: UIImageView!
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var currentPhraseLabel: UILabel!
    
    var currentGuessButton: UIButton!
    var currentGuess: String!
    var incorrectGuesses = [String]()
    var correctGuesses: [String] = [" "]
    var disabledButtons = [UIButton]()

    var phrase: String = HangmanPhrases().getRandomPhrase()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        disableGuessButton()
        updatePhraseUI()
        updateIncorrectGuessesUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func userDidPressLetter(_ sender: UIButton) {
        currentGuess = getLetterFromIndex(sender.tag)
        currentGuessButton = sender
        if let guess = currentGuess {
            guessButton.isEnabled = true
            guessButton.alpha = 1.0
            guessButton.setTitle("Guess \(guess)", for: .normal)
        }
    }

    @IBAction func userDidPressGuess(_ sender: UIButton) {
        sender.setTitle("Guess", for: .normal)
        if let letter = currentGuess {
            if phrase.contains(letter) {
                correctGuesses.append(letter)
                updatePhraseUI()
            }
            else {
                incorrectGuesses.append(letter)
                updateIncorrectGuessesUI()
            }
            currentGuessButton.isEnabled = false
            disabledButtons.append(currentGuessButton)
            disableGuessButton()
            endGameIfNecessary()
        }
    }
    
    func getLetterFromIndex(_ pos: Int) -> String {
        return String(alphabetString[alphabetString.index(alphabetString.startIndex, offsetBy: pos)])
    }
    
    func updateIncorrectGuessesUI() -> Void {
        let formattedStr = incorrectGuesses.joined(separator: ", ")
        incorrectGuessesLabel.text = "Incorrect Guesses: \(formattedStr)"
        hangManImage.image = UIImage(named: "hangman\(incorrectGuesses.count + 1)")
    }
    
    func disableGuessButton() -> Void {
        guessButton.isEnabled = false
        guessButton.alpha = 0.15
        guessButton.setTitle("Select A Letter", for: .normal)
    }
    
    func updatePhraseUI() -> Void {
        var newPhraseArray = [String]()
        for char in phrase.characters {
            if correctGuesses.contains(String(char)) {
                newPhraseArray.append(String(char))
            }
            else {
                newPhraseArray.append("-")
            }
        }
        currentPhraseLabel.text = newPhraseArray.joined(separator: " ")
    }
    
    func endGameIfNecessary() -> Void {
        if(incorrectGuesses.count >= 6) {
            // User Lost
            showGameOverAlert(didWin: false)
            return
        }
        
        if let currentPhrase = currentPhraseLabel.text {
            if !currentPhrase.contains("-") {
                showGameOverAlert(didWin: true)
                return
            }
        }
    }
    
    func showGameOverAlert(didWin: Bool) -> Void {
        let alertTitle = (didWin ? "Nice!": "Aww man!")
        let alertMessage = (didWin ? "You correctly guessed the phrase!": "You weren't able to guess the phrase: \(phrase)")
        
        let alert: UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { action in
            switch action.style{
            default:
                self.startNewGame()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func startNewGame() -> Void {
        for button in disabledButtons {
            button.isEnabled = true
        }
        currentGuessButton = nil
        currentGuess = nil
        incorrectGuesses = [String]()
        correctGuesses = [" "]
        disabledButtons = [UIButton]()
        phrase = HangmanPhrases().getRandomPhrase()
        viewDidLoad()
    }
}
