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
    
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var  game = Game(countItems: Button.count) { [weak self] (status, second) in
        
        guard let self = self else {return}
        
        self.timerLabel.text = second.secondToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if navigationController == nil {
                   print("Этот контроллер не встроен в UINavigationController.")
               } else {
                   print("Этот контроллер встроен в UINavigationController.")
               }
        setupeScreen()
    }
    
  
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = Button.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        updateUI()
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupeScreen()
    }
    
    private func setupeScreen(){
        
        for index in game.items.indices{
            Button[index].setTitle(game.items[index].title, for: .normal)
            Button[index].alpha =  1
            Button[index].isEnabled = true
        }
        
        title()
    }
    
    private func updateUI(){
        for index in game.items.indices{
            Button[index].alpha = game.items[index].isFound ? 0 : 1
            Button[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3) {[weak self] in
                    self?.Button[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.Button[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        title()
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden =  true
        case .win:
            statusLabel.text = "Вы выйграли"
            statusLabel.textColor = .green
            newGameButton.isHidden =  false
            if game.isNewRecord{
                showAlert()
            }else{
                showAlertActionSheet()
            }
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden =  false 
            showAlertActionSheet()
        }
    }
    
    private func title(){
        nextDigit.text = game.nextItem?.title
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "Поздравляем", message: "Вы установили рекорд", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "OK", style: .default,handler: nil)
        
        alert.addAction(okayAction)
        present(alert,animated: true,completion: nil)
    }
    
    private func showAlertActionSheet(){
        let alert = UIAlertController(title: "Что вы хотите", message: nil,preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Новая игра", style: .default){ [weak self](_) in
            self?.game.newGame()
            self?.setupeScreen()
        }
        let showRecord = UIAlertAction(title: "Check Record", style: .default){ [weak self](_) in
            self?.performSegue(withIdentifier: "recordVC", sender: nil)
        }
        
        let menuAction = UIAlertAction(title: "Перейти в меню", style: .destructive){ [weak self] (_) in
            if let navigationController = self?.navigationController {
                        navigationController.popViewController(animated: true)
                    } else {
                        print("Navigation controller is nil")
                    }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
        
        alert.addAction(newGameAction)
        alert.addAction(showRecord)
        alert.addAction(menuAction)
        alert.addAction(cancelAction)
        
        if let popover = alert.popoverPresentationController{
            popover.sourceView = statusLabel
        }
        present(alert,animated: true, completion: nil)
    }

}
