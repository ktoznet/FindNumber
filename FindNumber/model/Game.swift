//
//  Game.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 22/5/24.
//

import Foundation

enum StatusGame{
    case start
    case win
    case lose
}

class Game{
    
    struct Item{
        var title: String
        var isFound:Bool = false
        
    }
    
    private let  data  = Array(1...99)
    
    var items:[Item] = []
    
    private var countItems:Int
    
    var nextItem:Item?
    
    var status:StatusGame = .start{
        didSet{
            if status != .start{
                stopGame()
            }
        }
    }
    
    private var timeForGame:Int{
        didSet{
            if timeForGame == 0 {
                status = .lose
            }
            updateTimer(status,timeForGame)
        }
    }
    
    private var timer:Timer?
    private var updateTimer:((StatusGame,Int)->())
    
    init(countItems: Int,time: Int, updateTimer:@escaping (_ status: StatusGame, _ second: Int)->()) {
        self.countItems = countItems
        self.timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
    
    private func setupGame(){
        var digits = data.shuffled()
        
        while items.count < countItems{
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.timeForGame -= 1
        })
    }
    
    func check(index: Int){
        if items[index].title == nextItem?.title{
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        if nextItem == nil{
            status = .win
        }
    }
    
    private func stopGame(){
        timer?.invalidate()
    }
}
