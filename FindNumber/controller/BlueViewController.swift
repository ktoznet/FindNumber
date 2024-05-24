//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 24/5/24.
//

import UIKit

class BlueViewController: UIViewController {
    @IBOutlet weak var testLabel: UILabel!
    var textForLabel =  ""
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel

    }
    @IBAction func goToGreen(_ sender: Any) {
        let storybord = UIStoryboard(name: "Main",bundle: nil)
        let vc = storybord.instantiateViewController(withIdentifier: "greenVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
