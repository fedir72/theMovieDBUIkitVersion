//
//  ViewController.swift
//  ourApp
//
//  Created by Fedii Ihor on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
   // var colors: [UIColor] = [.yellow,.brown,.blue]
    
    var state = false
    
    @IBOutlet weak var someView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonDidPressed(_ sender: Any) {

        if someView.backgroundColor == .black {
            someView.backgroundColor = .green
        }else{
            someView.backgroundColor = .red
        }
    }
    
}

