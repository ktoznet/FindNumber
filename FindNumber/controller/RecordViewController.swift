//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 28/5/24.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        
        if record != 0{
            recordLabel.text = "Your record - \(record)"
        }else{
            recordLabel.text = "not have record"
        }
    }
    

    @IBAction func closeVS(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
}
