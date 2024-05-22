//
//  GameViewController.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 22/5/24.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var Button: [UIButton]!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var timerLabel: UILabel!
    
    
    lazy var  game = Game(countItems: Button.count, time: 30) { [weak self] (status, second) in
        
        guard let self = self else {return}
        
        self.timerLabel.text = "\(second)"
        self.updateInfoGame(with: status)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupeScreen()
    }
    
  
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = Button.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        updateUI()
    }
    
    private func setupeScreen(){
        
        for index in game.items.indices{
            Button[index].setTitle(game.items[index].title, for: .normal)
            Button[index].isHidden = false
        }
        
        title()
    }
    
    private func updateUI(){
        for index in game.items.indices{
            Button[index].isHidden = game.items[index].isFound
        }
        title()
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
        case .win:
            statusLabel.text = "Вы выйграли"
            statusLabel.textColor = .green
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
        }
    }
    
    private func title(){
        nextDigit.text = game.nextItem?.title
    }
}
