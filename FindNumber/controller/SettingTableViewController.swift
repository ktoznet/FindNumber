//
//  SettingTableViewController.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 26/5/24.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "selectTimeVC":
            if let vc = segue.destination as?  SelectTimeViewController{
                vc.data = [10,20,30,40,50,60,70,80,90,100,110,120]
                
            }
            
        default:
            break
                
        }
    }

}
