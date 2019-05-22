//
//  ViewController.swift
//  Guess&Miss
//
//  Created by David Ilenwabor on 13/05/2019.
//  Copyright © 2019 Davidemi. All rights reserved.
//

import Cocoa
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var button: NSButton!
    
    var guesses : [String] = []
    fileprivate var answer : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func makeGuess(_ sender: NSButton) {
    
        let guess = textField.stringValue
        guard Set(guess).count == 4 else{
            return
        }
        
        let badChars = CharacterSet(charactersIn : "0123456789").inverted
        guard guess.rangeOfCharacter(from: badChars) == nil else{
            return
        }
        guesses.insert(guess, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        if result(for: guess).contains("4b"){
            let alert = NSAlert()
            alert.messageText = "You win!"
            alert.informativeText = "Congrats, click ok to play again."
            alert.runModal()
            startGame()
        }
    }
    
    fileprivate func startGame(){
        textField.stringValue = ""
        guesses.removeAll()
        var numbers = Array(0...9)
        answer = ""
        numbers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]
        
        for _ in 0..<4{
            answer.append(String(numbers.removeLast()))
        }
        
        tableView.reloadData()
    }
    
    fileprivate func result(for guess : String)->String{
        var bulls = 0
        var cows = 0
        
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetters.enumerated(){
            if letter == answerLetters[index]{
                bulls += 1
            } else if answerLetters.contains(letter){
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
}

extension ViewController : NSTableViewDelegate, NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else{
            return nil
        }
        if tableColumn?.title == "Guesses"{
            view.textField?.stringValue = guesses[row]
        } else{
            view.textField?.stringValue = result(for: guesses[row])
        }
        
        return view
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
}

