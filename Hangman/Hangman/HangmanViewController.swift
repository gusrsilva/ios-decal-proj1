//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet weak var hangManImage: UIImageView!
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var currentPhraseLabel: UILabel!
    
    var currentGuessButton: UIButton!
    var currentGuess: String!
    var incorrectGuesses = [String]()
    var correctGuesses: [String] = [" "]

    var phrase: String = HangmanPhrases().getRandomPhrase()
    
    let alphabetString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        disableGuessButton()
        updatePhraseUI()
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
        hangManImage.image = #imageLiteral(resourceName: "hangman2")
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
            disableGuessButton()
        }
    }
    
    func getLetterFromIndex(_ pos: Int) -> String {
        return String(alphabetString[alphabetString.index(alphabetString.startIndex, offsetBy: pos)])
    }
    
    func updateIncorrectGuessesUI() -> Void {
        let formattedStr = incorrectGuesses.joined(separator: ", ")
        incorrectGuessesLabel.text = "Incorrect Guesses: \(formattedStr)"
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
}
