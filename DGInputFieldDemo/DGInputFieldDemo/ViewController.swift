//
//  ViewController.swift
//  DGInputFieldDemo
//
//  Created by Dmitry Grebenschikov on 31/01/2018.
//  Copyright © 2018 dd-team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var creditCardField: DGInputField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let configuration = TextFieldConfiguration(
            formatter: CardNumberFormatter(),
            validator: CardNumberInputValidator())
        creditCardField.setConfiguration(configuration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

