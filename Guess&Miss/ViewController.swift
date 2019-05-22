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

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func makeGuess(_ sender: NSButton) {
    
        let guess = textField.stringValue
        textField.stringValue = ""
        guesses.insert(guess, at: 0)
        tableView.reloadData()
    }
    
    fileprivate func startGame(){
        guesses.removeAll()
        var numbers = Array(0...9)
        numbers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]
        
        for _ in 0..<4{
            answer.append(String(numbers.removeLast()))
        }
        
        tableView.reloadData()
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
            
        }
        
        return view
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
}

