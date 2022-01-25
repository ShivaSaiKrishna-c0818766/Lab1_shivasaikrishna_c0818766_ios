//
//  ViewController.swift
//  Lab1_shivasaikrishna_c0818766_ios
//
//  Created by user204499 on 1/17/22.
//

import UIKit

class ViewController: UIViewController
{
    enum Turn{
        case Nought
        case Cross
    }

    @IBOutlet weak var turnL: UILabel!
    
    @IBOutlet weak var r1c1: UIButton!
    @IBOutlet weak var r1c2: UIButton!
    @IBOutlet weak var r1c3: UIButton!
    @IBOutlet weak var r2c1: UIButton!
    @IBOutlet weak var r2c2: UIButton!
    
    @IBOutlet weak var r2c3: UIButton!
    @IBOutlet weak var r3c1: UIButton!
    @IBOutlet weak var r3c2: UIButton!
    @IBOutlet weak var r3c3: UIButton!
    
    var firstChance = Turn.Cross
    var currentChance = Turn.Cross
    
    var nought = "O"
    var cross = "X"
    var gameBoard = [UIButton]()
    
    var xPoints = 0
    var oPoints = 0
    
    
    
    
    override func viewDidLoad()
    {

        super.viewDidLoad()
        self.becomeFirstResponder()
        initialBoard()
    }
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
        
            for btn in gameBoard
            {
            
                btn.setTitle("", for: .normal)
                btn.isEnabled = true
                }
                
            
            if firstChance == Turn.Nought
            {
                firstChance = Turn.Cross
                turnL.text = cross
            }
            else if firstChance == Turn.Cross
            {
                firstChance = Turn.Nought
                turnL.text = nought
            }
            currentChance = firstChance
    }
    }
        func initialBoard()
        {
            gameBoard.append(r1c1)
            gameBoard.append(r1c2)
            gameBoard.append(r1c3)
            gameBoard.append(r2c1)
            gameBoard.append(r2c2)
            gameBoard.append(r2c3)
            gameBoard.append(r3c1)
            gameBoard.append(r3c2)
            gameBoard.append(r3c3)
        }
        // Do any additional setup after loading the view.
    
    

    @IBAction func tap(_ sender: UIButton)
    {
        addtoBoard(sender)
        if checkForWin(cross)
        {
            xPoints += 1
            resultNote(title: "Crosses Win!")
        }
        
        if checkForWin(nought)
        {
            oPoints += 1
            resultNote(title: "Noughts Win!")
        }
        if(completeBoard())
        {
            resultNote(title: "Draw")
        }
        
    }
    
    func checkForWin(_ s :String) -> Bool
    {
        // Horizontal Victory
        if thisSymbol(r1c1, s) && thisSymbol(r1c2, s) && thisSymbol(r1c3, s)
        {
            return true
        }
        if thisSymbol(r2c1, s) && thisSymbol(r2c2, s) && thisSymbol(r2c3, s)
        {
            return true
        }
        if thisSymbol(r3c1, s) && thisSymbol(r3c2, s) && thisSymbol(r3c3, s)
        {
            return true
        }
        
        // Vertical Victory
        if thisSymbol(r1c1, s) && thisSymbol(r2c1, s) && thisSymbol(r3c1, s)
        {
            return true
        }
        if thisSymbol(r1c2, s) && thisSymbol(r2c2, s) && thisSymbol(r3c2, s)
        {
            return true
        }
        if thisSymbol(r1c3, s) && thisSymbol(r2c3, s) && thisSymbol(r3c3, s)
        {
            return true
        }
        
        // Diagonal Victory
        if thisSymbol(r1c1, s) && thisSymbol(r2c2, s) && thisSymbol(r3c3, s)
        {
            return true
        }
        if thisSymbol(r1c3, s) && thisSymbol(r2c2, s) && thisSymbol(r3c1, s)
        {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
       
    
    func resultNote(title: String)
    {
        let message = "\nNoughts " + String(oPoints) + "\n\nCrosses " + String(xPoints)
        let alertN = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertN.addAction(UIAlertAction(title: "New Game", style: .default, handler: { (_) in
            self.newBoard()
        }))
        self.present(alertN, animated: true)
        
    }
    func newBoard()
    {
        for btn in gameBoard
        {
            btn.setTitle(nil, for: .normal)
            btn.isEnabled = true
        }
        if firstChance == Turn.Nought
        {
            firstChance = Turn.Cross
            turnL.text = cross
        }
        else if firstChance == Turn.Cross
        {
            firstChance = Turn.Nought
            turnL.text = nought
        }
        currentChance = firstChance
    }
    func completeBoard() -> Bool
    {
        for btn in gameBoard
        {
            if btn.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    func addtoBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentChance == Turn.Nought)
            {
                sender.setTitle(nought, for: .normal)
                currentChance = Turn.Cross
                turnL.text = cross
            }
           else if(currentChance == Turn.Cross)
            {
                sender.setTitle(cross, for: .normal)
                currentChance = Turn.Nought
                turnL.text = nought
            }
            sender.isEnabled = false
        }
        
    }
}


