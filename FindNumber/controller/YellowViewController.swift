//
//  YellowViewController.swift
//  FindNumber
//
//  Created by Kirill Bereznev on 24/5/24.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("YellowViewControll viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("YellowViewControll viewWillAppear")
    }
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("YellowViewControll viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("YellowViewControll viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("YellowViewControll viewDidDisappear")
    }
    @IBAction func goToBlueController(_ sender: UIButton) {
        performSegue(withIdentifier: "goToBlue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToBlue":
            if let blueVc = segue.destination as? BlueViewController{
                if let string =  sender as?  String{
                    blueVc.textForLabel = "Test string"
                }
            }
            
        default:
            break
        }
    }

}
