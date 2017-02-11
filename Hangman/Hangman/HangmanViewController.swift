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
    
    var currentGuessButton: UIButton!
    var currentGuessChar: Character!
    var incorrectGuesses = [String]()
    
    let alphabetString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
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
        currentGuessChar = getLetterFromIndex(sender.tag)
        currentGuessButton = sender
        if let guess = currentGuessChar {
            guessButton.setTitle("Guess \(guess)", for: .normal)
        }
    }

    @IBAction func userDidPressGuess(_ sender: UIButton) {
        sender.setTitle("Guess", for: .normal)
        if let letter = currentGuessChar {
            incorrectGuesses.append(String(letter))
            updateIncorrectGuessesUI()
        }
    }
    
    func getLetterFromIndex(_ pos: Int) -> Character {
        return alphabetString[alphabetString.index(alphabetString.startIndex, offsetBy: pos)]
    }
    
    func updateIncorrectGuessesUI() -> Void {
        let formattedStr = incorrectGuesses.joined(separator: ", ")
        incorrectGuessesLabel.text = "Incorrect Guesses: \(formattedStr)"
        currentGuessButton.isEnabled = false
    }
}
